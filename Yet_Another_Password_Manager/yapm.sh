#!/bin/sh

# About : Password Manager
# Author: MinaSaad47
# Git: https://github.com/MinaSaad47/
#
# Disclamer!: 
# This is not well written shell script (as I hate writing one -_-).
# This is not convenient way to save your passwords
# use it at your own rish. 


VERSION=0.0.1

CONF_DIR=$HOME/.config/yapm
CONF=$CONF_DIR/yapm.conf
INPUT=$CONF_DIR/input

VAULT=NULL
HASH=NULL
LAUNCHER=NULL
PROMPT=NULL

help_menu()
{
        printf "Yet Another Password Manager\n"
        printf "\t--setup: setup the vault location and the encoding key (required for the first time)\n"
        printf "\t--encrypt: encrypt a password entered by dmenu or rofi\n"
        printf "\t--decrypt: decrypt a password chosen by dmenu or rofi then passed to clipboard\n"
}

about()
{
        msg=$(awk 'NR==3,/^\s*$/' $0 | sed 's/#//; $d') # Displays the above comments as info
        dialog --title "About" --msgbox "$msg" 15 80
}

init()
{
        VAULT=$(awk 'NR==1' $CONF)
        HASH=$(awk 'NR==2' $CONF)
        LAUNCHER=$(awk 'NR==3' $CONF)
        [ ! -f $VAULT ] && touch $VAULT
        [ $LAUNCHER = dmenu ] && PROMPT="dmenu -l 10 -fn -xos4-terminus-medium-r-*-*-16-*" || PROMPT="rofi -dmenu"
}

set_pass()
{
        dialog --title "Enter The Decyption Key" --insecure --passwordbox "Decyption Key" 0 0 2>$INPUT
        ans1=$(cat $INPUT)
        dialog --title "Enter The Decyption  Key" --insecure --passwordbox "Confirm The Decyption Key" 0 0 2>$INPUT
        ans2=$(cat $INPUT)
        rm -f $INPUT
        [ $ans1 != $ans2 ] && set_pass 
        printf "\n" >> $CONF
        printf "$ans2" | md5sum | cut -d ' ' -f 1 >> $CONF

}

set_laun()
{
        dialog --title "Launcher Selection" --menu "Choose password selection tool" 0 0 2 \
                dmenu "Suckless fast and lightweight dynamic menu for X" \
                rofi "window switcher, run dialog, ssh-launcher" 2>>$CONF
}

get_deps()
{
        dialog --title "Dependencies Installation" --menu "What is Your OS" 0 0 2 \
                apt "Debian Based" pacman "Arch Based" 2>$INPUT
        clear
        [ $(cat $INPUT) = "apt" ] && sudo apt install xclip $LAUNCHER -y || sudo pacman -S xclip $LAUNCHER
        rm -rf $INPUT
        clear
}

setup()
{
        [ ! -d $CONF_DIR ] && mkdir $CONF_DIR -p 
        [ ! -f $CONF ] && touch $CONF
        dialog --title "Select Vault Location (File !!!)" --fselect $HOME 12 50 2>$CONF
        set_pass
        set_laun
        init
        get_deps
        dialog --title "Congratulation!" --msgbox \
                "Now, you are good to go\n\nJust add shortcuts for:\n$0 --encrypt \n$0 --encrypt\nWith the absolute path of course ;)" 12 100
        clear
}

encrypt()
{

        passvalid=$(echo | $PROMPT -p "Password (Key): ")
        [ $(printf "$passvalid" | md5sum | cut -d ' ' -f 1) !=  $HASH ] && notify-send "Error" "Wrong Password" && exit 3
        name=$(echo | $PROMPT -p "Save as (name without white space): ")
        found=$(grep "^$name\s*" $VAULT)
        [ ! -z "$found" ] && notify-send "Error" "Already taken name" && exit 4
        password=$(echo | $PROMPT -p "Enter a Password to save: ")
        [ -z $password ] && notify-send "Error" "Empty Password" && exit 5
        encypted=$(printf "$password" | openssl aes-256-cbc -a -salt -pass pass:$passvaid 2>/dev/null)
        printf "$name    $encypted\n" >> $VAULT
        notify-send "Success" "Added one Password"
}


decrypt() 
{
        passvalid=$(echo | $PROMPT -p "Password (Key): ")
        [ $(printf "$passvalid" | md5sum | cut -d ' ' -f 1) !=  $HASH ] && notify-send "Error" "Wrong Password" && exit 3
        selection=$(awk '{ print $1 }' $VAULT | $PROMPT -p "Select a Profile")
        encypted=$(grep "^$selection\s*" $VAULT | awk ' {print $2} ')
        decrypted=$(printf "$encypted\n" | openssl aes-256-cbc -d -a -pass pass:$passvaid 2>/dev/null) 
        printf "$decrypted" | xclip -selection "clipboard"
        notify-send "Success" "Password Copied to clipboard"

}

case $1 in
        "--version")
                printf "Yet Another Password Manager\n"
                printf "\tVersion: $VERSION\n"
                ;;
        "--help")
                help_menu
                ;;
        "--setup")
                about
                setup $0
                ;;
        "--encrypt")
                init
                encrypt
                #
                ;;
        "--decrypt")
                init
                decrypt
                #
                ;;
        *)
                printf "Usage: %s <option>\n" $0 1>&2
                printf "For Example: %s --help\n" $0 1>&2
                exit 1
                ;;
esac

exit 0








              
                                    

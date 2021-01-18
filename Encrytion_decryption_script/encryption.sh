#!/bin/bash

echo "Welcome $(whoami) to the encryption/decryption script"

echo "Enter e if you want to encrypt a file or d if you want to decrypt"

read input

if [ $input == "e" ]
then
	echo "Enter the number of files you want to encrypt"

	read num 

     i=1

     while [ $i -le $num ]
     do
        echo "Enter The file number $i"

        read file1

        

        echo "Choose where do you want to save the file after encryption"

        read save1

        if [ $save1 == "." ]
        then
        	save1=$(pwd)
        fi

         gpg -o $save1/$i.gpg -c $file1

         echo "The file has been encrypted! and saved in [$save1/$i.gpg] "

         i=$[i+1]

     done
 else
 		echo "Enter the number of files you want to decrypt"

	read num1 

     j=1

     while [ $j -le $num1 ]
     do
        echo "Enter The file number $j"

        read file2

        

        echo "Choose where do you want to save the file after decryption"

        read save2

        if [ $save2 == "." ]
        then
        	save2=$(pwd)
        fi

         gpg -o $save2/$j.dec -d $file2 >/dev/null 2>&1

         echo "The file has been decrypted! and saved in [$save2/$j.dec] "

         j=$[j+1]

     done
fi

 
# Crack Shadow

Crack /etc/shadow using john the ripper tool

/etc/shadow file contains the passwords for the linux system users

## Dependencies

- John the ripper tool
  - install it on Ubuntu by using `sudo apt-get install john`

## Usage

1. Make sure you have read permission to /etc/shadow and /etc/passwd files
2. Run the script as following
   1. ./crack.sh [world list file path (Optional)]
3. you will find cracked passwords (if any) and info about what john did in \
   extractedPasswords.txt file
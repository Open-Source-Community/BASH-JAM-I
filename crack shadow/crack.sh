#!/bin/bash

if [[ -z $(command -v john) ]]
then
    echo "John The Ripper is not installed on your system, please install it and try again"
    exit
fi

if [[ ! -r /etc/shadow ]]
then
    echo "Can't Read /etc/shadow file"
    exit
fi

unshadow /etc/passwd /etc/shadow > mypasswd

if [[ -r "$1" ]]
then
    echo "decrypting with wordlist at $1"
    john --wordlist="$1" mypasswd
else
    john --single mypasswd
fi

john --show mypasswd > extractedPasswords.txt

rm mypasswd

#!/bin/bash
echo -e "Welcome $(whoami) to the word count script \n"

sleep 1

echo "Enter the number of files in which you want to count the words"

read num2


j=1

while [ $j -le $num2 ]
do

     echo -e "Enter the directory where the files exist \n"

     read ex

     if [ -z $ex ]

     then
     	echo "All the files inside your current directory are"

     	file * |tr "ASCII" "file" | tr -s e

              
     	count=$(file *|grep -c "directory")

     	if [ $count -ne 0 ]
     	then

     	read -p "There is $count directory(ies) to see the files inside them press 1: " nom

     	if [ $nom -eq 1 ]
     	then

        t=1

        while [ $t -le $nom ]
        do
        	echo -e "Enter the name of the directory number $t \n"

        	read dir

        	echo "The files inside the directory number $t is :"

        	file $dir/* |tr "ASCII" "file" | tr -s e
        	t=$[t+1]

        done
    fi


        fi     		

     	
     else
     	echo "All the files inside this directory are : "

     	file $ex/* |tr ASCII "file" | tr -s e

     	count1=$(file $ex/* |grep -c "directory")

     	if [ $count1 -ne 0 ]
     	then

     	read -p "There is $count1 directory(ies) to see the files inside them press 1 or 0 if you don't: " nom1

     	if [ $nom1 -eq 1 ]
     	then

        t=1

        while [ $t -le $nom1 ]
        do
        	echo -e "Enter the name of the directory number $t \n"

        	read dir

        	echo "The files inside the directory number $t is :"

        	file $dir/* |tr "ASCII" "file" | tr -s e
        	t=$[t+1]

        done
    fi


        fi     		

     	
     fi


    echo -e "\n"

     read -p "Enter the file number $j:" file1

     if [ -e $file1 ]
     then

 if [ -s $file1 ]
 then
     echo -e "Enter the directory where do you want to save the file number $j after sorting \n"

     read dir1

     words=$(grep -v '^$' $file1|tr " " "\n"|sort|uniq)

     grep -v '^$' $file1|tr " " "\n" |sort| grep -v '^$' > $dir1/file[$j].sorted

     
     for i in $words
     do
          
          
     num1=$(grep -c "$i" $dir1/file[$j].sorted)

     echo -e "The word \e[1;33m$i\e[0m exists \e[1;34m$num1\e[0m times in the file named [$file1] \n"

     done

     
     echo -e "The file named $file1 contains \e[1;34m$(cat $dir1/file[$j].sorted|wc -w)\e[0m words \n"

     echo -e "The file named $file1 contains \e[1;34m$(cat $dir1/file[$j].sorted|wc -c)\e[0m charachters \n"

     echo -e "All the words are sorted and stored in $dir1/file[$j].sorted \n"

 else
          echo "The file you have entered is empty"
fi

else 
     echo "The file you have entered does not exist"
fi

 j=$[j+1]

 sleep 1
done

echo "The program will be terminated in"

m=3
while [ $m -ge 1 ]
do
echo "$m"
sleep 1
m=$[m-1]
done

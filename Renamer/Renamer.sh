path=$1
init=$2

if [[ -z $path ]]
then
    echo -n "Please enter the path of the directory : " 
    read path
fi

if [[ -z $init ]]
then
    echo -n "Please enter initial name to rename the files : " 
    read init
fi

#relative path
abs=`grep "\/." <<< $path`
if [[ -z $abs ]]
then
    echo -n "WARNING : the path you've entered is relative so this directory must be located inside the current working directory"
    echo "Do you want to continue ? [y/n] "
    read res
    res=`grep -i "y" <<< $res`
    if [[ -z $res ]]
    then
        exit
    fi
fi

# check if the directory doesn't exist
if [[ ! -d $path ]]
then
    echo "This directory doesn't exist"
    exit
fi

cd $path
cnt=1

# check if the directory is empty
if [[ -z `ls` ]]
then
    echo "This directory is Empty"
    exit
fi

#iterate on the files in the directory
for file in `ls -tr`
do
    extension=`grep -oE "\.\w*\$" <<< "$file"`
    
    mv "$file" "$init""_""$cnt$extension"
    cnt=$(($cnt+1))
done





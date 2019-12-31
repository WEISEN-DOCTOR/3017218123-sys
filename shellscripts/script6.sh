#!/bin/bash

if [ $# -eq 0 ]
then
	echo "Usage: ./script6 filename ..."
	exit 0
fi

function delFile() 
{
	while [ $# -gt 0 ]
	do
		if [ -f $1 ]
		then
			`rm -f $1`
			if [ $? -eq 0 ]
			then
				echo "Successfully delete file $1"
			else
				echo "delete file $1 faile"
			fi
		elif [ -d $1 ]
		then
			echo "$1 is a directory, can not remove!"
		fi
		shift
	done
}

if [ $MAXFILES ] && [ $MAXFILES -lt $# ]
then
	read -p "Do you want to delete the $# files? y/n: " judge
	if [ $judge == y ]
	then
		delFile $*
	fi
else
	delFile $*
fi

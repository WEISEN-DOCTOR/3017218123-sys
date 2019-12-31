#!/bin/bash

function formatTable() 
{
	count=$1
	while [ $count -gt 0 ]
	do
		echo -n "│   "
		count=$(( $count - 1 ))
	done
}

function tree() 
{
	for item in $*
	do
		if [ $1 == $item ] || [ $2 == $item ]
		then
			continue
		fi

		formatTable $2
		if [ ${!#} == $item ]
		then
			echo "└── $item"
		else
			echo "├── $item"
		fi

		if [ -f $1/$item ]
		then
			fileCount=$(( $fileCount + 1 ))
		elif [ -d $1/$item ]
		then
			dirCount=$(( $dirCount + 1 ))
			tmp=`ls $1/$item`
			tree $1/$item $(( $2 + 1 )) $tmp
		fi
	done
}

if [ $# -eq 0 ]
then
	path="."
else
	if [ ! -d $1 ]
	then
		echo "$1 [error opening dir]"
		exit 0
	fi
	path=$1
fi

echo $path

if [[ $path == */ ]]
then
	path=${path%/*}
fi

fileCount=0
dirCount=0

tmp=`ls $path`
tree $path 0 $tmp

echo
echo $dirCount directories, $fileCount files

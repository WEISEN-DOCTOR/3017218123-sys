#!/bin/bash

if [ $# -ne 1 ]
then
	echo "Usage: ./script4.sh path"
	exit 0
fi

for item in `ls $1`
do
	echo `ls -l $1$item | awk -F " " '{print $1}'` $item
done

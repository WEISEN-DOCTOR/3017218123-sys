#!/bin/bash

read -p "Please input a path/file: " name
if [ -d $name ]
then
	echo `ls $name`
elif [ -f $name ] && [ -x $name ]
then
	source $name
elif [ -f $name ] && [ -r $name ]
then
	echo `cat $name`
else
	exit 0
fi

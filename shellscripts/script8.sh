#!/bin/bash

if [ $# -eq 0 ]
then
	echo "Usage: ./script8 options"
	exit 0
fi

len=$#
while [ $# -gt 0 ]
do
	str=$1" "$str
	shift
done

echo $str

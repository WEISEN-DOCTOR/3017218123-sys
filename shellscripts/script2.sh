#!/bin/bash

if [ $# -ne 1 ]
then
	echo "Usage: ./script2.sh option"
	exit 1
fi

if [ y == $1 ] || [ yes == $1 ] || [ Yes == $1 ] || [ YES == $1 ] || [ Y == $1 ]
then
	exit 0
else
	exit 1
fi

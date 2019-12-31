#!/bin/bash

case $1 in
	y)
		exit 0;;
	yes)
		exit 0;;
	Yes)
		exit 0;;
	YES)
		exit 0;;
	Y)
		exit 0;;
	*)
		exit 1;;
esac

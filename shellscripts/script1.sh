#!/bin/bash

echo -e "num\tnum^2\tnum^3"
for i in {1..20}
do
	echo -e "$i\t$(( $i*$i ))\t$(( $i*$i*$i ))"
done

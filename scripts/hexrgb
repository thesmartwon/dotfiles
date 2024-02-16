#!/bin/bash
while read line
do
	hex=$(echo "${line^^}" | sed 's/#//g')

	a=$(echo $hex | cut -c-2)
	b=$(echo $hex | cut -c3-4)
	c=$(echo $hex | cut -c5-6)

	r=$(echo "ibase=16; $a" | bc)
	g=$(echo "ibase=16; $b" | bc)
	b=$(echo "ibase=16; $c" | bc)

	echo $r, $g, $b
done < "${1:-/dev/stdin}"

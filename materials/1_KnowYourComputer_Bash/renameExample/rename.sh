#!/bin/bash
a=1
for i in *.txt; do 
	new=$(printf "project_%02d.txt" "$a"); 
	mv -- "$i" "$new"; 
	let a=a+1; 
done
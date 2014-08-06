#!/bin/bash

cf apps >applist.log

echo "cf apps done here"

awk -F"  " '{ print $1 }' applist.log > applist2.log
tail -n +5 applist2.log > applist.txt

echo "file applist.txt is created"

echo "entering loop"
touch cli-Space1-stop.out
while read p; do
  echo $p
  cf stop $p >>cli-Space1-stop.out 2&>1
done<applist.txt

rm applist*.log




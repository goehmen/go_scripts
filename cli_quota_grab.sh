#!/bin/bash

cf apps >applist.log

echo "cf apps done here"

awk -F"  " '{ print $1 }' applist.log > applist2.log
tail -n +5 applist2.log > applist.txt

echo "file applist.txt is created"

touch app_mem_usage.txt

echo "entering loop"

while read p; do
  echo $p
  cf app $p >>app_mem_usage.txt
done<applist.txt

rm applist*

echo "use 'less app_mem_usage.txt' to see output"



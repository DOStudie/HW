#!/bin/bash

for i in 1 2 3 4 5 6;
do
  date > out$i
  cat out$i >> alldates.txt
done


#!/bin/bash
                                                                                
rm -R alldates.txt  #Y-Removing file

for i in {1..10}; #Y-Added 7 8 9 10 for all files to be created
do
  date > out$i
cat out$i >> alldates.txt #Y-merging all 10 files to one

done

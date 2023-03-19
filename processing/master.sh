#!/bin/bash

# master script
for d in *-vs-*/
do  
    echo "submitting job in $d"
    cd $d
    rm dist_rf.txt
    bash run.sh &> cluster.log &
    cd ..
done

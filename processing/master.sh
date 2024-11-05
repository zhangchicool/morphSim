#!/bin/bash

# master script

for d in *-vs-*/
do  
    echo "submitting job in $d"
    cd $d
    bash run.sh &> cluster.log &
    cd ..
done

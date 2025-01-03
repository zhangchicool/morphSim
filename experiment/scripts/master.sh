#!/bin/bash

# master script

for d in nonclock*/*-vs-mkv/
do  
    echo "submitting job in $d"
    cd $d
    cp ../../scripts/sum_t.r .
    cp ../../scripts/cmd_un_mkv.nex cmd.nex
    bash run.sh &
    cd ../..
done

for d in nonclock*/*-vs-fkv/
do  
    echo "submitting job in $d"
    cd $d
    cp ../../scripts/sum_t.r .
    cp ../../scripts/cmd_un_fkv.nex cmd.nex
    bash run.sh &
    cd ../..
done

for d in tipdating*/*-vs-mkv/
do  
    echo "submitting job in $d"
    cd $d
    cp ../../scripts/sum_t.r .
    cp ../../scripts/cmd_td_mkv.nex cmd.nex
    bash run.sh &
    cd ../..
done

for d in tipdating*/*-vs-fkv/
do  
    echo "submitting job in $d"
    cd $d
    cp ../../scripts/sum_t.r .
    cp ../../scripts/cmd_td_fkv.nex cmd.nex
    bash run.sh &
    cd ../..
done

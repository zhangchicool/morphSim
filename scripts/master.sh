#!/bin/bash

# master script

for d in nonclock*/*-vs-m2v/
do  
    echo "submitting job in $d"
    cd $d
    cp ../../scripts/mb_un_m2v.nex cmd.nex
    bash run.sh &
    cd ../..
done

for d in nonclock*/*-vs-f2v/
do  
    echo "submitting job in $d"
    cd $d
    cp ../../scripts/mb_un_f2v.nex cmd.nex
    bash run.sh &
    cd ../..
done

for d in nonclock*/*-vs-f2vg*/
do  
    echo "submitting job in $d"
    cd $d
    cp ../../scripts/mb_un_f2vg.nex cmd.nex
    bash run.sh &
    cd ../..
done

for d in tipdating*/*-vs-m2v/
do  
    echo "submitting job in $d"
    cd $d
    cp ../../scripts/mb_td_m2v.nex cmd.nex
    bash run.sh &
    cd ../..
done

for d in tipdating*/*-vs-f2v/
do  
    echo "submitting job in $d"
    cd $d
    cp ../../scripts/mb_td_f2v.nex cmd.nex
    bash run.sh &
    cd ../..
done

for d in tipdating*/*-vs-f2vg*/
do  
    echo "submitting job in $d"
    cd $d
    cp ../../scripts/mb_td_f2vg.nex cmd.nex
    bash run.sh &
    cd ../..
done

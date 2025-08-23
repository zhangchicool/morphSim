#!/bin/bash

echo "G4v(a=1 v=4) -vs- M2v" > run.log

for i in {1..100}
do
  echo "** tree $i **" >> run.log
  
  # get the i-th complete birth-death tree
  sed -n "$i"p  ../../simulator/bd.trees > bd.tre
  
  # generate a data file 
  ../../msim -i bd.tre -o data.nex -l 50 -n 50 -v 4 -a 1 -r 1 >> run.log
  
  # run mrbayes to infer the parameters
  ../../mb cmd.nex >> run.log
  
  # rename files to avoid overwriting
  mv data.nex        data_$i.nex
  mv data.nex.con.tre sim_$i.con.tre
done

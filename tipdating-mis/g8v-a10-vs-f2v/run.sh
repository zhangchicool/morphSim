#!/bin/bash

echo "G8v(a=10) -vs- F2v(a~exp(1))" > run.log

for i in {1..100}
do
  echo "** tree $i **" >> run.log
  
  # get the i-th complete birth-death tree
  sed -n "$i"p  ../../simulator/bd.trees > bd.tre
  
  # generate a data file 
  ../../msim -i bd.tre -o data.nex -l 200 -m 0.5 -a 10 -r 10 -q 3 >> run.log
  
  # run mrbayes to infer the parameters
  ../../mb cmd.nex >> run.log
  
  # rename files to avoid overwriting
  mv data.nex        data_$i.nex
  mv data.nex.con.tre sim_$i.con.tre
done

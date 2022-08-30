#!/bin/bash

echo "Fkv(a=1.0) -vs- Mkv" > run.log

for i in {1..100}
do
  echo "** tree $i **" >> run.log
  
  # get the i-th complete birth-death tree
  sed -n "$i"p  ../bd.trees > bd.tre
  
  # generate a data file 
  ../fbdt -i bd.tre -o data.nex -s info -a 1.0 -l 200 >> run.log
  
  # run mrbayes to infer the parameters
  ../mb cmd.nex >> run.log
  
  # summarize the parameters
  # Rscript sum_param.r
  
  # rename files to avoid overwriting
  mv data.nex.con.tre sim_$i.con.tre
done

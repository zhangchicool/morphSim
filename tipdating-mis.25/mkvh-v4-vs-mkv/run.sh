#!/bin/bash

echo "MkvH(v=4,a=inf) -vs- Mkv" > run.log

for i in {1..100}
do
  echo "** tree $i **" >> run.log
  
  # get the i-th complete birth-death tree
  sed -n "$i"p  ../bd.trees > bd.tre
  
  # generate a data file 
  ../fbdt -i bd.tre -o data.nex -hv 4.0 -l 200 -m 0.25 >> run.log
  
  # run mrbayes to infer the parameters
  ../mb cmd.nex >> run.log
  
  # true vs estimated trees
  Rscript sum_t.r >> run.log

  # rename files to avoid overwriting
  mv data.nex        data_$i.nex
  mv data.nex.con.tre sim_$i.con.tre
done

#!/bin/bash

echo "FkvH(v=1,a=2) -vs- Fkv(a~exp(1))" > run.log

for i in {1..20}
do
  echo "** tree $i **" >> run.log
  
  # get the i-th complete birth-death tree
  sed -n "$i"p  ../bd.trees > bd.tre
  
  # generate a data file 
  ../fbdt -i bd.tre -o data.nex -hv 1.0 -a 2.0 -l 200 >> run.log
  
  # run mrbayes to infer the parameters
  ../mb cmd.nex >> run.log
  
  # true vs estimated trees
  Rscript sum_t.r >> run.log

  # rename files to avoid overwriting
  mv data.nex        data_$i.nex
  mv data.nex.con.tre sim_$i.con.tre
done

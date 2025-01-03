#!/bin/bash

echo "Fkv(a=5.0) -vs- Mkv" > run.log

echo "RFdist" > dist_rf.txt

for i in {1..100}
do
  echo "** tree $i **" >> run.log
  
  # get the i-th complete birth-death tree
  sed -n "$i"p  ../../simulator/bd.trees > bd.tre
  
  # generate a data file 
  ../../fbdt -i bd.tre -o data.nex -a 5.0 -l 200 >> run.log
  
  # run mrbayes to infer the parameters
  ../../mb cmd.nex >> run.log
  
  # true vs estimated trees
  Rscript sum_t.r >> run.log

  # rename files to avoid overwriting
  mv data.nex        data_$i.nex
  mv data.nex.con.tre sim_$i.con.tre
done

grep "      TL"      run.log > tl_estm.txt

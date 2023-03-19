#!/bin/bash

echo "Fkv(a=0.5) -vs- Fkv(a~exp(1))" > run.log

for i in {1..20}
do
  echo "** tree $i **" >> run.log
  
  # get the i-th complete birth-death tree
  sed -n "$i"p  ../bd.trees > bd.tre
  
  # generate a data file 
  ../fbdt -i bd.tre -o data.nex -a 0.5 -l 200 >> run.log
  
  # run mrbayes to infer the parameters
  ../mb cmd.nex >> run.log
  
  # true vs estimated trees
  Rscript sum_t.r >> run.log

  # rename files to avoid overwriting
  mv data.nex        data_$i.nex
  mv data.nex.con.tre sim_$i.con.tre
done

grep "TreeInfo"       run.log > tl_true.txt
grep " TL     "       run.log > tl_estm.txt
grep " alpha_symdir " run.log > alpha_m.txt

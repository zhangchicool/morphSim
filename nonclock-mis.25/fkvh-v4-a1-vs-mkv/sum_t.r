library(ape)
library(TreeDist)

setwd(system("pwd", intern=T))

true_t <- read.tree(file="bd.tre")
estm_t <- read.nexus(file="data.nex.con.tre")
write(RobinsonFoulds(true_t, estm_t, normalize=T),
      file="dist_rf.txt", append=T)

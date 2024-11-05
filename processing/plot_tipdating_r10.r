library(vioplot)

setwd("~/Documents/Research/2022-MorphSim/")

par(mfrow=c(2,3), mar=c(3,5,1,1))


## 1. RF distance ##
d_rf1  <- read.table("tipdating_corr/gkv-r10-vs-mkv/dist_rf.txt",    header=T)
d_rf2  <- read.table("tipdating_corr/gkv-r10-a5-vs-mkv/dist_rf.txt", header=T)
d_rf3  <- read.table("tipdating_corr/gkv-r10-a1-vs-mkv/dist_rf.txt", header=T)
d_rf4  <- read.table("tipdating_corr/gkv-r10-vs-fkv/dist_rf.txt",    header=T)
d_rf5  <- read.table("tipdating_corr/gkv-r10-a5-vs-fkv/dist_rf.txt", header=T)
d_rf6  <- read.table("tipdating_corr/gkv-r10-a1-vs-fkv/dist_rf.txt", header=T)
vioplot(c(d_rf1, d_rf2, d_rf3, d_rf4, d_rf5, d_rf6),
        xaxt="n", ylim=c(0,0.8))
axis(side=1, at=1:6, labels=1:6)
title(ylab="RF distance")


## 2. tree height ##
tl_true  <- read.table("simulator/bd.tl.txt", header=T)
th_estm1 <- read.table("tipdating_corr/gkv-r10-vs-mkv/th_estm.txt")
th_estm2 <- read.table("tipdating_corr/gkv-r10-a5-vs-mkv/th_estm.txt")
th_estm3 <- read.table("tipdating_corr/gkv-r10-a1-vs-mkv/th_estm.txt")
th_estm4 <- read.table("tipdating_corr/gkv-r10-vs-fkv/th_estm.txt")
th_estm5 <- read.table("tipdating_corr/gkv-r10-a5-vs-fkv/th_estm.txt")
th_estm6 <- read.table("tipdating_corr/gkv-r10-a1-vs-fkv/th_estm.txt")

# relative bias
th_bias1 <- (th_estm1$V2 - tl_true$tHeight) / tl_true$tHeight
th_bias2 <- (th_estm2$V2 - tl_true$tHeight) / tl_true$tHeight
th_bias3 <- (th_estm3$V2 - tl_true$tHeight) / tl_true$tHeight
th_bias4 <- (th_estm4$V2 - tl_true$tHeight) / tl_true$tHeight
th_bias5 <- (th_estm5$V2 - tl_true$tHeight) / tl_true$tHeight
th_bias6 <- (th_estm6$V2 - tl_true$tHeight) / tl_true$tHeight
vioplot(th_bias1, th_bias2, th_bias3, th_bias4, th_bias5, th_bias6,
        xaxt="n", ylim=c(-0.6,0.3))
axis(side=1, at=1:6, labels=1:6)
legend("top", "tree height", bty="n")
title(ylab="relative bias")

# relative CI width
th_CIw1  <- (th_estm1$V5 - th_estm1$V4) / tl_true$tHeight
th_CIw2  <- (th_estm2$V5 - th_estm2$V4) / tl_true$tHeight
th_CIw3  <- (th_estm3$V5 - th_estm3$V4) / tl_true$tHeight
th_CIw4  <- (th_estm4$V5 - th_estm4$V4) / tl_true$tHeight
th_CIw5  <- (th_estm5$V5 - th_estm5$V4) / tl_true$tHeight
th_CIw6  <- (th_estm6$V5 - th_estm6$V4) / tl_true$tHeight
vioplot(th_CIw1, th_CIw2, th_CIw3, th_CIw4, th_CIw5, th_CIw6,
        xaxt="n", ylim=c(0,0.8))
axis(side=1, at=1:6, labels=1:6)
legend("top", "tree height", bty="n")
title(ylab="relative CI width")


## 3. clock rate ##
cl_estm1  <- read.table("tipdating_corr/gkv-r10-vs-mkv/cl_base.txt")
cl_estm2  <- read.table("tipdating_corr/gkv-r10-a5-vs-mkv/cl_base.txt")
cl_estm3  <- read.table("tipdating_corr/gkv-r10-a1-vs-mkv/cl_base.txt")
cl_estm4  <- read.table("tipdating_corr/gkv-r10-vs-fkv/cl_base.txt")
cl_estm5  <- read.table("tipdating_corr/gkv-r10-a5-vs-fkv/cl_base.txt")
cl_estm6  <- read.table("tipdating_corr/gkv-r10-a1-vs-fkv/cl_base.txt")
cl_var1   <- read.table("tipdating_corr/gkv-r10-vs-mkv/cl_var.txt")
cl_var2   <- read.table("tipdating_corr/gkv-r10-a5-vs-mkv/cl_var.txt")
cl_var3   <- read.table("tipdating_corr/gkv-r10-a1-vs-mkv/cl_var.txt")
cl_var4   <- read.table("tipdating_corr/gkv-r10-vs-fkv/cl_var.txt")
cl_var5   <- read.table("tipdating_corr/gkv-r10-a5-vs-fkv/cl_var.txt")
cl_var6   <- read.table("tipdating_corr/gkv-r10-a1-vs-fkv/cl_var.txt")

# clock variance
vioplot(cl_var1$V2, cl_var2$V2, cl_var3$V2, cl_var4$V2, cl_var5$V2, cl_var6$V2,
        xaxt="n", ylim=c(0,1.5))
axis(side=1, at=1:6, labels=1:6)
title(ylab="clock rate variance")

# relative bias
cl_bias1 <- cl_estm1$V2 - 1.0
cl_bias2 <- cl_estm2$V2 - 1.0
cl_bias3 <- cl_estm3$V2 - 1.0
cl_bias4 <- cl_estm4$V2 - 1.0
cl_bias5 <- cl_estm5$V2 - 1.0
cl_bias6 <- cl_estm6$V2 - 1.0
vioplot(cl_bias1, cl_bias2, cl_bias3, cl_bias4, cl_bias5, cl_bias6,
        xaxt="n", ylim=c(-0.6,1.5))
axis(side=1, at=1:6, labels=1:6)
legend("top", "base clock rate", bty="n")
title(ylab="relative bias")

# relative CI width
cl_CIw1  <- cl_estm1$V5 - cl_estm1$V4
cl_CIw2  <- cl_estm2$V5 - cl_estm2$V4
cl_CIw3  <- cl_estm3$V5 - cl_estm3$V4
cl_CIw4  <- cl_estm4$V5 - cl_estm4$V4
cl_CIw5  <- cl_estm5$V5 - cl_estm5$V4
cl_CIw6  <- cl_estm6$V5 - cl_estm6$V4
vioplot(cl_CIw1, cl_CIw2, cl_CIw3, cl_CIw4, cl_CIw5, cl_CIw6,
        xaxt="n", ylim=c(0,4))
axis(side=1, at=1:6, labels=1:6)
legend("top", "base clock rate", bty="n")
title(ylab="relative CI width")


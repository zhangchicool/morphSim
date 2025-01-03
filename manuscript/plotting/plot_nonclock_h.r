library(vioplot)

setwd("~/Documents/Research/2022-MorphSim/")

par(mfrow=c(2,3), mar=c(3,5,1,1))

####################
## 1. RF distance ##
d_rf1  <- read.table("nonclock_h/mkv-hv1-vs-mkv/dist_rf.txt",    header=T)
d_rf2  <- read.table("nonclock_h/fkv-hv1-a5-vs-mkv/dist_rf.txt", header=T)
d_rf3  <- read.table("nonclock_h/fkv-hv1-a1-vs-mkv/dist_rf.txt", header=T)
d_rf4  <- read.table("nonclock_h/mkv-hv1-vs-fkv/dist_rf.txt",    header=T)
d_rf5  <- read.table("nonclock_h/fkv-hv1-a5-vs-fkv/dist_rf.txt", header=T)
d_rf6  <- read.table("nonclock_h/fkv-hv1-a1-vs-fkv/dist_rf.txt", header=T)
vioplot(c(d_rf1, d_rf2, d_rf3, d_rf4, d_rf5, d_rf6),
        xaxt="n", ylim=c(0,0.8))
axis(side=1, at=1:6, labels=1:6)
title(ylab="RF distance")
legend("top", "hv1", bty="n")

## 2. tree length ##
tl_true  <- read.table("simulator/bd.tl.txt", header=T)
tl_estm1 <- read.table("nonclock_h/mkv-hv1-vs-mkv/tl_estm.txt")
tl_estm2 <- read.table("nonclock_h/fkv-hv1-a5-vs-mkv/tl_estm.txt")
tl_estm3 <- read.table("nonclock_h/fkv-hv1-a1-vs-mkv/tl_estm.txt")
tl_estm4 <- read.table("nonclock_h/mkv-hv1-vs-fkv/tl_estm.txt")
tl_estm5 <- read.table("nonclock_h/fkv-hv1-a5-vs-fkv/tl_estm.txt")
tl_estm6 <- read.table("nonclock_h/fkv-hv1-a1-vs-fkv/tl_estm.txt")

# relative bias
tl_bias1 <- (tl_estm1$V2 - tl_true$tLength) / tl_true$tLength
tl_bias2 <- (tl_estm2$V2 - tl_true$tLength) / tl_true$tLength
tl_bias3 <- (tl_estm3$V2 - tl_true$tLength) / tl_true$tLength
tl_bias4 <- (tl_estm4$V2 - tl_true$tLength) / tl_true$tLength
tl_bias5 <- (tl_estm5$V2 - tl_true$tLength) / tl_true$tLength
tl_bias6 <- (tl_estm6$V2 - tl_true$tLength) / tl_true$tLength
vioplot(tl_bias1, tl_bias2, tl_bias3, tl_bias4, tl_bias5, tl_bias6,
        xaxt="n", ylim=c(-0.6,0.3))
axis(side=1, at=1:6, labels=1:6)
legend("top", "tree length", bty="n")
title(ylab="relative bias")

# relative CI width
tl_CIw1  <- (tl_estm1$V5 - tl_estm1$V4) / tl_true$tLength
tl_CIw2  <- (tl_estm2$V5 - tl_estm2$V4) / tl_true$tLength
tl_CIw3  <- (tl_estm3$V5 - tl_estm3$V4) / tl_true$tLength
tl_CIw4  <- (tl_estm4$V5 - tl_estm4$V4) / tl_true$tLength
tl_CIw5  <- (tl_estm5$V5 - tl_estm5$V4) / tl_true$tLength
tl_CIw6  <- (tl_estm6$V5 - tl_estm6$V4) / tl_true$tLength
vioplot(tl_CIw1, tl_CIw2, tl_CIw3, tl_CIw4, tl_CIw5, tl_CIw6,
        xaxt="n", ylim=c(0,0.8))
axis(side=1, at=1:6, labels=1:6)
legend("top", "tree length", bty="n")
title(ylab="relative CI width")

####################
## 1. RF distance ##
d_rf1  <- read.table("nonclock_h/mkv-hv4-vs-mkv/dist_rf.txt",    header=T)
d_rf2  <- read.table("nonclock_h/fkv-hv4-a5-vs-mkv/dist_rf.txt", header=T)
d_rf3  <- read.table("nonclock_h/fkv-hv4-a1-vs-mkv/dist_rf.txt", header=T)
d_rf4  <- read.table("nonclock_h/mkv-hv4-vs-fkv/dist_rf.txt",    header=T)
d_rf5  <- read.table("nonclock_h/fkv-hv4-a5-vs-fkv/dist_rf.txt", header=T)
d_rf6  <- read.table("nonclock_h/fkv-hv4-a1-vs-fkv/dist_rf.txt", header=T)
vioplot(c(d_rf1, d_rf2, d_rf3, d_rf4, d_rf5, d_rf6),
        xaxt="n", ylim=c(0,0.8))
axis(side=1, at=1:6, labels=1:6)
title(ylab="RF distance")
legend("top", "hv4", bty="n")

## 2. tree length ##
tl_true  <- read.table("simulator/bd.tl.txt", header=T)
tl_estm1 <- read.table("nonclock_h/mkv-hv4-vs-mkv/tl_estm.txt")
tl_estm2 <- read.table("nonclock_h/fkv-hv4-a5-vs-mkv/tl_estm.txt")
tl_estm3 <- read.table("nonclock_h/fkv-hv4-a1-vs-mkv/tl_estm.txt")
tl_estm4 <- read.table("nonclock_h/mkv-hv4-vs-fkv/tl_estm.txt")
tl_estm5 <- read.table("nonclock_h/fkv-hv4-a5-vs-fkv/tl_estm.txt")
tl_estm6 <- read.table("nonclock_h/fkv-hv4-a1-vs-fkv/tl_estm.txt")

# relative bias
tl_bias1 <- (tl_estm1$V2 - tl_true$tLength) / tl_true$tLength
tl_bias2 <- (tl_estm2$V2 - tl_true$tLength) / tl_true$tLength
tl_bias3 <- (tl_estm3$V2 - tl_true$tLength) / tl_true$tLength
tl_bias4 <- (tl_estm4$V2 - tl_true$tLength) / tl_true$tLength
tl_bias5 <- (tl_estm5$V2 - tl_true$tLength) / tl_true$tLength
tl_bias6 <- (tl_estm6$V2 - tl_true$tLength) / tl_true$tLength
vioplot(tl_bias1, tl_bias2, tl_bias3, tl_bias4, tl_bias5, tl_bias6,
        xaxt="n", ylim=c(-0.6,0.3))
axis(side=1, at=1:6, labels=1:6)
legend("top", "tree length", bty="n")
title(ylab="relative bias")

# relative CI width
tl_CIw1  <- (tl_estm1$V5 - tl_estm1$V4) / tl_true$tLength
tl_CIw2  <- (tl_estm2$V5 - tl_estm2$V4) / tl_true$tLength
tl_CIw3  <- (tl_estm3$V5 - tl_estm3$V4) / tl_true$tLength
tl_CIw4  <- (tl_estm4$V5 - tl_estm4$V4) / tl_true$tLength
tl_CIw5  <- (tl_estm5$V5 - tl_estm5$V4) / tl_true$tLength
tl_CIw6  <- (tl_estm6$V5 - tl_estm6$V4) / tl_true$tLength
vioplot(tl_CIw1, tl_CIw2, tl_CIw3, tl_CIw4, tl_CIw5, tl_CIw6,
        xaxt="n", ylim=c(0,0.8))
axis(side=1, at=1:6, labels=1:6)
legend("top", "tree length", bty="n")
title(ylab="relative CI width")


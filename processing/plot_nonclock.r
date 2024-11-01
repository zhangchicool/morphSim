library(vioplot)

setwd("~/Documents/Research/2022-MorphSim/")

par(mfrow=c(2,3), mar=c(3,5,1,1))


## 1. RF distance ##
d_rf1  <- read.table("nonclock/mkv-vs-mkv/dist_rf.txt")
d_rf2  <- read.table("nonclock/fkv-a5-vs-mkv/dist_rf.txt")
d_rf3  <- read.table("nonclock/fkv-a1-vs-mkv/dist_rf.txt")
d_rf4  <- read.table("nonclock/mkv-vs-fkv/dist_rf.txt")
d_rf5  <- read.table("nonclock/fkv-a5-vs-fkv/dist_rf.txt")
d_rf6  <- read.table("nonclock/fkv-a1-vs-fkv/dist_rf.txt")
vioplot(c(d_rf1, d_rf2, d_rf3, d_rf4, d_rf5, d_rf6),
        xaxt="n", ylim=c(0,0.8))
axis(side=1, at=1:6, labels=1:6)
title(ylab="RF distance")


## 2. tree length ##
tl_true  <- read.table("simulator/bd.tl.txt", header=T)
tl_estm1 <- read.table("nonclock/mkv-vs-mkv/tl_estm.txt")
tl_estm2 <- read.table("nonclock/fkv-a5-vs-mkv/tl_estm.txt")
tl_estm3 <- read.table("nonclock/fkv-a1-vs-mkv/tl_estm.txt")
tl_estm4 <- read.table("nonclock/mkv-vs-fkv/tl_estm.txt")
tl_estm5 <- read.table("nonclock/fkv-a5-vs-fkv/tl_estm.txt")
tl_estm6 <- read.table("nonclock/fkv-a1-vs-fkv/tl_estm.txt")

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


plot(c(0,1), c(0,1), type="n", axes=F, xlab="", ylab="") # empty
legend("center", c("1: mkv-vs-mkv",
                   "2: fkv-a5-vs-mkv",
                   "3: fkv-a1-vs-mkv",
                   "4: mkv-vs-fkv",
                   "5: fkv-a5-vs-fkv",
                   "6: fkv-a1-vs-fkv"), bty="n")
## 3. alpha_symdir ##
a_estm4  <- read.table("nonclock/mkv-vs-fkv/alpha_d.txt")
a_estm5  <- read.table("nonclock/fkv-a5-vs-fkv/alpha_d.txt")
a_estm6  <- read.table("nonclock/fkv-a1-vs-fkv/alpha_d.txt")

# relative bias
a_bias1  <- 0
a_bias2  <- 0
a_bias3  <- 0
a_bias4  <- 0 # the true value is infinity
a_bias5  <- (a_estm5$V2 - 5.0) / 5.0
a_bias6  <- (a_estm6$V2 - 1.0) / 1.0
vioplot(a_bias1, a_bias2, a_bias3, a_bias4, a_bias5, a_bias6,
        xaxt="n", ylim=c(-0.7,0.3))
axis(side=1, at=1:6, labels=1:6)
legend("top", "alpha_symdir", bty="n")
title(ylab="relative bias")

# relative CI width
a_CIw1  <- 0
a_CIw2  <- 0
a_CIw3  <- 0
a_CIw4  <- 0 # the true value is infinity
a_CIw5  <- (a_estm5$V5 - a_estm5$V4) / 5.0
a_CIw6  <- (a_estm6$V5 - a_estm6$V4) / 1.0
vioplot(a_CIw1, a_CIw2, a_CIw3, a_CIw4, a_CIw5, a_CIw6,
        xaxt="n", ylim=c(0,1.5))
axis(side=1, at=1:6, labels=1:6)
legend("top", "alpha_symdir", bty="n")
title(ylab="relative CI width")


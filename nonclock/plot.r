library(vioplot)

setwd("~/Downloads/2022-MorphSim/nonclock")

par(mfrow = c(3,2), mar=c(2,2,0,2)+0.5, oma=c(0,2,2,2))


## 1. RF distance ##
d_rf1 <- read.table("mkv-vs-mkv/dist_rf.txt")
d_rf2 <- read.table("fkv-a2-vs-mkv/dist_rf.txt")
d_rf3 <- read.table("fkv-a1-vs-mkv/dist_rf.txt")
d_rf4 <- read.table("fkv-a0.5-vs-mkv/dist_rf.txt")
d_rf5 <- read.table("mkvh-v1-vs-mkv/dist_rf.txt")
d_rf6 <- read.table("fkvh-v1-a2-vs-mkv/dist_rf.txt")
d_rf7 <- read.table("fkvh-v1-a1-vs-mkv/dist_rf.txt")
d_rf8 <- read.table("fkvh-v1-a0.5-vs-mkv/dist_rf.txt")
vioplot(c(d_rf1, d_rf2, d_rf3, d_rf4, d_rf5, d_rf6, d_rf7, d_rf8),
        xaxt="n", ylim=c(0,0.8))
axis(side=1, at=1:8, labels=1:8)

d_rf1 <- read.table("mkv-vs-fkv/dist_rf.txt")
d_rf2 <- read.table("fkv-a2-vs-fkv/dist_rf.txt")
d_rf3 <- read.table("fkv-a1-vs-fkv/dist_rf.txt")
d_rf4 <- read.table("fkv-a0.5-vs-fkv/dist_rf.txt")
d_rf5 <- read.table("mkvh-v1-vs-fkv/dist_rf.txt")
d_rf6 <- read.table("fkvh-v1-a2-vs-fkv/dist_rf.txt")
d_rf7 <- read.table("fkvh-v1-a1-vs-fkv/dist_rf.txt")
d_rf8 <- read.table("fkvh-v1-a0.5-vs-fkv/dist_rf.txt")
vioplot(c(d_rf1, d_rf2, d_rf3, d_rf4, d_rf5, d_rf6, d_rf7, d_rf8),
        xaxt="n", ylim=c(0,0.8))
axis(side=1, at=1:8, labels=1:8)


## 2. tree length ##
tl_estm1 <- read.table("mkv-vs-mkv/tl_estm.txt")
tl_true1 <- read.table("mkv-vs-mkv/tl_true.txt")
tl_estm2 <- read.table("fkv-a2-vs-mkv/tl_estm.txt")
tl_true2 <- read.table("fkv-a2-vs-mkv/tl_true.txt")
tl_estm3 <- read.table("fkv-a1-vs-mkv/tl_estm.txt")
tl_true3 <- read.table("fkv-a1-vs-mkv/tl_true.txt")
tl_estm4 <- read.table("fkv-a0.5-vs-mkv/tl_estm.txt")
tl_true4 <- read.table("fkv-a0.5-vs-mkv/tl_true.txt")
tl_estm5 <- read.table("mkvh-v1-vs-mkv/tl_estm.txt")
tl_true5 <- read.table("mkvh-v1-vs-mkv/tl_true.txt")
tl_estm6 <- read.table("fkvh-v1-a2-vs-mkv/tl_estm.txt")
tl_true6 <- read.table("fkvh-v1-a2-vs-mkv/tl_true.txt")
tl_estm7 <- read.table("fkvh-v1-a1-vs-mkv/tl_estm.txt")
tl_true7 <- read.table("fkvh-v1-a1-vs-mkv/tl_true.txt")
tl_estm8 <- read.table("fkvh-v1-a0.5-vs-mkv/tl_estm.txt")
tl_true8 <- read.table("fkvh-v1-a0.5-vs-mkv/tl_true.txt")
# relative bias
tl_bias1 <- (tl_estm1$V2 - tl_true1$V3) / tl_true1$V3
tl_bias2 <- (tl_estm2$V2 - tl_true2$V3) / tl_true2$V3
tl_bias3 <- (tl_estm3$V2 - tl_true3$V3) / tl_true3$V3
tl_bias4 <- (tl_estm4$V2 - tl_true4$V3) / tl_true4$V3
tl_bias5 <- (tl_estm5$V2 - tl_true5$V3) / tl_true5$V3
tl_bias6 <- (tl_estm6$V2 - tl_true6$V3) / tl_true6$V3
tl_bias7 <- (tl_estm7$V2 - tl_true7$V3) / tl_true7$V3
tl_bias8 <- (tl_estm8$V2 - tl_true8$V3) / tl_true8$V3
# coverage proportion
tl_covp1 <- sum(tl_estm1$V4 < tl_true1$V3 & tl_estm1$V5 > tl_true1$V3) / 100
tl_covp2 <- sum(tl_estm2$V4 < tl_true2$V3 & tl_estm2$V5 > tl_true2$V3) / 100
tl_covp3 <- sum(tl_estm3$V4 < tl_true3$V3 & tl_estm3$V5 > tl_true3$V3) / 100
tl_covp4 <- sum(tl_estm4$V4 < tl_true4$V3 & tl_estm4$V5 > tl_true4$V3) / 100
tl_covp5 <- sum(tl_estm5$V4 < tl_true5$V3 & tl_estm5$V5 > tl_true5$V3) / 100
tl_covp6 <- sum(tl_estm6$V4 < tl_true6$V3 & tl_estm6$V5 > tl_true6$V3) / 100
tl_covp7 <- sum(tl_estm7$V4 < tl_true7$V3 & tl_estm7$V5 > tl_true7$V3) / 100
tl_covp8 <- sum(tl_estm8$V4 < tl_true8$V3 & tl_estm8$V5 > tl_true8$V3) / 100

vioplot(tl_bias1, tl_bias2, tl_bias3, tl_bias4, tl_bias5, tl_bias6, tl_bias7, tl_bias8,
        xaxt="n", ylim=c(-0.5,0.5))
par(new=T)
plot(c(0.5,8.5), c(0,1), type="n", axes=F, xlab="", ylab="")
points(c(tl_covp1, tl_covp2, tl_covp3, tl_covp4, tl_covp5, tl_covp6, tl_covp7, tl_covp8),
       pch=4)
axis(side=1, at=1:8, labels=1:8)
axis(side=4, at=seq(0,1,0.2), labels=F)
legend("topright", "tree length", bty="n")

tl_estm1 <- read.table("mkv-vs-fkv/tl_estm.txt")
tl_true1 <- read.table("mkv-vs-fkv/tl_true.txt")
tl_estm2 <- read.table("fkv-a2-vs-fkv/tl_estm.txt")
tl_true2 <- read.table("fkv-a2-vs-fkv/tl_true.txt")
tl_estm3 <- read.table("fkv-a1-vs-fkv/tl_estm.txt")
tl_true3 <- read.table("fkv-a1-vs-fkv/tl_true.txt")
tl_estm4 <- read.table("fkv-a0.5-vs-fkv/tl_estm.txt")
tl_true4 <- read.table("fkv-a0.5-vs-fkv/tl_true.txt")
tl_estm5 <- read.table("mkvh-v1-vs-fkv/tl_estm.txt")
tl_true5 <- read.table("mkvh-v1-vs-fkv/tl_true.txt")
tl_estm6 <- read.table("fkvh-v1-a2-vs-fkv/tl_estm.txt")
tl_true6 <- read.table("fkvh-v1-a2-vs-fkv/tl_true.txt")
tl_estm7 <- read.table("fkvh-v1-a1-vs-fkv/tl_estm.txt")
tl_true7 <- read.table("fkvh-v1-a1-vs-fkv/tl_true.txt")
tl_estm8 <- read.table("fkvh-v1-a0.5-vs-fkv/tl_estm.txt")
tl_true8 <- read.table("fkvh-v1-a0.5-vs-fkv/tl_true.txt")
# relative bias
tl_bias1 <- (tl_estm1$V2 - tl_true1$V3) / tl_true1$V3
tl_bias2 <- (tl_estm2$V2 - tl_true2$V3) / tl_true2$V3
tl_bias3 <- (tl_estm3$V2 - tl_true3$V3) / tl_true3$V3
tl_bias4 <- (tl_estm4$V2 - tl_true4$V3) / tl_true4$V3
tl_bias5 <- (tl_estm5$V2 - tl_true5$V3) / tl_true5$V3
tl_bias6 <- (tl_estm6$V2 - tl_true6$V3) / tl_true6$V3
tl_bias7 <- (tl_estm7$V2 - tl_true7$V3) / tl_true7$V3
tl_bias8 <- (tl_estm8$V2 - tl_true8$V3) / tl_true8$V3
# coverage proportion
tl_covp1 <- sum(tl_estm1$V4 < tl_true1$V3 & tl_estm1$V5 > tl_true1$V3) / 100
tl_covp2 <- sum(tl_estm2$V4 < tl_true2$V3 & tl_estm2$V5 > tl_true2$V3) / 100
tl_covp3 <- sum(tl_estm3$V4 < tl_true3$V3 & tl_estm3$V5 > tl_true3$V3) / 100
tl_covp4 <- sum(tl_estm4$V4 < tl_true4$V3 & tl_estm4$V5 > tl_true4$V3) / 100
tl_covp5 <- sum(tl_estm5$V4 < tl_true5$V3 & tl_estm5$V5 > tl_true5$V3) / 100
tl_covp6 <- sum(tl_estm6$V4 < tl_true6$V3 & tl_estm6$V5 > tl_true6$V3) / 100
tl_covp7 <- sum(tl_estm7$V4 < tl_true7$V3 & tl_estm7$V5 > tl_true7$V3) / 100
tl_covp8 <- sum(tl_estm8$V4 < tl_true8$V3 & tl_estm8$V5 > tl_true8$V3) / 100

vioplot(tl_bias1, tl_bias2, tl_bias3, tl_bias4, tl_bias5, tl_bias6, tl_bias7, tl_bias8,
        xaxt="n", ylim=c(-0.5,0.5))
par(new=T)
plot(c(0.5,8.5), c(0,1), type="n", axes=F, xlab="", ylab="")
points(c(tl_covp1, tl_covp2, tl_covp3, tl_covp4, tl_covp5, tl_covp6, tl_covp7, tl_covp8),
       pch=4)
axis(side=1, at=1:8, labels=1:8)
axis(side=4, at=seq(0,1,0.2))
legend("topright", "tree length", bty="n")

mtext("RF distance",         side=2, line=0,   adj=0.85, outer=T)
mtext("relative bias",       side=2, line=0,   adj=0.23, outer=T)
mtext("coverage proportion", side=4, line=0,   adj=0.19, outer=T)
mtext("Mkv for inference",   side=3, line=0.5, adj=0.18, outer=T)
mtext("Fkv for inference",   side=3, line=0.5, adj=0.82, outer=T)


## 3. alpha_symdir ##

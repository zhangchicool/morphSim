library(vioplot)

setwd("~/Documents/Research/2022-MorphSim/nonclock/")

par(mfrow = c(3,2), mar=c(2,2,0,2)+0.5, oma=c(0,2,2,2))


## 1. RF distance ##
d_rf1  <- read.table("mkv-vs-mkv/dist_rf.txt")
d_rf2  <- read.table("fkv-a2-vs-mkv/dist_rf.txt")
d_rf3  <- read.table("fkv-a1-vs-mkv/dist_rf.txt")
d_rf4  <- read.table("fkv-a0.5-vs-mkv/dist_rf.txt")
d_rf5  <- read.table("mkvh-v1-vs-mkv/dist_rf.txt")
d_rf6  <- read.table("fkvh-v1-a2-vs-mkv/dist_rf.txt")
d_rf7  <- read.table("fkvh-v1-a1-vs-mkv/dist_rf.txt")
d_rf8  <- read.table("fkvh-v1-a0.5-vs-mkv/dist_rf.txt")
d_rf9  <- read.table("mkvh-v4-vs-mkv/dist_rf.txt")
d_rf10 <- read.table("fkvh-v4-a2-vs-mkv/dist_rf.txt")
d_rf11 <- read.table("fkvh-v4-a1-vs-mkv/dist_rf.txt")
d_rf12 <- read.table("fkvh-v4-a0.5-vs-mkv/dist_rf.txt")
vioplot(c(d_rf1, d_rf2, d_rf3, d_rf4, 
          d_rf5, d_rf6, d_rf7, d_rf8,
          d_rf9, d_rf10, d_rf11, d_rf12), xaxt="n", ylim=c(0,0.8))
axis(side=1, at=1:12, labels=1:12)
legend("topright", "RF distance", bty="n")

d_rf1  <- read.table("mkv-vs-fkv/dist_rf.txt")
d_rf2  <- read.table("fkv-a2-vs-fkv/dist_rf.txt")
d_rf3  <- read.table("fkv-a1-vs-fkv/dist_rf.txt")
d_rf4  <- read.table("fkv-a0.5-vs-fkv/dist_rf.txt")
d_rf5  <- read.table("mkvh-v1-vs-fkv/dist_rf.txt")
d_rf6  <- read.table("fkvh-v1-a2-vs-fkv/dist_rf.txt")
d_rf7  <- read.table("fkvh-v1-a1-vs-fkv/dist_rf.txt")
d_rf8  <- read.table("fkvh-v1-a0.5-vs-fkv/dist_rf.txt")
d_rf9  <- read.table("mkvh-v4-vs-fkv/dist_rf.txt")
d_rf10 <- read.table("fkvh-v4-a2-vs-fkv/dist_rf.txt")
d_rf11 <- read.table("fkvh-v4-a1-vs-fkv/dist_rf.txt")
d_rf12 <- read.table("fkvh-v4-a0.5-vs-fkv/dist_rf.txt")
vioplot(c(d_rf1, d_rf2, d_rf3, d_rf4, 
          d_rf5, d_rf6, d_rf7, d_rf8,
          d_rf9, d_rf10, d_rf11, d_rf12), xaxt="n", ylim=c(0,0.8))
axis(side=1, at=1:12, labels=1:12)
legend("topright", "RF distance", bty="n")


## 2. tree length ##
tl_true  <- read.table("../simulator/bd.tl.txt")

tl_estm1  <- read.table("mkv-vs-mkv/tl_estm.txt")
tl_estm2  <- read.table("fkv-a2-vs-mkv/tl_estm.txt")
tl_estm3  <- read.table("fkv-a1-vs-mkv/tl_estm.txt")
tl_estm4  <- read.table("fkv-a0.5-vs-mkv/tl_estm.txt")
tl_estm5  <- read.table("mkvh-v1-vs-mkv/tl_estm.txt")
tl_estm6  <- read.table("fkvh-v1-a2-vs-mkv/tl_estm.txt")
tl_estm7  <- read.table("fkvh-v1-a1-vs-mkv/tl_estm.txt")
tl_estm8  <- read.table("fkvh-v1-a0.5-vs-mkv/tl_estm.txt")
tl_estm9  <- read.table("mkvh-v4-vs-mkv/tl_estm.txt")
tl_estm10 <- read.table("fkvh-v4-a2-vs-mkv/tl_estm.txt")
tl_estm11 <- read.table("fkvh-v4-a1-vs-mkv/tl_estm.txt")
tl_estm12 <- read.table("fkvh-v4-a0.5-vs-mkv/tl_estm.txt")
# relative bias
tl_bias1  <- (tl_estm1$V2 - tl_true$V3) / tl_true$V3
tl_bias2  <- (tl_estm2$V2 - tl_true$V3) / tl_true$V3
tl_bias3  <- (tl_estm3$V2 - tl_true$V3) / tl_true$V3
tl_bias4  <- (tl_estm4$V2 - tl_true$V3) / tl_true$V3
tl_bias5  <- (tl_estm5$V2 - tl_true$V3) / tl_true$V3
tl_bias6  <- (tl_estm6$V2 - tl_true$V3) / tl_true$V3
tl_bias7  <- (tl_estm7$V2 - tl_true$V3) / tl_true$V3
tl_bias8  <- (tl_estm8$V2 - tl_true$V3) / tl_true$V3
tl_bias9  <- (tl_estm9$V2 - tl_true$V3) / tl_true$V3
tl_bias10 <- (tl_estm10$V2- tl_true$V3) / tl_true$V3
tl_bias11 <- (tl_estm11$V2- tl_true$V3) / tl_true$V3
tl_bias12 <- (tl_estm12$V2- tl_true$V3) / tl_true$V3
# coverage proportion
tl_covp1  <- sum(tl_estm1$V4 < tl_true$V3 & tl_estm1$V5 > tl_true$V3) / 100
tl_covp2  <- sum(tl_estm2$V4 < tl_true$V3 & tl_estm2$V5 > tl_true$V3) / 100
tl_covp3  <- sum(tl_estm3$V4 < tl_true$V3 & tl_estm3$V5 > tl_true$V3) / 100
tl_covp4  <- sum(tl_estm4$V4 < tl_true$V3 & tl_estm4$V5 > tl_true$V3) / 100
tl_covp5  <- sum(tl_estm5$V4 < tl_true$V3 & tl_estm5$V5 > tl_true$V3) / 100
tl_covp6  <- sum(tl_estm6$V4 < tl_true$V3 & tl_estm6$V5 > tl_true$V3) / 100
tl_covp7  <- sum(tl_estm7$V4 < tl_true$V3 & tl_estm7$V5 > tl_true$V3) / 100
tl_covp8  <- sum(tl_estm8$V4 < tl_true$V3 & tl_estm8$V5 > tl_true$V3) / 100
tl_covp9  <- sum(tl_estm9$V4 < tl_true$V3 & tl_estm9$V5 > tl_true$V3) / 100
tl_covp10 <- sum(tl_estm10$V4< tl_true$V3 & tl_estm10$V5> tl_true$V3) / 100
tl_covp11 <- sum(tl_estm11$V4< tl_true$V3 & tl_estm11$V5> tl_true$V3) / 100
tl_covp12 <- sum(tl_estm12$V4< tl_true$V3 & tl_estm12$V5> tl_true$V3) / 100

vioplot(tl_bias1, tl_bias2, tl_bias3, tl_bias4,
        tl_bias5, tl_bias6, tl_bias7, tl_bias8,
        tl_bias9, tl_bias10, tl_bias11, tl_bias12,  xaxt="n", ylim=c(-0.6,0.3))
par(new=T)
plot(c(0.5,12.5), c(0,1), type="n", axes=F, xlab="", ylab="")
points(c(tl_covp1, tl_covp2, tl_covp3, tl_covp4,
         tl_covp5, tl_covp6, tl_covp7, tl_covp8,
         tl_covp9, tl_covp10, tl_covp11, tl_covp12), pch=4)
axis(side=1, at=1:12, labels=1:12)
axis(side=4, at=seq(0,1,0.2), labels=F)
legend("topright", "tree length", bty="n")

tl_estm1  <- read.table("mkv-vs-fkv/tl_estm.txt")
tl_estm2  <- read.table("fkv-a2-vs-fkv/tl_estm.txt")
tl_estm3  <- read.table("fkv-a1-vs-fkv/tl_estm.txt")
tl_estm4  <- read.table("fkv-a0.5-vs-fkv/tl_estm.txt")
tl_estm5  <- read.table("mkvh-v1-vs-fkv/tl_estm.txt")
tl_estm6  <- read.table("fkvh-v1-a2-vs-fkv/tl_estm.txt")
tl_estm7  <- read.table("fkvh-v1-a1-vs-fkv/tl_estm.txt")
tl_estm8  <- read.table("fkvh-v1-a0.5-vs-fkv/tl_estm.txt")
tl_estm9  <- read.table("mkvh-v4-vs-fkv/tl_estm.txt")
tl_estm10 <- read.table("fkvh-v4-a2-vs-fkv/tl_estm.txt")
tl_estm11 <- read.table("fkvh-v4-a1-vs-fkv/tl_estm.txt")
tl_estm12 <- read.table("fkvh-v4-a0.5-vs-fkv/tl_estm.txt")
# relative bias
tl_bias1  <- (tl_estm1$V2 - tl_true$V3) / tl_true$V3
tl_bias2  <- (tl_estm2$V2 - tl_true$V3) / tl_true$V3
tl_bias3  <- (tl_estm3$V2 - tl_true$V3) / tl_true$V3
tl_bias4  <- (tl_estm4$V2 - tl_true$V3) / tl_true$V3
tl_bias5  <- (tl_estm5$V2 - tl_true$V3) / tl_true$V3
tl_bias6  <- (tl_estm6$V2 - tl_true$V3) / tl_true$V3
tl_bias7  <- (tl_estm7$V2 - tl_true$V3) / tl_true$V3
tl_bias8  <- (tl_estm8$V2 - tl_true$V3) / tl_true$V3
tl_bias9  <- (tl_estm9$V2 - tl_true$V3) / tl_true$V3
tl_bias10 <- (tl_estm10$V2- tl_true$V3) / tl_true$V3
tl_bias11 <- (tl_estm11$V2- tl_true$V3) / tl_true$V3
tl_bias12 <- (tl_estm12$V2- tl_true$V3) / tl_true$V3
# coverage proportion
tl_covp1  <- sum(tl_estm1$V4 < tl_true$V3 & tl_estm1$V5 > tl_true$V3) / 100
tl_covp2  <- sum(tl_estm2$V4 < tl_true$V3 & tl_estm2$V5 > tl_true$V3) / 100
tl_covp3  <- sum(tl_estm3$V4 < tl_true$V3 & tl_estm3$V5 > tl_true$V3) / 100
tl_covp4  <- sum(tl_estm4$V4 < tl_true$V3 & tl_estm4$V5 > tl_true$V3) / 100
tl_covp5  <- sum(tl_estm5$V4 < tl_true$V3 & tl_estm5$V5 > tl_true$V3) / 100
tl_covp6  <- sum(tl_estm6$V4 < tl_true$V3 & tl_estm6$V5 > tl_true$V3) / 100
tl_covp7  <- sum(tl_estm7$V4 < tl_true$V3 & tl_estm7$V5 > tl_true$V3) / 100
tl_covp8  <- sum(tl_estm8$V4 < tl_true$V3 & tl_estm8$V5 > tl_true$V3) / 100
tl_covp9  <- sum(tl_estm9$V4 < tl_true$V3 & tl_estm9$V5 > tl_true$V3) / 100
tl_covp10 <- sum(tl_estm10$V4< tl_true$V3 & tl_estm10$V5> tl_true$V3) / 100
tl_covp11 <- sum(tl_estm11$V4< tl_true$V3 & tl_estm11$V5> tl_true$V3) / 100
tl_covp12 <- sum(tl_estm12$V4< tl_true$V3 & tl_estm12$V5> tl_true$V3) / 100

vioplot(tl_bias1, tl_bias2, tl_bias3, tl_bias4,
        tl_bias5, tl_bias6, tl_bias7, tl_bias8,
        tl_bias9, tl_bias10, tl_bias11, tl_bias12,  xaxt="n", ylim=c(-0.4,0.4))
par(new=T)
plot(c(0.5,12.5), c(0,1), type="n", axes=F, xlab="", ylab="")
points(c(tl_covp1, tl_covp2, tl_covp3, tl_covp4,
         tl_covp5, tl_covp6, tl_covp7, tl_covp8,
         tl_covp9, tl_covp10, tl_covp11, tl_covp12), pch=4)
axis(side=1, at=1:12, labels=1:12)
axis(side=4, at=seq(0,1,0.2))
legend("topright", "tree length", bty="n")


## 3. alpha_symdir ##
a_estm1  <- read.table("mkv-vs-fkv/alpha_m.txt")
a_estm2  <- read.table("fkv-a2-vs-fkv/alpha_m.txt")
a_estm3  <- read.table("fkv-a1-vs-fkv/alpha_m.txt")
a_estm4  <- read.table("fkv-a0.5-vs-fkv/alpha_m.txt")
a_estm5  <- read.table("mkvh-v1-vs-fkv/alpha_m.txt")
a_estm6  <- read.table("fkvh-v1-a2-vs-fkv/alpha_m.txt")
a_estm7  <- read.table("fkvh-v1-a1-vs-fkv/alpha_m.txt")
a_estm8  <- read.table("fkvh-v1-a0.5-vs-fkv/alpha_m.txt")
a_estm9  <- read.table("mkvh-v4-vs-fkv/alpha_m.txt")
a_estm10 <- read.table("fkvh-v4-a2-vs-fkv/alpha_m.txt")
a_estm11 <- read.table("fkvh-v4-a1-vs-fkv/alpha_m.txt")
a_estm12 <- read.table("fkvh-v4-a0.5-vs-fkv/alpha_m.txt")
# relative bias
a_bias1  <- 0
a_bias2  <- (a_estm2$V2 - 2.0) / 2.0
a_bias3  <- (a_estm3$V2 - 1.0) / 1.0
a_bias4  <- (a_estm4$V2 - 0.5) / 0.5
a_bias5  <- 0
a_bias6  <- (a_estm6$V2 - 2.0) / 2.0
a_bias7  <- (a_estm7$V2 - 1.0) / 1.0
a_bias8  <- (a_estm8$V2 - 0.5) / 0.5
a_bias9  <- 0
a_bias10 <- (a_estm10$V2- 2.0) / 2.0
a_bias11 <- (a_estm11$V2- 1.0) / 1.0
a_bias12 <- (a_estm12$V2- 0.5) / 0.5
# coverage proportion
a_covp1  <- -1
a_covp2  <- sum(a_estm2$V4 < 2.0 & a_estm2$V5 > 2.0) / 100
a_covp3  <- sum(a_estm3$V4 < 1.0 & a_estm3$V5 > 1.0) / 100
a_covp4  <- sum(a_estm4$V4 < 0.5 & a_estm4$V5 > 0.5) / 100
a_covp5  <- -1
a_covp6  <- sum(a_estm6$V4 < 2.0 & a_estm6$V5 > 2.0) / 100
a_covp7  <- sum(a_estm7$V4 < 1.0 & a_estm7$V5 > 1.0) / 100
a_covp8  <- sum(a_estm8$V4 < 0.5 & a_estm8$V5 > 0.5) / 100
a_covp9  <- -1
a_covp10 <- sum(a_estm10$V4< 2.0 & a_estm10$V5> 2.0) / 100
a_covp11 <- sum(a_estm11$V4< 1.0 & a_estm11$V5> 1.0) / 100
a_covp12 <- sum(a_estm12$V4< 0.5 & a_estm12$V5> 0.5) / 100

plot(c(0,1), c(0,1), type="n", axes=F, xlab="", ylab="") # empty
legend("center", c("1: Mkv in simulation",   "2: Fkv, alpha=2",
                   "3: Fkv, alpha=1",        "4: Fkv, alpha=0.5",
                   "5: Mkvh, var=1",         "6: Fkvh, var=1,alpha=2",
                   "7: Fkvh, var=1,alpha=1", "8: Fkvh, var=1,alpha=0.5",
                   "9: Mkvh, var=4",         "10:Fkvh, var=4,alpha=2",
                   "11:Fkvh, var=4,alpha=1", "12:Fkvh, var=4,alpha=0.5"), bty="n")

vioplot(a_bias1, a_bias2, a_bias3, a_bias4, 
        a_bias5, a_bias6, a_bias7, a_bias8,
        a_bias9, a_bias10, a_bias11, a_bias12,  xaxt="n", ylim=c(-1,1.2))
par(new=T)
plot(c(0.5,12.5), c(0,1), type="n", axes=F, xlab="", ylab="")
points(c(a_covp1, a_covp2, a_covp3, a_covp4,
         a_covp5, a_covp6, a_covp7, a_covp8,
         a_covp9, a_covp10, a_covp11, a_covp12), pch=4)
axis(side=1, at=1:12, labels=1:12)
axis(side=4, at=seq(0,1,0.2))
legend("topright", "alpha_symdir", bty="n")


mtext("normalized distance", side=2, line=0,   adj=0.91, outer=T)
mtext("relative bias",       side=2, line=0,   adj=0.51, outer=T)
mtext("coverage proportion", side=4, line=0,   adj=0.51, outer=T)
mtext("relative bias",       side=2, line=0,   adj=0.15, outer=T)
mtext("coverage proportion", side=4, line=0,   adj=0.12, outer=T)
mtext("Mkv in inference",    side=3, line=0.5, adj=0.20, outer=T)
mtext("Fkv in inference",    side=3, line=0.5, adj=0.80, outer=T)


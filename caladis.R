# read in reformatted Caladis output

cy1 = read.table("cy1.txt", header=F)
cy2 = read.table("cy2.txt", header=F)
ty1 = read.table("ty1.txt", header=F)
ty2 = read.table("ty2.txt", header=F)

# prepare and produce histograms
pdf("caladis-plots.pdf")
par(mfrow=c(2,1))
h1 = hist(log(cy1[,]), breaks=pretty(-15:15,n=60), plot=F)
h2 = hist(log(ty1[,]), breaks=pretty(-15:15,n=60), plot=F)
plot(h2,col=rgb(1,0,0,0.2), xlim= c(0,10), freq=F, main="Y1", xlab = "log(NPP / g m-2 yr-1)", ylab="Caladis probability", xaxt="n")
axis(1, at = log(c(10000, 1000, 100, 10, 1)), label=c("10000", "1000", "100", "10", "1"))
plot(h1,col=rgb(0,0,1,0.2),freq=F,add=T)

h3 = hist(log(cy2[,]), breaks=pretty(-15:15,n=60), plot=F)
h4 = hist(log(ty2[,]), breaks=pretty(-15:15,n=60), plot=F)
plot(h3,col=rgb(0,0,1,0.2), xlim=c(0,10),freq=F, main="Y2",xlab = "log(NPP / g m-2 yr-1)", ylab="Caladis probability", xaxt="n")
axis(1, at = log(c(10000, 1000, 100, 10, 1)), label=c("10000", "1000", "100", "10", "1"))
plot(h4,col=rgb(1,0,0,0.2),freq=F,add=T)
dev.off()
d0 = read.table("production.txt")

control = d0[(d0[,1]==2 | d0[,1]==3 | d0[,1]==5),]
control = control[order(control$V2),]
treatment = d0[(d0[,1]==1 | d0[,1]==4 | d0[,1]==6),]
treatment = treatment[order(treatment$V2),]

pdf("production-ts.pdf")
loesscontrol = predict(loess(control[,3] ~ control[,2]), se=T)
plot(control[,2], control[,3], col="blue", xlab="Quarter", ylab = "Production / g qr-1")
polygon(c(control[,2], rev(control[,2])), c( loesscontrol$fit - qt(0.975,loesscontrol$df)*loesscontrol$se, rev( loesscontrol$fit + qt(0.975,loesscontrol$df)*loesscontrol$se)), col=rgb(0, 0, 1, 0.2), border=NA)
lines(control[,2], loesscontrol$fit, col="blue")
points(control[,2], control[,3], col="blue") 

loesstreatment = predict(loess(treatment[,3] ~ treatment[,2]), se=T)
points(treatment[,2], treatment[,3], col="red", xlab="Quarter", ylab = "Production / g qr-1")
polygon(c(treatment[,2], rev(treatment[,2])), c( loesstreatment$fit - qt(0.975,loesstreatment$df)*loesstreatment$se, rev( loesstreatment$fit + qt(0.975,loesstreatment$df)*loesstreatment$se)), col=rgb(1, 0, 0, 0.2), border=NA)
lines(treatment[,2], loesstreatment$fit, col="red")
points(treatment[,2], treatment[,3], col="red") 
dev.off()

treatmentmean = rep(0,7)
controlmean = rep(0,7)
treatmentvar = rep(0,7)
controlvar = rep(0,7)
treatmentymean = rep(0,2)
controlymean = rep(0,2)
treatmentyvar = rep(0,2)
controlyvar = rep(0,2)

for(q in 1:8)
{
  treatmentq = treatment[(treatment[,2] == q),3]
  controlq = control[(control[,2] == q),3]
  treatmentmean[q] = mean(treatmentq)
  treatmentvar[q] = var(treatmentq)
  controlmean[q] = mean(controlq)
  controlvar[q] = var(controlq)
}

treatment67 = treatment[(treatment[,2] == 6 | treatment[,2] == 7),3]
control67 = control[(control[,2] == 6 | control[,2] == 7),3]
treatment58 = treatment[(treatment[,2] == 5 | treatment[,2] == 8),3]
control58 = control[(control[,2] == 5 | control[,2] == 8),3]

wilcox.test(control67,treatment67)
wilcox.test(control58,treatment58)

treatmenty1 = sum(treatmentmean[1:4])
treatmenty2 = sum(treatmentmean[5:8])
controly1 = sum(controlmean[1:4])
controly2 = sum(controlmean[5:8])
treatmenty1sd = sqrt(sum(treatmentvar[1:4]))
treatmenty2sd = sqrt(sum(treatmentvar[5:8]))
controly1sd = sqrt(sum(controlvar[1:4]))
controly2sd = sqrt(sum(controlvar[5:8]))

output = rbind(c(1, controly1, controly1sd, treatmenty1, treatmenty1sd), c(2, controly2, controly2sd, treatmenty2, treatmenty2sd))
write.table(output, file="production-y12.txt", row.names=F, col.names=F)
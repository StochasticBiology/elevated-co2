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

treatmentay1 = c(sum(treatment[(treatment[,1]==1 & treatment[,2] <= 4),3]), sum(treatment[(treatment[,1]==4 & treatment[,2] <= 4),3]), sum(treatment[(treatment[,1]==6 & treatment[,2] <= 4),3]))
treatmentay2 = c(sum(treatment[(treatment[,1]==1 & treatment[,2] > 4),3]), sum(treatment[(treatment[,1]==4 & treatment[,2] > 4),3]), sum(treatment[(treatment[,1]==6 & treatment[,2] > 4),3]))
controlay1 = c(sum(control[(control[,1]==2 & control[,2] <= 4),3]), sum(control[(control[,1]==3 & control[,2] <= 4),3]), sum(control[(control[,1]==5 & control[,2] <= 4),3]))
controlay2 = c(sum(control[(control[,1]==2 & control[,2] > 4),3]), sum(control[(control[,1]==3 & control[,2] > 4),3]), sum(control[(control[,1]==5 & control[,2] > 4),3]))

treatmenty1 = mean(treatmentay1)
treatmenty2 = mean(treatmentay2)
controly1 = mean(controlay1)
controly2 = mean(controlay2)
treatmenty1sem = sd(treatmentay1)/sqrt(length(treatmentay1))
treatmenty2sem = sd(treatmentay2)/sqrt(length(treatmentay2))
controly1sem = sd(controlay1)/sqrt(length(controlay1))
controly2sem = sd(controlay2)/sqrt(length(controlay2))

output = rbind(c(1, controly1, controly1sem, treatmenty1, treatmenty1sem), c(2, controly2, controly2sem, treatmenty2, treatmenty2sem))
write.table(output, file="production-y12.txt", row.names=F, col.names=F)

output*83

####

control.y1.y = control[control[,2] <= 4,3]
control.y1.t = control[control[,2] <= 4,2]
control.y1.t2 = control.y1.t^2
control.y1.lm = lm(control.y1.y ~ control.y1.t2 + control.y1.t)

control.y2.y = control[control[,2] > 4,3]
control.y2.t = control[control[,2] > 4,2]
control.y2.t2 = control.y2.t^2
control.y2.lm = lm(control.y2.y ~ control.y2.t2 + control.y2.t)

treatment.y1.y = treatment[treatment[,2] <= 4,3]
treatment.y1.t = treatment[treatment[,2] <= 4,2]
treatment.y1.t2 = treatment.y1.t^2
treatment.y1.lm = lm(treatment.y1.y ~ treatment.y1.t2 + treatment.y1.t)

treatment.y2.y = treatment[treatment[,2] > 4,3]
treatment.y2.t = treatment[treatment[,2] > 4,2]
treatment.y2.t2 = treatment.y2.t^2
treatment.y2.lm = lm(treatment.y2.y ~ treatment.y2.t2 + treatment.y2.t)

both.y1.y = c(control[control[,2] <= 4,3], treatment[treatment[,2] <= 4,3])
both.y1.t = c(control[control[,2] <= 4,2], treatment[treatment[,2] <= 4,2])
both.y1.t2 = both.y1.t^2
both.y1.lm = lm(both.y1.y ~ both.y1.t2 + both.y1.t)

both.y2.y = c(control[control[,2] > 4,3], treatment[treatment[,2] > 4,3])
both.y2.t = c(control[control[,2] > 4,2], treatment[treatment[,2] > 4,2])
both.y2.t2 = both.y2.t^2
both.y2.lm = lm(both.y2.y ~ both.y2.t2 + both.y2.t)

control.y1.lik = logLik(control.y1.lm)
control.y2.lik = logLik(control.y2.lm)
treatment.y1.lik = logLik(treatment.y1.lm)
treatment.y2.lik = logLik(treatment.y2.lm)
both.y1.lik = logLik(both.y1.lm)
both.y2.lik = logLik(both.y2.lm)

wilkes.y1 = 2*((control.y1.lik + treatment.y1.lik) - both.y1.lik)
wilkes.y2 = 2*((control.y2.lik + treatment.y2.lik) - both.y2.lik)
lrt.pvalue.y1 = 1-pchisq(wilkes.y1, 3)
lrt.pvalue.y2 = 1-pchisq(wilkes.y2, 3)

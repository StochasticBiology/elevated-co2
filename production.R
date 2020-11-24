d0 = read.table("production.txt")
treatmentmean = rep(0,7)
controlmean = rep(0,7)
treatmentsem = rep(0,7)
controlsem = rep(0,7)
treatmentymean = rep(0,2)
controlymean = rep(0,2)
treatmentyvar = rep(0,2)
controlyvar = rep(0,2)

for(q in 0:7)
{
  treatmentmean[q+1] = mean(d0[(d0[,1] == 1 | d0[,1] == 4 | d0[,1] == 6) & d0[,2] == q,3])
  treatmentsem[q+1] = sd(d0[(d0[,1] == 1 | d0[,1] == 4 | d0[,1] == 6) & d0[,2] == q,3])/sqrt(3)
  controlmean[q+1] = mean(d0[(d0[,1] == 2 | d0[,1] == 3 | d0[,1] == 5) & d0[,2] == q,3])
  controlsem[q+1] = sd(d0[(d0[,1] == 2 | d0[,1] == 3 | d0[,1] == 5) & d0[,2] == q,3])/sqrt(3)
  if(is.finite(controlsem[q+1]) & is.finite(treatmentsem[q+1]))
  {
  if(q <= 3)
  {
    yref = 1;
  }
  else
  {
    yref = 2;
  }
  controlymean[yref] = controlymean[yref] + controlmean[q+1]
  controlyvar[yref] = controlyvar[yref] + (controlsem[q+1]*sqrt(3))**2
  treatmentymean[yref] = treatmentymean[yref] + treatmentmean[q+1]
  treatmentyvar[yref] = treatmentyvar[yref] + (treatmentsem[q+1]*sqrt(3))**2
   } 
}

# function to return various aspects of the BID model, given parameters theta (vector of length 5), time points t and length observations Y
# output = 1 returns negative log likelihood, 2 gives model-predicted mean (given t), 3 gives model-predicted s.d. (given t)

bid.lik <- function(theta, t, Y, output=1) {

  # grab the model variables from the parameter vector
  # we use logged values to ensure they all remain non-negative
  lambda = exp(theta[1])
  nu = exp(theta[2])
  alpha = exp(theta[3])
  m0 = exp(theta[4])
  v0 = exp(theta[5])

  # variables for simplification
  kappa = lambda-nu;
  ek = exp(t*kappa)

  # BID mean and variance
  mu = ((ek-1)*alpha + ek*m0*kappa)/kappa;
  sigma = sqrt( v0 + (ek-1)*(-alpha*nu + ek*(alpha*lambda + m0*(lambda*lambda - nu*nu))) / (kappa*kappa) )

  # what to output? negative log likelihood, mean, or sd?
  if(output == 1)
  {
    # log likelihood of our data
    logl = sum(dnorm(Y, mu, sigma, TRUE))
    return(-logl) 
  }
  else if(output == 2)
  {
    return(mu)
  }
  else if(output == 3)
  {
    return(sigma)
  }
}

# read data and cast into required forms
df = read.table("~/Dropbox/Documents/2021_Projects/Clare/roots-bid-data.txt")
year.days = 365
if(year == 1)
{
  data.y1.control = df[df[,1]=="Control" & df[,2]<year.days,]
  data.y1.eco2 = df[df[,1]=="eCO2" & df[,2]<year.days,]
  control.t = data.y1.control[,2]
  eco2.t = data.y1.eco2[,2]
}
if(year == 2)
{
  data.y1.control = df[df[,1]=="Control" & df[,2]>=year.days,]
  data.y1.eco2 = df[df[,1]=="eCO2" & df[,2]>=year.days,]
  control.t = data.y1.control[,2]-year.days
  eco2.t = data.y1.eco2[,2]-year.days
}
control.Y = data.y1.control[,4]
eco2.Y = data.y1.eco2[,4]
both.t = c(control.t, eco2.t)
both.Y = c(control.Y, eco2.Y)

#"Nelder-Mead", "BFGS", "CG", "L-BFGS-B", "SANN", "Brent"

##### first analysis -- maximum likelihood
# first plots -- traces
par(mfrow=c(3,1))

# minimise the negative log likelihood for the control data
opt.control = optim(log(c(0.2, 0.25, 0.2, 10, 50)), bid.lik, t = control.t, Y = control.Y)
# get the mean and variances
control.mu = bid.lik(opt.control$par, control.t, control.Y, output=2)
control.sigma = bid.lik(opt.control$par, control.t, control.Y, output=3)
# plot the data, means and variances
plot(control.t, control.Y, col="red")
points(control.t, control.mu, col="blue")
points(control.t, control.mu+control.sigma, col="lightblue")
points(control.t, control.mu-control.sigma, col="lightblue")

# as above for the eCO2
opt.eco2 = optim(log(c(0.2, 0.25, 0.2, 10, 50)), bid.lik, t = eco2.t, Y = eco2.Y)
eco2.mu = bid.lik(opt.eco2$par, eco2.t, eco2.Y, output=2)
eco2.sigma = bid.lik(opt.eco2$par, eco2.t, eco2.Y, output=3)
plot(eco2.t, eco2.Y, col="red")
points(eco2.t, eco2.mu, col="blue")
points(eco2.t, eco2.mu+eco2.sigma, col="lightblue")
points(eco2.t, eco2.mu-eco2.sigma, col="lightblue")

# as above for the combined dataset
opt.both = optim(log(c(0.2, 0.25, 0.2, 10, 50)), bid.lik, t = both.t, Y = both.Y)
both.mu = bid.lik(opt.both$par, both.t, both.Y, output=2)
both.sigma = bid.lik(opt.both$par, both.t, both.Y, output=3)
plot(both.t, both.Y, col="red")
points(both.t, both.mu, col="blue")
points(both.t, both.mu+both.sigma, col="lightblue")
points(both.t, both.mu-both.sigma, col="lightblue")

# get the actual log likelihoods in each case
control.lik = -opt.control$value
eco2.lik = -opt.eco2$value
both.lik = -opt.both$value

# likelihood ratio test
wilkes.stat = 2*((control.lik+eco2.lik)-both.lik)
lrt.pvalue = 1-pchisq(wilkes.stat, 5)

# (lambda-nu) differences
control.kappa = exp(opt.control$par[1])-exp(opt.control$par[2])
eco2.kappa = exp(opt.eco2$par[1])-exp(opt.eco2$par[2])
control.alpha = exp(opt.control$par[3])
eco2.alpha = exp(opt.eco2$par[3])

plot.t = seq(0:365)
plot.both.mean = bid.lik(opt.both$par, plot.t, 0, 2)
plot.both.sd = bid.lik(opt.both$par, plot.t, 0, 3)
plot.control.mean = bid.lik(opt.control$par, plot.t, 0, 2)
plot.control.sd = bid.lik(opt.control$par, plot.t, 0, 3)
plot.eco2.mean = bid.lik(opt.eco2$par, plot.t, 0, 2)
plot.eco2.sd = bid.lik(opt.eco2$par, plot.t, 0, 3)

plot.output = cbind(plot.t, plot.both.mean, plot.both.sd, plot.control.mean, plot.control.sd, plot.eco2.mean, plot.eco2.sd)
write.table(plot.output, paste("plot-bid-output-y", year, ".txt", sep=""), row.names=F, col.names=F)

##### second analysis -- bootstrapping
# set number of resamples and initialise parameter vectors
nboot = 500
control.boot.pars = opt.control$par
eco2.boot.pars = opt.eco2$par

# run the bootstraps
for(i in 1:nboot)
{
  converged = 0
  while(converged == 0) {
  
    # resample the control data
    refs = sample(length(control.t), replace=T)
    control.t.boot = control.t[refs]
    control.Y.boot = control.Y[refs]
    # optimise for this resampling
    opt.control = optim(log(c(0.1, 0.15, 0.1, 10, 50)), bid.lik, t = control.t.boot, Y = control.Y.boot)
  
    # same for eCO2
    refs = sample(length(eco2.t), replace=T)
    eco2.t.boot = eco2.t[refs]
    eco2.Y.boot = eco2.Y[refs]
    opt.eco2 = optim(log(c(0.1, 0.15, 0.1, 10, 50)), bid.lik, t = eco2.t.boot, Y = eco2.Y.boot)

    if(year == 1) {
      if(exp(opt.control$par[1])-exp(opt.control$par[2]) > -0.1 & exp(opt.eco2$par[1])-exp(opt.eco2$par[2]) > -0.1 ) {
        converged = 1
      }
    }
    if(year == 2) {
      converged = 1
    }
  }
  control.boot.pars = rbind(control.boot.pars, opt.control$par)
  eco2.boot.pars = rbind(eco2.boot.pars, opt.eco2$par)
}

# plot the resulting bootstrapped histograms
param.names = c("lambda", "nu", "alpha", "m0", "v0")
par(mfrow=c(3,2))
for(i in 1:5)
{
  control.param = exp(control.boot.pars[,i])
  eco2.param = exp(eco2.boot.pars[,i])
  b = min(c(control.param, eco2.param))
  e = max(c(control.param, eco2.param))
  ax = seq(b, e, length.out=20)
  hg.control = hist(control.param, breaks=ax, plot=F)
  hg.eco2 = hist(eco2.param, breaks=ax, plot=F)
  plot(hg.eco2, col = rgb(1,0,0,alpha=0.5), main=param.names[i])
  plot(hg.control, col = rgb(0,0,1,alpha=0.5), add=T)
}
# including (lambda-nu)
control.param = exp(control.boot.pars[,1])-exp(control.boot.pars[,2])
eco2.param = exp(eco2.boot.pars[,1])-exp(eco2.boot.pars[,2])
b = min(c(control.param, eco2.param))
e = max(c(control.param, eco2.param))
ax = seq(b, e, length.out=20)
hg.control = hist(control.param, breaks=ax, plot=F)
hg.eco2 = hist(eco2.param, breaks=ax, plot=F)
plot(hg.eco2, col = rgb(1,0,0,alpha=0.5), main="(lambda-nu)")
plot(hg.control, col = rgb(0,0,1,alpha=0.5), add=T)

bin.counts = cbind(hg.control$mids, hg.control$counts, hg.eco2$counts)
write.table(bin.counts, paste("plot-bid-bins-y", year, ".txt", sep=""), row.names=F, col.names=F)

# check for differences in governing parameters
alpha.diff = 0
kappa.diff = 0
for(i in 1:5000)
{
  s1 = sample(nboot,1)
  s2 = sample(nboot,1)
  sample.control.alpha = exp(control.boot.pars[s1,3])
  sample.eco2.alpha = exp(eco2.boot.pars[s1,3])
  if(sample.control.alpha > sample.eco2.alpha) { alpha.diff = alpha.diff + 1 }

  sample.control.kappa = exp(control.boot.pars[s1,1])-exp(control.boot.pars[s1,2])
  sample.eco2.kappa = exp(eco2.boot.pars[s1,1])-exp(eco2.boot.pars[s1,2])
  if(sample.control.kappa > sample.eco2.kappa) { kappa.diff = kappa.diff + 1 }
}
kappa.pval = kappa.diff/5000
alpha.pval = alpha.diff/5000

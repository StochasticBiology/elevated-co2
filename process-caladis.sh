# simply reformat Caladis outputs
# source URLs below (from paper)
sed 's/\t/\n/g' Caladis/control-y1.txt > cy1.txt
sed 's/\t/\n/g' Caladis/control-y2.txt > cy2.txt
sed 's/\t/\n/g' Caladis/treatment-y1.txt > ty1.txt
sed 's/\t/\n/g' Caladis/treatment-y2.txt > ty2.txt

# Control Y1 ($p_{obs} \sim N(0.0246, 0.0196)$) : http://www.caladis.org/compute/?q=2*%24pobs*%24rho*%24h*%24r*(%24r%2B%24d)*sin(2*%24phi)%2F(%24l*%24d*(%24d%2B2*%24r)*%24h*%24w*cos(%24phi))&v=pobs%3Anorm%2C0.0246%2C0.0196%3Brho%3Anorm%2C0.343%2C0.161%3Bh%3Anorm%2C0.1755%2C0.005%3Br%3Anorm%2C0.0275%2C0.005%3Br%3Anorm%2C0.0275%2C0.005%3Bd%3Aunif%2C0.0005%2C0.0035%3Bphi%3Anorm%2C0.785%2C0.196%3Bl%3Anorm%2C0.0192%2C0.005%3Bd%3Aunif%2C0.0005%2C0.0035%3Bd%3Aunif%2C0.0005%2C0.0035%3Br%3Anorm%2C0.0275%2C0.005%3Bh%3Anorm%2C0.1755%2C0.005%3Bw%3Anorm%2C0.0189%2C0.005%3Bphi%3Anorm%2C0.785%2C0.196&x=off&n=m&h=fd&a=rad
# Control Y2 ($p_{obs} \sim N(0.00737, 0.00319)$) : http://www.caladis.org/compute/?q=2*%24pobs*%24rho*%24h*%24r*(%24r%2B%24d)*sin(2*%24phi)%2F(%24l*%24d*(%24d%2B2*%24r)*%24h*%24w*cos(%24phi))&v=pobs%3Anorm%2C0.00737%2C0.00319%3Brho%3Anorm%2C0.343%2C0.161%3Bh%3Anorm%2C0.1755%2C0.005%3Br%3Anorm%2C0.0275%2C0.005%3Br%3Anorm%2C0.0275%2C0.005%3Bd%3Aunif%2C0.0005%2C0.0035%3Bphi%3Anorm%2C0.785%2C0.196%3Bl%3Anorm%2C0.0192%2C0.005%3Bd%3Aunif%2C0.0005%2C0.0035%3Bd%3Aunif%2C0.0005%2C0.0035%3Br%3Anorm%2C0.0275%2C0.005%3Bh%3Anorm%2C0.1755%2C0.005%3Bw%3Anorm%2C0.0189%2C0.005%3Bphi%3Anorm%2C0.785%2C0.196&x=off&n=m&h=fd&a=rad
# Treatment Y1 ($p_{obs} \sim N(0.0290, 0.0153)$) : http://www.caladis.org/compute/?q=2*%24pobs*%24rho*%24h*%24r*(%24r%2B%24d)*sin(2*%24phi)%2F(%24l*%24d*(%24d%2B2*%24r)*%24h*%24w*cos(%24phi))&v=pobs%3Anorm%2C0.0290%2C0.0153%3Brho%3Anorm%2C0.343%2C0.161%3Bh%3Anorm%2C0.1755%2C0.005%3Br%3Anorm%2C0.0275%2C0.005%3Br%3Anorm%2C0.0275%2C0.005%3Bd%3Aunif%2C0.0005%2C0.0035%3Bphi%3Anorm%2C0.785%2C0.196%3Bl%3Anorm%2C0.0192%2C0.005%3Bd%3Aunif%2C0.0005%2C0.0035%3Bd%3Aunif%2C0.0005%2C0.0035%3Br%3Anorm%2C0.0275%2C0.005%3Bh%3Anorm%2C0.1755%2C0.005%3Bw%3Anorm%2C0.0189%2C0.005%3Bphi%3Anorm%2C0.785%2C0.196&x=off&n=m&h=fd&a=rad
# Treatment Y2 ($p_{obs} \sim N(0.0108, 0.00485)$) : http://www.caladis.org/compute/?q=2*%24pobs*%24rho*%24h*%24r*(%24r%2B%24d)*sin(2*%24phi)%2F(%24l*%24d*(%24d%2B2*%24r)*%24h*%24w*cos(%24phi))&v=pobs%3Anorm%2C0.0108%2C0.00485%3Brho%3Anorm%2C0.343%2C0.161%3Bh%3Anorm%2C0.1755%2C0.005%3Br%3Anorm%2C0.0275%2C0.005%3Br%3Anorm%2C0.0275%2C0.005%3Bd%3Aunif%2C0.0005%2C0.0035%3Bphi%3Anorm%2C0.785%2C0.196%3Bl%3Anorm%2C0.0192%2C0.005%3Bd%3Aunif%2C0.0005%2C0.0035%3Bd%3Aunif%2C0.0005%2C0.0035%3Br%3Anorm%2C0.0275%2C0.005%3Bh%3Anorm%2C0.1755%2C0.005%3Bw%3Anorm%2C0.0189%2C0.005%3Bphi%3Anorm%2C0.785%2C0.196&x=off&n=m&h=fd&a=rad

chmod +x *.sh

./process-s1.sh
R CMD BATCH rhizo-analysis.R

./process-s2.sh
R CMD BATCH core-weights-analysis.R
# run Mathematica notebook bid-analysis.nb, then:
# gnuplot -e 'set term svg size 640,480; set output "bid-analysis.svg"; load "plotscr-bid.gnuplot"; exit;'

./process-s3.sh
R CMD BATCH production.R
gnuplot -e 'set term svg size 320,320; set output "production-years.svg"; load "production-years.gnuplot"; exit;'

./process-roots.sh
R CMD BATCH roots.R

./process-caladis.sh
R CMD BATCH caladis.R

chmod +x *.sh

./process-s1.sh
R CMD BATCH rhizo-analysis.R

./process-s2.sh
R CMD BATCH core-weights-analysis.R
R CMD BATCH bid-analysis-wrapper.R
gnuplot -e 'set term svg size 640,480; set output "bid-analysis-y1.svg"; load "plotscr-bid-y1.gnuplot"; exit;'
gnuplot -e 'set term svg size 640,480; set output "bid-analysis-y2.svg"; load "plotscr-bid-y2.gnuplot"; exit;'

./process-s3.sh
R CMD BATCH production.R
gnuplot -e 'set term svg size 320,320; set output "production-years.svg"; load "production-years.gnuplot"; exit;'

./process-roots.sh
R CMD BATCH roots.R

./process-caladis.sh
R CMD BATCH caladis.R

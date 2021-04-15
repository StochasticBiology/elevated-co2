# this script wraps the full analysis for the paper

# allow us to execute scripts
chmod +x *.sh

# extract volume and width data from minirhizos
./process-s1.sh
# time series of root volume and widths, with LOESS fits
R CMD BATCH rhizo-analysis.R
# birth-immigration-death analysis of root volume time series
R CMD BATCH bid-analysis-wrapper.R
# produce figures describing analysis
gnuplot -e 'set term svg size 640,400; set output "bid-analysis-y1.svg"; load "plotscr-bid-y1.gnuplot"; exit;'
gnuplot -e 'set term svg size 640,400; set output "bid-analysis-y2.svg"; load "plotscr-bid-y2.gnuplot"; exit;'

# parse core data
./process-s2.sh
# analysis of core root weights by different category
R CMD BATCH core-weights-analysis.R

# parse production data
./process-s3.sh
# analysis of production estimate time series
R CMD BATCH production.R
# produce figure
gnuplot -e 'set term svg size 480,320; set output "production-years.svg"; load "production-years.gnuplot"; exit;'

# root length and width data
./process-roots.sh
R CMD BATCH roots.R

# caladis histograms
./process-caladis.sh
R CMD BATCH caladis.R

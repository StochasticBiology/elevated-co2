chmod +x *.sh

./process-s1.sh
R CMD BATCH rhizo-analysis.R

./process-s2.sh
R CMD BATCH core-weights-analysis.R
# mathematica
# gnuplot

./process-s3.sh
R CMD BATCH production.R
# gnuplot

./process-roots.sh
R CMD BATCH roots.R

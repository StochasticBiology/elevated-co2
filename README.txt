Ziegler et al., Quantifying carbon fertilisation of root biomass production from elevated CO2 in mature temperate deciduous forest

Raw data and code for analysis and visualisation (R, Mathematica, Gnuplot)

(1) Supplementary_data_1-Root_lengths.csv
(2) Supplementary_data_2-Soil_cores.csv
(3) Supplementary_data_3-Production.csv
(4) R*.csv

(1) = process-s1.sh =>
= Biomass_per_rhizo_control.txt
= Biomass_per_rhizo_treatment.txt
= roots-bid-data.txt
=== Biomass measurements from minirhizotron tubes; final file is cast in form appropriate for subsequent analysis in bid-analysis.nb

= rhizo-analysis.R
=== R code for analysis of minirhizotron data and production of Fig 2A-B

= bid-analysis.nb
=== Mathematica notebook analysing minirhizotron data with a birth-immigration-death model

= plotscr-bid.gnuplot
=== Gnuplot script that takes the output of bid-analysis.nb and produces Fig 2C-F

(2) = process-s2.sh =>
= core-weights.csv
= core-by-horizon.txt
=== Soil core measurements

= core-weights-analysis.R
=== R code for analysis of soil coring data and production of Fig 3

(3) = process-s3.sh =>
production.txt

production.R
XXX

(4) = process-roots.sh =>

roots.R


= plot-npp.gnuplot
=== Gnuplot script that plots NPP measurements (Fig 4B)


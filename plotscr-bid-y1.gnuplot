reset
set multiplot
set size 0.5
set origin 0,0.5
set key top left
set style fill solid
set yrange [-2:120]
set xrange [-2:310]
set ylabel "Control biomass / mg"
set xlabel "Time / days"
unset key
plot "plot-bid-output-y1.txt" u 1:($4-$5):($4+$5) w filledcu lc rgbcolor "#AAAAFF" notitle, "" u 1:4 w l lw 3 lc rgbcolor "#8888FF" notitle, "roots-bid-data.txt" u ($2 <= 365 && strcol(1) eq "Control" ? $2 : 1/0):4 pt 6 ps 0.5 lc rgbcolor "#0000FF" title "Control"
set origin 0.5,0.5
set ylabel "eCO2 biomass / mg"
plot "plot-bid-output-y1.txt" u 1:($6-$7):($6+$7) w filledcu lc rgbcolor "#FFAAAA" notitle, "" u 1:6 w l lw 3 lc rgbcolor "#FF8888" notitle, "roots-bid-data.txt" u ($2 <= 365 && strcol(1) eq "eCO2" ? $2 : 1/0):4 pt 6 ps 0.5 lc rgbcolor "#FF0000" title "eCO2"
set origin 0,0
set ylabel "Combined biomass / mg"
plot  "plot-bid-output-y1.txt" u 1:($2-$3):($2+$3) w filledcu lc rgbcolor "#CCCCCC" notitle, "" u 1:2 w l lw 3 lc rgbcolor "#AAAAAA" notitle, "roots-bid-data.txt" u ($2 <= 365 && strcol(1) eq "Control" ? $2 : 1/0):4 pt 6 ps 0.5 lc rgbcolor "#0000FF" notitle, "roots-bid-data.txt" u ($2 <= 365 && strcol(1) eq "eCO2" ? $2 : 1/0):4 pt 6 ps 0.5 lc rgbcolor "#FF0000" notitle 
set origin 0.5,0
set yrange [0:*]
set xrange [*:*]
set key top left
set ylabel "Bootstrap count"
set xlabel "Proliferation rate (λ - ν) / per day"
plot "plot-bid-bins-y1.txt" u 1:2 w boxes lc rgbcolor "#88AAAAFF" title "Control", "" u 1:3 w boxes lc rgbcolor "#88FFAAAA" title "eCO2"

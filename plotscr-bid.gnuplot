reset
set multiplot
set size 0.5
set origin 0,0.5
set key top left
set style fill solid
set yrange [-10:120]
set xrange [-10:310]
set ylabel "Control biomass / mg"
set xlabel "Time / days"
unset key
plot "fitset.txt" u 1:6:7 w filledcu lc rgbcolor "#AAAAFF" notitle, "" u 1:5 w l lw 3 lc rgbcolor "#8888FF" notitle, "controldata.txt" pt 6 ps 0.5 lc rgbcolor "#0000FF" title "Control"
set origin 0.5,0.5
set ylabel "eCO2 biomass / mg"
plot "fitset.txt" u 1:9:10 w filledcu lc rgbcolor "#FFAAAA" notitle, "" u 1:8 w l lw 3 lc rgbcolor "#FF8888" notitle,  "eco2data.txt" pt 6 ps 0.5 lc rgbcolor "#FF0000" title "eCO2"
set origin 0,0
set ylabel "Combined biomass / mg"
plot  "fitset.txt" u 1:3:4 w filledcu lc rgbcolor "#CCCCCC" notitle, "" u 1:2 w l lw 3 lc rgbcolor "#AAAAAA" notitle,  "eco2data.txt" pt 6 ps 0.5 lc rgbcolor "#FF0000" notitle, "controldata.txt" pt 6 ps 0.5 lc rgbcolor "#0000FF" notitle
set origin 0.5,0
set yrange [0:*]
set xrange [*:*]
set key top left
set ylabel "Bootstrap count"
set xlabel "Proliferation rate (λ - ν) / per day"
plot "binhists.txt" u ($1/5.-0.03):2 w boxes lc rgbcolor "#AAAAFF" title "Control", "" u ($1/5.-0.03):3 w boxes lc rgbcolor "#FFAAAA" title "eCO2"

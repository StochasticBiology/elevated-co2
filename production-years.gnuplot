set xrange [0.5:2.5]
set xtics ("Y1" 1, "Y2" 2)
set ylabel "Annual production / g yr-1"
plot "production-y12.txt" u ($1-0.1):2:3 w errorbars pt 7 ps 1.5 lw 4 lc rgbcolor "#0000FF" title "Control", "" u ($1+0.1):4:5 w errorbars pt 7 ps 1.5 lw 4 lc rgbcolor "#FF0000" title "eCO2"
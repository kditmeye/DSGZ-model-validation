set terminal pngcairo transparent enhanced font "arial,10" fontscale 1.0 size 960, 1080
set output 'result.png'

set multiplot
set size 0.5,0.5
set origin 0.0,0.0

set title 'DSGZ model prediction - for annealed PC (mesh-size: 500)'
set xlabel 'True Strain
set ylabel 'True Stress [MPa]
set grid
set key left top
set xrange [0.0:1.1]
set yrange [0:160]
plot '1-result1.txt' title'T=296K, strain rate=0.001/s, prediction' with lines lt 1 lc rgb "black" lw 2 ,  \
	'1-expdata1.txt' title'T=296K, strain rate=0.001/s, exp.data' with points lt 1 lc rgb "black" lw 4 ,  \
	
unset xrange
unset yrange
	
set size 0.5,0.5
set origin 0.5,0.0

set title 'Comparaison of DSGZ model prediction - for annealed PC (mesh-size: 500)'
set xlabel 'True Strain
set ylabel 'True Stress [MPa]
set grid
set key right bottom
plot '2-result1.txt' title'T=296K, strain rate=0.001/s, prediction' with lines lt 1 lc rgb "black" lw 2 ,  \
	 '2-expdata1.txt' title'T=296K, strain rate=0.001/s, exp.data' with points lt 1 lc rgb "black" lw 4 ,  \
	 '2-result2.txt' title'T=296K, strain rate=0.0005/s, prediction' with lines lt 1 lc rgb "red" lw 2 ,  \
	 '2-expdata2.txt' title'T=296K, strain rate=0.0005/s, exp.data' with points lt 1 lc rgb "red" lw 4 ,  \
	 '2-result3.txt' title'T=296K, strain rate=0.0001/s, prediction' with lines lt 1 lc rgb "blue" lw 2 ,  \
	 '2-expdata3.txt' title'T=296K, strain rate=0.0001/s, exp.data' with points lt 1 lc rgb "blue" lw 4 ,  \
	 '2-result4.txt' title'T=348K, strain rate=0.001/s, prediction' with lines lt 1 lc rgb "black" lw 2 dashtype 2,  \
	 '2-expdata4.txt' title'T=348K, strain rate=0.001/s, exp.data' with points lt 1 lc rgb "black" lw 6 ,  \
	 '2-result5.txt' title'T=348K, strain rate=0.0005/s, prediction' with lines lt 1 lc rgb "red" lw 2 dashtype 2,  \
	 '2-expdata5.txt' title'T=348K, strain rate=0.0005/s, exp.data' with points lt 1 lc rgb "red" lw 6 ,  \
	 '2-result6.txt' title'T=348K, strain rate=0.0001/s, prediction' with lines lt 1 lc rgb "blue" lw 2 dashtype 2,  \
	 '2-expdata6.txt' title'T=348K, strain rate=0.0001/s, exp.data' with points lt 1 lc rgb "blue" lw 6 ,  \

unset multiplot	 



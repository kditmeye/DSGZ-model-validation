set terminal pngcairo transparent enhanced font "arial,10" fontscale 2.0 size 1920, 1080
set output 'result.png'


set title 'DSGZ model prediction - for annealed PMMA (mesh-size: 500)'
set xlabel 'True Strain
set ylabel 'True Stress [MPa]
set grid
set style line 2 lt 3 lw 3 pt 3 lc rgb "red"
plot '1-result1.txt' title'T=296K, strain rate=0.001/s, prediction' with lines lt 1 lc rgb "black" lw 2 ,  \
	'1-result2.txt' title'T=296K, strain rate=0.001/s, exp.data' with points lt 1 lc rgb "black" lw 4 ,  \
	



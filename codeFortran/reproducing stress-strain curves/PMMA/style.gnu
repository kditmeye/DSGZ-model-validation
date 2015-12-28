set terminal pngcairo transparent enhanced font "arial,18" fontscale 1.0 size 960, 1080
set output 'result.png'


set title 'Comparaison of DSGZ model - for annealed PMMA (mesh-size:500)'
set xlabel 'True Strain
set ylabel 'True Stress [MPa]
set grid
set key right bottom
plot '2-result1.txt' title'T=296K, strain rate=0.001/s, prediction-our coefficients' with lines lt 1 lc rgb "black" lw 6 ,  \
	 '2-expdata1.txt' title'T=296K, strain rate=0.001/s, exp.data' with points pt 7 lc rgb "black" ps 2,  \
	 '2-result2.txt' title'T=296K, strain rate=0.0005/s, prediction-our coefficients' with lines lt 1 lc rgb "red" lw 6 ,  \
	 '2-expdata2.txt' title'T=296K, strain rate=0.0005/s, exp.data' with points pt 7 lc rgb "red" ps 2,  \
	 '2-result3.txt' title'T=296K, strain rate=0.0001/s, prediction-our coefficients' with lines lt 1 lc rgb "blue" lw 6 ,  \
	 '2-expdata3.txt' title'T=296K, strain rate=0.0001/s, exp.data' with points pt 7 lc rgb "blue" ps 2,  \
	 '2-result4.txt' title'T=323K, strain rate=0.001/s, prediction-our coefficients' with lines lt 1 lc rgb "black" lw 6 dashtype 2,  \
	 '2-expdata4.txt' title'T=323K, strain rate=0.001/s, exp.data' with points pt 5 lc rgb "black" ps 2 ,  \
	 '2-result5.txt' title'T=323K, strain rate=0.0005/s, prediction-our coefficients' with lines lt 1 lc rgb "red" lw 6 dashtype 2,  \
	 '2-expdata5.txt' title'T=323K, strain rate=0.0005/s, exp.data' with points pt 5 lc rgb "red" ps 2 ,  \
	 '2-result6.txt' title'T=323K, strain rate=0.0001/s, prediction-our coefficients' with lines lt 1 lc rgb "blue" lw 6 dashtype 2,  \
	 '2-expdata6.txt' title'T=323K, strain rate=0.0001/s, exp.data' with points pt 5 lc rgb "blue" ps 2 ,  \





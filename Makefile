all: esim.pdf example.pdf kandi.pdf manual.pdf

esim.pdf : esim.tex gradu3.cls
example.pdf : example.tex gradu3.cls
kandi.pdf : kandi.tex gradu3.cls

%.pdf: %.tex
	pdflatex $*
	pdflatex $*
	set -e ; if [ -e $*.bcf ] ; then biber $* ; pdflatex $* ; fi

clean :
	rm -f *.aux *.bbl *.blg *.dvi *.out *.out *.toc *.log
	rm -f *.bcf *.lof *.lot *.run.xml

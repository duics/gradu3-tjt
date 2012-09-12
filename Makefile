all: esim.pdf example.pdf kandi.pdf manual.pdf

esim.pdf : esim.tex gradu3.cls
example.pdf : example.tex gradu3.cls
kandi.pdf : kandi.tex gradu3.cls

%.pdf: %.tex
	pdflatex $*
	pdflatex $*

clean :
	rm -f *.aux *.bbl *.blg *.dvi *.out *.out *.toc
	rm -f esim.pdf example.pdf kandi.pdf manual.pdf
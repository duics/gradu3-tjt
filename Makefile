manual.ps: manual.dvi
	dvips -o manual.ps manual

manual.dvi: manual.tex
	latex manual

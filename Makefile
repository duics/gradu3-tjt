example.dvi: example.tex gradu2.cls
	latex example
	latex example

manual.ps: manual.dvi
	dvips -o manual.ps manual

manual.dvi: manual.tex
	latex manual

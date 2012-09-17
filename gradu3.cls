% Originally written by Antti-Juhani Kaijanaho on December 2002.
% You may treat this file as if it were in the public domain.
% Subsequently modified by Matthieu Weber and Antti-Juhani Kaijanaho.
% Currently maintained by Antti-Juhani Kaijanaho <antti-juhani.kaijanaho@jyu.fi>

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                     PLEASE READ THE MANUAL!                           %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\filedate{2012/09/17}
\def\fileversion{3.0pre3}
\def\fileinfo{JY MIT Gradut}
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{gradu3}[\filedate\space\fileversion\space\fileinfo]
\typeout{gradu3 <\filedate:\fileversion> - Tietotekniikan laitoksen graduille}

\RequirePackage{ifthen}

\newif\iffi
\fitrue

\let\gradu@listitem\relax
\def\gradu@appendlist#1#2{\xdef#1{#1\noexpand\gradu@listitem{#2}}}
\def\gradu@map#1#2{\begingroup\let\gradu@listitem#1#2\endgroup}

%%% METADATA COMMANDS

\def\gradu@muistitko#1{\textit{\gradu@msg@muistitko} \texttt{\textbackslash #1}\textit{\gradu@msg@komentoa}}

\def\gradu@metadatacommands{}
\def\gradu@DeclareMetadataCommand#1#2{%
  \gradu@appendlist\gradu@metadatacommands{#1}%
  \expandafter\def\csname#1\endcsname##1{%
    \expandafter\gdef\csname gradu@#1\endcsname{##1}%
  }%
  \ifthenelse{\equal{#2}{}}{%
    \expandafter\def\csname gradu@#1\endcsname{%
      \gradu@muistitko{#1}
    }%
  }{%
    \expandafter\def\csname gradu@#1\endcsname{#2}
  }%
}
\newcounter{gradu@listrender@count}
\def\gradu@DeclareMetadataListCommand#1{%
  \newcounter{gradu@#1@count}
  \gradu@appendlist\gradu@metadatacommands{#1}%
  \expandafter\def\csname#1\endcsname##1{%
    \expandafter\gradu@appendlist\csname gradu@#1\endcsname{##1}%
    \addtocounter{gradu@#1@count}{1}%
  }%
  \expandafter\def\csname gradu@#1\endcsname{}%
  \expandafter\def\csname gradu@#1@render\endcsname##1##2{%
    \ifthenelse{\value{gradu@#1@count} = 0}{%
      \gradu@muistitko{#1}%
    }{%
      \setcounter{gradu@listrender@count}{\value{gradu@#1@count}}%
      \begingroup%
      \def\gradu@f####1{%
        \addtocounter{gradu@listrender@count}{-1}%
        ####1%
        \ifthenelse{\value{gradu@listrender@count} = 0}{%
        }{%
          \ifthenelse{\value{gradu@listrender@count} = 1}{%
            ##2%
          }{%
            ##1%
          }%
        }%
      }%
      \expandafter\gradu@map\expandafter\gradu@f\csname gradu@#1\endcsname%
      \endgroup%
    }%
  }%
}
\gradu@DeclareMetadataCommand{title}{}
\gradu@DeclareMetadataCommand{translatedtitle}{}
\gradu@DeclareMetadataCommand{yliopisto}{Jyv\"askyl\"an yliopisto}
\gradu@DeclareMetadataCommand{university}{University of Jyv\"askyl\"a}
\gradu@DeclareMetadataCommand{laitos}{%
  \iffi%
  Tietotekniikan laitos%
  \else%
  Department of Mathematical Information Technology%
  \fi%
}  
\gradu@DeclareMetadataCommand{aine}{%
  \iffi%
  Tietotekniikan%
  \else%
  in Information Technology%
  \fi%
}
\gradu@DeclareMetadataCommand{linja}{}
\gradu@DeclareMetadataCommand{tyyppi}{pro gradu -tutkielma}
\gradu@DeclareMetadataCommand{type}{Master's Thesis}
%\gradu@DeclareMetadataCommand{tiivistelma} -- needs \long
%\gradu@DeclareMetadataCommand{abstract} -- needs \long
\gradu@DeclareMetadataCommand{avainsanat}{}
\gradu@DeclareMetadataCommand{keywords}{}
\gradu@DeclareMetadataListCommand{author}
\gradu@DeclareMetadataListCommand{ohjaaja}
\gradu@DeclareMetadataListCommand{yhteystiedot}

%% Input encoding
\def\gradu@inputenc{utf8}
\DeclareOption{ansinew}{\gdef\gradu@inputenc{ansinew}}
\DeclareOption{applemac}{\gdef\gradu@inputenc{applemac}}
\DeclareOption{ascii}{\gdef\gradu@inputenc{ascii}}
\DeclareOption{cp1250}{\gdef\gradu@inputenc{cp1250}}
\DeclareOption{cp1252}{\gdef\gradu@inputenc{cp1252}}
\DeclareOption{cp437}{\gdef\gradu@inputenc{cp437}}
\DeclareOption{cp437de}{\gdef\gradu@inputenc{cp437de}}
\DeclareOption{cp850}{\gdef\gradu@inputenc{cp850}}
\DeclareOption{cp852}{\gdef\gradu@inputenc{cp852}}
\DeclareOption{cp865}{\gdef\gradu@inputenc{cp865}}
\DeclareOption{decmulti}{\gdef\gradu@inputenc{decmulti}}
\DeclareOption{latin1}{\gdef\gradu@inputenc{latin1}}
\DeclareOption{latin2}{\gdef\gradu@inputenc{latin2}}
\DeclareOption{latin3}{\gdef\gradu@inputenc{latin3}}
\DeclareOption{latin5}{\gdef\gradu@inputenc{latin5}}
\DeclareOption{latin9}{\gdef\gradu@inputenc{latin9}}
\DeclareOption{next}{\gdef\gradu@inputenc{next}}
\DeclareOption{utf8}{\gdef\gradu@inputenc{utf8}}

\DeclareOption{kandi}{%
  \gdef\gradu@tyyppi{kandidaatintutkielma}%
  \gdef\gradu@type{Bachelor's Thesis}%
}


\DeclareOption{finnish}{\fitrue}
\DeclareOption{english}{\fifalse}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions
\LoadClass[a4paper,12pt]{report}

%\RequirePackage{color}
\RequirePackage{everyshi}[1994/12/09]
\RequirePackage[\gradu@inputenc]{inputenc}
\RequirePackage[T1]{fontenc}
\renewcommand{\baselinestretch}{1.2} % this makes for a 1.45 line spacing
\RequirePackage[left=35mm,right=20mm,top=35mm,bottom=35mm,nohead]{geometry}
\RequirePackage[finnish,english]{babel}
\RequirePackage{mathptmx}
\RequirePackage[scaled=.92]{helvet}
\RequirePackage{courier}

\setlength\parindent{0pt}
\setlength\parskip{10pt}

\iffi
\def\gradu@msg@muistitko{Muistitko k\"aytt\"a\"a}
\def\gradu@msg@komentoa{-komentoa?}
\def\termlistname{Sanasto}
\def\appendicesname{Liitteet}
\else
\def\gradu@msg@muistitko{Did you remember to use the}
\def\gradu@msg@komentoa{ command?}
\def\termlistname{Glossary}
\def\appendicesname{Appendices}
\fi

\newcounter{gradu@pagecount@main}
\newcounter{gradu@pagecount@app}
\def\gradu@pagecount@curr{gradu@pagecount@main}
\EveryShipout{%
  \addtocounter{\gradu@pagecount@curr}{1}%
}
\AtEndDocument{%
  \clearpage%
  \immediate\write\@auxout%
  {\string\gdef\string\gradu@MainPageCount{\thegradu@pagecount@main}}%
  \immediate\write\@auxout%
  {\string\gdef\string\gradu@AppPageCount{\thegradu@pagecount@app}}%
}
\def\gradu@AppPageCount{\textbf{?}}
\def\gradu@MainPageCount{\textbf{?}}

\iffi
\def\selectdefaultlanguage{\selectlanguage{finnish}}
\else
\def\selectdefaultlanguage{\selectlanguage{english}}
\fi

\def\gradu@date{\today}
\renewcommand{\date}[1]{%
  \ClassWarning{gradu3}{\noexpand\date is deprecated!}%
  \gdef\gradu@date{#1}%
}
\newcommand{\setdate}[3]{\gdef\day{#1}\gdef\month{#2}\year=#3}
\newcommand{\contactinformation}[1]{\yhteystiedot{#1}}

\def\gradu@tiivistelma{\gradu@muistitko{tiivistelma}}
\long\def\tiivistelma#1{\gdef\gradu@tiivistelma{\begin{foreignlanguage}{finnish}#1\end{foreignlanguage}}}
\def\gradu@abstract{\gradu@muistitko{abstract}}
\long\def\abstract#1{\gdef\gradu@abstract{\begin{foreignlanguage}{english}#1\end{foreignlanguage}}}

\newcommand{\gradu@toolate}{%
  \ClassError{gradu3}{%
    \iffi%
    Bibliografiatietoja ei voi antaa enaa dokumentin alun jalkeen.%
    \else%
    Bibliographical data cannot be given after the beginning of document.%
    \fi%
  }{%
    \iffi%
    Komennot kuten \textbackslash title voi antaa vain ennen
    \textbackslash begin\{document\}-komentoa.
    \else%
    You can give commands like \textbackslash title only before
    the \textbackslash begin\{document\} command.
    \fi%
  }%
}

\pagenumbering{roman}
\newcommand{\mainmatter}{
  \listoffigures
  \listoftables
  \tableofcontents
  \clearpage
  \pagenumbering{arabic}
  \setcounter{chapter}{0}
}
\def\gradu@HeadToUpper#1{%
  \edef\fooA{#1}%
  \def\fooB##1{##1}%
  \def\fooC##1##2\relax{\uppercase{\fooB{##1}}##2}%
  \expandafter\fooC\fooA\relax%
}
\renewcommand{\maketitle}{%
\begingroup
%%%% TITLE PAGE
\begin{titlepage}%
  \vspace*{7truecm plus 1truecm minus 3truecm}%
  \begingroup%
  \def\gradu@f##1{\centerline{\textbf{##1}}}%
  \gradu@map\gradu@f\gradu@author\par%
  \endgroup
  \vspace{2truecm}%
  \centerline{\Large\textbf{\parbox[top][\height][c]{\textwidth}{\centering \gradu@title}}}%
  \vspace{4truecm}%
  \par%
  \raggedleft%
  \iffi%
  \gradu@aine{} \gradu@tyyppi%
  \else%
  \gradu@type{} \gradu@aine%
  \fi%
  \par%
  \raggedleft
  \gradu@date%
  \vfill%
  \vspace{1truecm plus 1truecm minus .5truecm}%
  \iffi
  \center{\large\textbf{\gradu@yliopisto}}%
  \else
  \center{\large\textbf{\gradu@university}}%
  \fi
  \center{\textbf{\gradu@laitos}}%
\end{titlepage}%
\newpage%
%%% METADATA PAGE
  \noindent%
  \iffi%
  \textbf{Tekij\"a\ifthenelse{\value{gradu@author@count}>1}{t}{}:} %
  \gradu@author@render{,\space}{\space ja\space}\par%
  \else%
  \noindent\textbf{Author\ifthenelse{\value{gradu@author@count}>1}{s}{}:} %
  \gradu@author@render{,\space}{,\space and\space}\par%
  \fi%
  \iffi%
  \noindent\textbf{Yhteystiedot:} %
  \gradu@yhteystiedot@render{,\space}{\space ja\space}\par%
  \else%
  \noindent\textbf{Contact information:}
  \gradu@yhteystiedot@render{,\space}{,\space and\space}\par%
  \fi
  \noindent{%
    \textbf{%
      \iffi%
      Ohjaaja\ifthenelse{\value{gradu@ohjaaja@count}>1}{t}{}:%
      \else%
      Supervisor\ifthenelse{\value{gradu@ohjaaja@count}>1}{s}{}:%
      \fi%
    }\space%
    \iffi%
    \gradu@ohjaaja@render{,\space}{\space ja\space}\par%
    \else%
    \gradu@ohjaaja@render{,\space}{,\space and\space}\par%
    \fi
  }\par%
  \iffi
  \noindent\textbf{Ty\"on nimi:} {\let\\\relax \gradu@title\par}%
  \noindent\textbf{Title in English:} \gradu@translatedtitle\par%
  \noindent\textbf{Ty\"o:} {%
    \gradu@HeadToUpper\gradu@tyyppi%
  }\par%
  \noindent\textbf{Suuntautumisvaihtoehto:} \gradu@linja\par%
  \noindent\textbf{Sivum\"a\"ar\"a:} \gradu@MainPageCount+\gradu@AppPageCount\par%
  \noindent\textbf{Tiivistelm\"a:} \gradu@tiivistelma\par%
  \noindent\textbf{Avainsanat:} \gradu@avainsanat\par%
  \noindent\textbf{Abstract:} \gradu@abstract\par%
  \noindent\textbf{Keywords:} \begin{foreignlanguage}{english}\gradu@keywords\end{foreignlanguage}\par%
  \else%
  \noindent\textbf{Title:} {\let\\\relax \gradu@title\par}%
  \noindent\textbf{Ty\"on nimi:} \gradu@translatedtitle\par%
  \noindent\textbf{Project:} \gradu@type\par%
  \noindent\textbf{Study line:} \gradu@linja\par%
  \noindent\textbf{Page count:} \gradu@MainPageCount+\gradu@AppPageCount\par%
  \noindent\textbf{Abstract:} \gradu@abstract\par%
  \noindent\textbf{Keywords:} \gradu@keywords\par%
  \noindent\textbf{Suomenkielinen tiivistelm\"a:} \gradu@tiivistelma\par%
  \noindent\textbf{Avainsanat:} \gradu@avainsanat\par%
  \fi%
%%% POSTPROCESSING
  \def\gradu@f##1{%
    \expandafter\gdef\csname##1\endcsname{\gradu@toolate}%
  }%
  \gradu@map\gradu@f\gradu@metadatacommands%
\endgroup
  \global\let\author\gradu@toolate%
  \global\let\date\gradu@toolate%  
  \global\let\tiivistelma\gradu@toolate%  
  \global\let\abstract\gradu@toolate%  
}

\newcommand{\preface}{\chapter*{\prefacename}
\addcontentsline{toc}{chapter}{\prefacename}
}

\newcommand{\termlist}{\chapter*{\termlistname}
\addcontentsline{toc}{chapter}{\termlistname}
}

\renewcommand\appendix{\par\clearpage%
  \gdef\gradu@pagecount@curr{gradu@pagecount@app}
  \addtocontents{toc}{\protect\contentsline{chapter}{\appendicesname}{}{}}
  \setcounter{chapter}{0}%
  \setcounter{section}{0}%
  \gdef\@chapapp{\appendixname}%
  \gdef\thechapter{\@Alph\c@chapter}}

\def\@makechapterhead#1{%
  \vspace*{2em}%
  {\parindent \z@ \raggedright \normalfont
    \Large \bfseries 
    \ifnum \c@secnumdepth >\m@ne
      \thechapter\hskip2ex
    \fi
    #1\par\nobreak
    \vskip 1em
  }}
\def\@makeschapterhead#1{%
  \vspace*{2em}%
  {\parindent \z@ \raggedright
    \normalfont
    \interlinepenalty\@M
    \Large \bfseries  #1\par\nobreak
    \vskip 1em
  }}

\renewcommand\section{\@startsection%
  {section}%
  {1}%
  {\z@}%
  {-2em}%
  {1em}%
  {\normalfont\bfseries\large}%
}

\renewcommand\subsection{\@startsection%
  {subsection}%
  {2}%
  {\z@}%
  {-\baselineskip}%
  {2ex}
  {\normalfont\bfseries\normalsize}%
}

\renewcommand\subsubsection{\ClassError{gradu3}{Don't use sectioning below subsection}{}}
\renewcommand\paragraph{\ClassError{gradu3}{Don't use sectioning below subsection}{}}
\renewcommand\subparagraph{\ClassError{gradu3}{Don't use sectioning below subsection}{}}

\setcounter{secnumdepth}{2}

\newenvironment{chapterquote}[1]{%
  \begin{quote}\em
  \def\gradu@quoteattr{#1}
}{%
  \\\mbox{}\hfill---~\gradu@quoteattr
  \end{quote}
  \@endparenv
}

\let\gradu@thebibliography\thebibliography
\def\thebibliography#1{%
  \iffi%
  \def\refname{L\"ahteet}%
  \def\bibname{L\"ahteet}%
  \else%
  \def\refname{References}%
  \def\bibname{References}%
  \fi%
  \gradu@thebibliography{#1}%
}

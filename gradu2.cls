% Originally written by Antti-Juhani Kaijanaho on December 2001.
% You may treat this file as if it were in the public domain.
% Subsequently modified by Matthieu Weber.

\def\filedate{2002/04/28}
\def\fileversion{1.0}
\def\fileinfo{JY MIT Gradut}
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{gradu2}[\filedate\space\fileversion\space\fileinfo]
\typeout{gradu2 <\filedate:\fileversion> - Tietotekniikan laitoksen graduille}

\newif\iffi
\fitrue

%% Input encoding
\def\gradu@inputenc{latin1}
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

\DeclareOption{finnish}{\fitrue}
\DeclareOption{english}{\fifalse}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions
\LoadClass[a4paper,12pt]{report}

\RequirePackage[\gradu@inputenc]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage[left=35mm,right=20mm,top=35mm,bottom=35mm]{geometry}
\RequirePackage[finnish,english]{babel}
\RequirePackage[numbib]{tocbibind}

\iffi
\def\gradu@msg@muistitko{Muistitko k\"aytt\"a\"a}
\def\gradu@msg@komentoa{-komentoa?}
\def\gradu@msg@progradu{pro gradu -tutkielma}
\def\termlistname{Sanasto}
\def\appendicesname{Liitteet}
\else
\def\gradu@msg@muistitko{Did you remember to use the}
\def\gradu@msg@komentoa{ command?}
\def\gradu@msg@progradu{A Master's Thesis}
\def\termlistname{Glossary}
\def\appendicesname{Appendices}
\fi

\renewcommand{\baselinestretch}{1.2}
%\linespread{1.3}

\newcounter{pages}

\AtBeginDocument{%
\pagenumbering{roman}
\iffi
\selectlanguage{finnish}
\else
\selectlanguage{english}
\fi
\maketitle
}

\AtEndDocument{%
%\addtocounter{page}{-1}%
\addtocounter{pages}{\thepage}
\immediate\write\@mainaux{\string\newlabel\string{gradu@pages\string}%
\string{\string{0\string}\string{\thepages\string}\string}}%
}
%\string\def\string\gradu@numpages\string{\thepage\string}}}

\def\gradu@muistitko#1{\textit{\gradu@msg@muistitko} \texttt{\textbackslash #1}\textit{\gradu@msg@komentoa}}

\def\gradu@title{\gradu@muistitko{title}}
\def\gradu@author{\gradu@muistitko{author}}
\def\gradu@date{\today}
\def\gradu@linja{}
\def\gradu@tyyppi{\gradu@msg@progradu}
\def\gradu@tiivistelma{\gradu@muistitko{tiivistelma}}
\def\gradu@abstract{\gradu@muistitko{abstract}}
\def\gradu@titletrans{\gradu@muistitko{translatedtitle}}
\def\gradu@avainsanat{\gradu@muistitko{avainsanat}}
\def\gradu@keywords{\gradu@muistitko{keywords}}
\def\gradu@yhteystiedot{\gradu@muistitko{yhteystiedot}}
\def\gradu@copyrightowner{\gradu@author}
\def\gradu@license{All rights reserved.}
\def\gradu@copyrightyear{\the\year}

\renewcommand{\title}[1]{\gdef\gradu@title{#1}}
\renewcommand{\author}[1]{\gdef\gradu@author{#1}}
\renewcommand{\date}[1]{\gdef\gradu@date{#1}}
\newcommand{\linja}[1]{\gdef\gradu@linja{(#1)}}
\newcommand{\tyyppi}[1]{\gdef\gradu@tyyppi{(#1)}}
\newcommand{\keywords}[1]{\gdef\gradu@keywords{\foreignlanguage{english}{#1}}}
\newcommand{\avainsanat}[1]{\gdef\gradu@avainsanat{\foreignlanguage{finnish}{#1}}}
\newcommand{\contactinformation}[1]{\gdef\gradu@yhteystiedot{#1}}
\newcommand{\yhteystiedot}[1]{\gdef\gradu@yhteystiedot{#1}}
\newcommand{\tiivistelma}[1]{\gdef\gradu@tiivistelma{\foreignlanguage{finnish}{#1}}}
\renewcommand{\abstract}[1]{\gdef\gradu@abstract{\foreignlanguage{english}{#1}}}
\newcommand{\translatedtitle}[1]{\gdef\gradu@titletrans{#1}}
\newcommand{\copyrightowner}[1]{\gdef\gradu@copyrightowner{#1}}
\newcommand{\license}[1]{\gdef\gradu@license{#1}}
\newcommand{\copyrightyear}[1]{\gdef\gradu@copyrightyear{#1}}
\newcommand{\fulltitle}{\gradu@title: \gradu@tyo}

%\@ifundefined{\csname gradu@numpages \endcsname}
%  \def\gradu@numpages{\textbf{?}}
%\fi

\newcommand{\mainmatter}{
  \tableofcontents
  \IfFileExists{\jobname.lot}{\listoftables}{}
  \IfFileExists{\jobname.lof}{\listoffigures}{}
  \setcounter{pages}{\value{page}}
  \clearpage
  \pagenumbering{arabic}
  \setcounter{chapter}{0}
}

\renewcommand{\maketitle}{%
  \begin{titlepage}%
    \vspace*{7truecm}%
    \centerline{\textbf{\gradu@author}}%
    \vspace{2truecm}%
    \centerline{\Large\textbf{\gradu@title}}%
    \vspace{4truecm}%
    \par{%
\iffi%
     \parindent9truecm\parskip0pt%
      Tietotekniikan \gradu@linja\par%
      \gradu@tyyppi%
\else%
     \parindent6truecm\parskip0pt%
      \gradu@tyyppi\par%
      in Information Technology \gradu@linja%
\fi%
      \par%
      \gradu@date%
      }%
    \vfill%
\iffi%
    \center{\large\textbf{Jyv\"askyl\"an yliopisto}}%
    \center{\textbf{Tietotekniikan laitos}}%
\else%
    \center{\large\textbf{University of Jyv\"askyl\"a}}%
    \center{\textbf{Department of Mathematical Information Technology}}%
\fi%
  \end{titlepage}%
  \newpage%
  \begin{titlepage}%
\iffi%
    \noindent\textbf{Tekij\"a:} \gradu@author\par%
    \noindent\textbf{Yhteystiedot:} \gradu@yhteystiedot\par%
    \noindent\textbf{Ty\"on nimi:} \gradu@title\par%
    \noindent\textbf{Title in English:} \gradu@titletrans\par%
    \def\gradu@tyo{Tietotekniikan %
    \gradu@linja{}\if\gradu@linja\else\ \fi\gradu@tyyppi}%
    \noindent\textbf{Ty\"o:} \gradu@tyo\par%
    \noindent\textbf{Sivum\"a\"ar\"a:} \pageref{gradu@pages}\par%
    \noindent\textbf{Tiivistelm\"a:} \gradu@tiivistelma\par%
    \noindent\textbf{English abstract:} \gradu@abstract\par%
    \noindent\textbf{Avainsanat:} \gradu@avainsanat\par%
    \noindent\textbf{Keywords:} \gradu@keywords\par%
\else%
    \noindent\textbf{Author:} \gradu@author\par%
    \noindent\textbf{Contact information:} \gradu@yhteystiedot\par%
    \noindent\textbf{Title:} \gradu@title\par%
    \noindent\textbf{Ty\"on nimi:} \gradu@titletrans\par%
    \def\gradu@tyo{\gradu@tyyppi{} in Information Technology \gradu@linja}%
    \noindent\textbf{Project:} \gradu@tyo\par%
    \noindent\textbf{Page count:} \pageref{gradu@pages}\par%
    \noindent\textbf{Abstract:} \gradu@abstract\par%
    \noindent\textbf{Suomenkielinen tiivistelm\"a:} \gradu@tiivistelma\par%
    \noindent\textbf{Keywords:} \gradu@keywords\par%
    \noindent\textbf{Avainsanat:} \gradu@avainsanat\par%
\fi%
    \bigskip%
    \noindent Copyright \copyright\ \gradu@copyrightyear\ \gradu@copyrightowner\par%
    \medskip%
    \noindent\gradu@license%
  \end{titlepage}%
  }

\newcommand{\preface}{\chapter*{\prefacename}
\addcontentsline{toc}{chapter}{\prefacename}
}

\newcommand{\termlist}{\chapter*{\termlistname}
\addcontentsline{toc}{chapter}{\termlistname}
}

\renewcommand\appendix{\par
  \addtocontents{toc}{\protect\contentsline{chapter}{\appendicesname}{}}
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
  {2em}%
  {1em}%
  {\normalfont\bfseries\large}%
}

\renewcommand\subsection{\@startsection%
  {subsection}%
  {2}%
  {\z@}%
  {\baselineskip}%
  {-2ex}%
  {\normalfont\normalsize\bfseries}%
}

\renewcommand\subsubsection{\ClassError{gradu2}{Don't use sectioning below subsection}{}}
\renewcommand\paragraph{\ClassError{gradu2}{Don't use sectioning below subsection}{}}
\renewcommand\subparagraph{\ClassError{gradu2}{Don't use sectioning below subsection}{}}

\setcounter{secnumdepth}{2}

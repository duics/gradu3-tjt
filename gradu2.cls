\def\filedate{2001/11/12}
\def\fileversion{1.0}
\def\fileinfo{JY MIT Gradut}
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{gradu2}[\filedate\space\fileversion\space\fileinfo]
\typeout{gradu2 <\filedate:\fileversion> - Tietotekniikan laitoksen graduille}

\newif\iffi
\fifalse
\DeclareOption{finnish}{\fitrue}
\DeclareOption{english}{\fifalse}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions
\LoadClass[a4paper,12pt]{report}

\iffi
\def\gradu@msg@muistitko{Muistitko k\"aytt\"a\"a}
\def\gradu@msg@komentoa{-komentoa?}
\def\gradu@msg@progradu{pro gradu -tutkielma}
\else
\def\gradu@msg@muistitko{Did you remember to use the}
\def\gradu@msg@komentoa{ command?}
\def\gradu@msg@progradu{A Master's Thesis}
\fi

\renewcommand{\baselinestretch}{1.2}
%\linespread{1.3}

\RequirePackage[T1]{fontenc}
\RequirePackage[left=35mm,right=20mm,top=35mm,bottom=35mm]{geometry}

\def\gradu@input@charset{latin1}
\newcommand{\charset}[1]{\gdef\gradu@input@charset{#1}}

\AtBeginDocument{%
\RequirePackage[\gradu@input@charset]{inputenc}
\maketitle
\thispagestyle{empty}
\setcounter{page}{2}
\null\cleardoublepage
\tableofcontents

}

\AtEndDocument{%
%\addtocounter{page}{-1}%
\immediate\write\@mainaux{\string\newlabel\string{gradu@pages\string}%
\string{\string{0\string}\string{\thepage\string}\string}}%
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
\newcommand{\translatedtitle}[1]{\gdef\gradu@titletrans{#1}}
\newcommand{\avainsanat}[1]{\gdef\gradu@avainsanat{#1}}
\newcommand{\keywords}[1]{\gdef\gradu@keywords{#1}}
\newcommand{\yhteystiedot}[1]{\gdef\gradu@yhteystiedot{#1}}
\newcommand{\copyrightowner}[1]{\gdef\gradu@copyrightowner{#1}}
\newcommand{\license}[1]{\gdef\gradu@license{#1}}
\newcommand{\copyrightyear}[1]{\gdef\gradu@copyrightyear{#1}}
\newcommand{\tiivistelma}[1]{\gdef\gradu@tiivistelma{#1}}

\newcommand{\fulltitle}{\gradu@title: \gradu@tyo}

\renewcommand{\abstract}[1]{\gdef\gradu@abstract{#1}}

%\@ifundefined{\csname gradu@numpages \endcsname}
%  \def\gradu@numpages{\textbf{?}}
%\fi

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
    \def\gradu@tyo{Tietotekniikan \gradu@linja{} \gradu@tyyppi}%
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

% gradu3.cls
%
% Originally written by Antti-Juhani Kaijanaho on December 2002.
% You may treat this file as if it were in the public domain.
% Subsequently modified by Matthieu Weber and Antti-Juhani Kaijanaho.
%
% gradu3-tjt.cls
%
% Styles based on tukielma.cls originally written by
% Asko Soukka <asko.soukka@iki.fi>. Updated to match current reporting
% guidelines and gradu3.cls by Max Salminen <max.salminen@protonmail.ch>
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                     PLEASE READ THE MANUAL!                           %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% CLASS DECLARATION

\def\graduclsdate{2017/11/30}
\def\graduclsversion{3.7}
\def\gradu@fileinfo{JY tietotekniikan gradut}
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{gradu3-tjt}[\graduclsdate\space\graduclsversion\space\gradu@fileinfo]
\typeout{gradu3-tjt <\graduclsdate:\graduclsversion> - Tietojärjestelmätieteen graduille}

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% CLASS OPTIONS

\newif\ifgradu@stdbib
\gradu@stdbibtrue

\newif\ifgradu@bsc
\gradu@bscfalse

\def\gradu@default@@type{\gradu@default@type}
\DeclareOption{bachelor}{%
  \gdef\gradu@default@@type{\gradu@bachelortype}%
  \gradu@bsctrue}
\DeclareOption{manualbib}{\gradu@stdbibfalse}

\DeclareOption{finnish}{%
  \def\selectdefaultlanguage{\selectlanguage{finnish}}%
  \def\gradu@sortlocale{fi}%
}
\DeclareOption{english}{%
  \def\selectdefaultlanguage{\selectlanguage{english}}%
  \def\gradu@sortlocale{en}%
}
\def\selectdefaultlanguage{\selectlanguage{finnish}}
\def\gradu@sortlocale{fi}

\DeclareOption*{\PassOptionsToPackage{\CurrentOption}{inputenc}}

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% LOAD BASE CLASS

\DeclareOption{draft}{\PassOptionsToClass{\CurrentOption}{report}}
\DeclareOption{final}{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions
\LoadClass[a4paper,12pt]{report}

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% REQUIRED PACKAGES

\RequirePackage{fixltx2e}
\RequirePackage{ifthen}
% Workaround for older version of chngcntr that might still exist in some
% texlive distros
% See: https://tex.stackexchange.com/questions/425600/latex-error-command-counterwithout-already-defined
\let\counterwithout\relax
\let\counterwithin\relax
% Workaround end 
\RequirePackage{chngcntr}
\RequirePackage{everyshi}[1994/12/09]
\RequirePackage{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage[left=30mm,right=30mm,top=30mm,bottom=25mm,foot=12pt]{geometry}
\RequirePackage[finnish,english]{babel}
\RequirePackage{mathptmx}
\RequirePackage[scaled=.92]{helvet}
\RequirePackage{courier}
\RequirePackage{setspace}
\RequirePackage{microtype}
\RequirePackage{mathpazo}
\ifgradu@stdbib
\RequirePackage[authordate,citetracker=true,backend=biber,maxcitenames=1,sortlocale=\gradu@sortlocale,noibid]{biblatex-chicago}
\fi

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% INTERNAL HELPER COMMANDS

% Generic list support
\let\gradu@listitem\relax
\def\gradu@appendlist#1#2{%
  \expandafter\gdef\expandafter#1\expandafter{#1\gradu@listitem{#2}}}
\def\gradu@map#1#2{{\let\gradu@listitem#1#2}}

% use this instead of \vspace* on the top of a page
\def\gradu@topvspace#1{%
  \vspace*{-\topskip}%
  \vspace{#1}%
  \vspace{-\parskip}%
  \nointerlineskip%
}

% For use inside \titlepage\ for parts that are optional for BSc
\def\gradu@bsc@optional#1#2{%
  \ifthenelse{\equal{\csname gradu@#2\endcsname}{\relax}}{%
    \ifgradu@bsc\else%
    \noindent\textbf{#1:} \gradu@muistitko{#2}\par%
    \fi%
  }{%
    \noindent\textbf{#1:} \csname gradu@#2\endcsname\par%
  }%
}

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% METADATA COMMANDS

% From Gradu3.cls

\def\gradu@muistitko#1{\textit{\gradu@msg@muistitko} \texttt{\textbackslash #1}\textit{\gradu@msg@komentoa}}

\def\gradu@metadatacommands{}
\def\gradu@DeclareMetadataCommand#1#2{%
  \gradu@appendlist\gradu@metadatacommands{#1}%
  \expandafter\def\csname#1\endcsname##1{%
    \expandafter\gdef\csname gradu@#1\endcsname{##1}%
  }%
  \ifthenelse{\equal{\noexpand #2}{}}{%
    \expandafter\def\csname gradu@#1\endcsname{%
      \gradu@muistitko{#1}
    }%
  }{%
    \expandafter\def\csname gradu@#1\endcsname{#2}
  }%
}
\newcounter{gradu@listrender@count}
\def\gradu@DeclareMetadataListCommand#1{%
  \newcounter{gradu@#1@count}%
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
      {%
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
      }%
    }%
  }%
}
\gradu@DeclareMetadataCommand{title}{}
\gradu@DeclareMetadataCommand{translatedtitle}{}
\gradu@DeclareMetadataCommand{university}{\gradu@default@university}
\gradu@DeclareMetadataCommand{department}{\gradu@default@department}
\gradu@DeclareMetadataCommand{subject}{\gradu@default@subject}
\gradu@DeclareMetadataCommand{studyline}{\relax}
\gradu@DeclareMetadataCommand{type}{\gradu@default@@type}
\gradu@DeclareMetadataCommand{location}{\gradu@default@location}
%\gradu@DeclareMetadataCommand{tiivistelma} -- needs \long
%\gradu@DeclareMetadataCommand{abstract} -- needs \long
\gradu@DeclareMetadataCommand{avainsanat}{}
\gradu@DeclareMetadataCommand{keywords}{}
\gradu@DeclareMetadataListCommand{author}
\gradu@DeclareMetadataListCommand{supervisor}
\gradu@DeclareMetadataListCommand{contactinformation}

\def\gradu@date{\today}
\def\gradu@year{\the\year}

\renewcommand{\date}[1]{%
  \ClassWarning{gradu3}{\noexpand\date is deprecated!}%
  \gdef\gradu@date{#1}%
}
\newcommand{\setdate}[3]{\gdef\day{#1}\gdef\month{#2}\year=#3}

\def\gradu@tiivistelma{\gradu@muistitko{tiivistelma}}
\long\def\tiivistelma#1{\gdef\gradu@tiivistelma{\begin{foreignlanguage}{finnish}#1\end{foreignlanguage}}}
\def\gradu@abstract{\gradu@muistitko{abstract}}
\long\def\abstract#1{\gdef\gradu@abstract{\begin{foreignlanguage}{english}#1\end{foreignlanguage}}}

%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%% BASIC FORMATTING

% This matches Word 1.5 line spacing in our empirical tests.
% \renewcommand{\baselinestretch}{1.43}

% Show all names on first and et. al. next citation
\AtEveryCitekey{\ifciteseen{}{\defcounter{maxnames}{99}}}

% From datakurre/tutkielma
\singlespacing

\newcommand{\tablefontsize}{\footnotesize}
\newcommand{\quotefontsize}{\footnotesize}
\newcommand{\examplefontsize}{\footnotesize}
\newcommand{\tablespacing}{\singlespacing}
\newcommand{\quotespacing}{\singlespacing}
\newcommand{\examplespacing}{\singlespacing}
\newcommand{\captionfontsize}{\footnotesize}

\widowpenalty10000
\clubpenalty10000

% From gradu3.cls

\setlength\parindent{1cm}
\setlength\parskip{0pt}
\ifgradu@stdbib
\setlength\bibhang{0pt}
\fi

\def\@listi{%
  \leftmargin\leftmargini%
  \parsep 10pt%
  \topsep 0pt%
  \itemsep -10pt%
}
\let\@listI\listi
\@listi
\def\@listii{%
  \leftmargin\leftmarginii%
  \labelwidth\leftmarginii%
  \advance\labelwidth-\labelsep%
  \topsep    0pt%
  \parsep    10pt%
  \itemsep   -10pt%
}
\def\@listiii{%
  \leftmargin\leftmarginiii%
  \labelwidth\leftmarginiii%
  \advance\labelwidth-\labelsep%
  \topsep    0pt%
  \parsep    10pt%
  \itemsep   -10pt%
}
\def\@listiv{%
  \leftmargin\leftmarginiv%
  \labelwidth\leftmarginiv%
  \advance\labelwidth-\labelsep%
}
\def\@listv{%
  \leftmargin\leftmarginv%
  \labelwidth\leftmarginv%
  \advance\labelwidth-\labelsep%
}
\def\@listvi{%
  \leftmargin\leftmarginvi%
  \labelwidth\leftmarginvi%
  \advance\labelwidth-\labelsep%
}

\long\def\@makecaption#1#2{%
  \vskip\abovecaptionskip%
  \sbox\@tempboxa{#1. #2}%
  \ifdim \wd\@tempboxa >\hsize%
    #1. #2\par%
  \else
    \global \@minipagefalse%
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
  \fi%
  \vskip\belowcaptionskip%
}

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% LOCALIZATION

\ifgradu@stdbib
\DefineBibliographyStrings{finnish}{%
  bibliography={L\"AHTEET},%
  andothers={ym\adddot}%
}
\DefineBibliographyStrings{english}{%
  bibliography={REFERENCES}%
}
\fi

\addto\captionsfinnish{%
  \def\gradu@msg@muistitko{Muistitko k\"aytt\"a\"a}%
  \def\gradu@msg@komentoa{-komentoa?}%
  \def\termlistname{Termiluettelo}%
  \def\tocname{SIS\"ALLYS}%
  \def\appendicesname{LIITTEET}%
  \def\listfigurename{KUVIOT}%
  \def\listtablename{TAULUKOT}%
  \def\figurename{KUVIO}%
  \def\gradu@default@university{Jyv\"askyl\"an yliopisto}%
  \def\gradu@default@location{Jyv\"askyl\"a}%
  \def\gradu@default@department{Informaatioteknologian tiedekunta}%
  \def\gradu@default@subject{Tietojärjestelmätiede}%
  \def\gradu@default@type{pro gradu -tutkielma}%
  \def\gradu@bachelortype{kandidaatintutkielma}%
}
\addto\captionsenglish{%
  \def\gradu@msg@muistitko{Did you remember to use the}%
  \def\gradu@msg@komentoa{ command?}%
  \def\termlistname{Glossary}%
  \def\tocname{CONTENTS}%
  \def\appendicesname{Appendices}%
  \def\listfigurename{FIGURES}%
  \def\listtablename{TABLES}%
  \def\gradu@default@university{University of Jyv\"askyl\"a}%
  \def\gradu@default@location{Jyv\"askyl\"a}%
  \def\gradu@default@department{Faculty of Information Technology}%
  \def\gradu@default@subject{Information systems science}%
  \def\gradu@default@type{Master's Thesis}%
  \def\gradu@bachelortype{Bachelor's Thesis}%
}
\AtBeginDocument{\selectdefaultlanguage}

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% COUNTING THE NUMBER OF PAGES

\newcounter{gradu@pagecount@main}
\newcounter{gradu@pagecount@app}
\newcounter{gradu@pagecount@total}
\def\gradu@pagecount@curr{gradu@pagecount@main}
\def\gradu@pagecount@curr{gradu@pagecount@total}
\EveryShipout{%
  \addtocounter{\gradu@pagecount@curr}{1}%
}

\AtEndDocument{%
  \clearpage%
  \immediate\write\@auxout%
  {\string\gdef\string\gradu@MainPageCount{\thegradu@pagecount@main}}%
  \immediate\write\@auxout%
  {\string\gdef\string\gradu@AppPageCount{\thegradu@pagecount@app}}%
  \immediate\write\@auxout%
  {\string\gdef\string\gradu@TotalPageCount{\thegradu@pagecount@total}}%
}

\def\gradu@AppPageCount{\textbf{?}}
\def\gradu@MainPageCount{\textbf{?}}
\def\gradu@TotalPageCount{\textbf{?}}

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% FORMATTING THE TITLE PAGE

\newcommand{\gradu@toolate}{%
  \ClassError{gradu3}{%
    \iflanguage{finnish}{%
      Bibliografiatietoja ei voi antaa enaa otsikkosivun jalkeen.%
    }{%
      Bibliographical data cannot be given after the title page.%
    }
  }{%
    \iflanguage{finnish}{%
      Komennot kuten \string\title voi antaa vain ennen
      \string\maketitle-komentoa.
    }{%
      You can give commands like  title only before
      the \string\maketitle command.
    }%
  }%
}

\renewcommand{\maketitle}{%
}

% Converts the first character of the (expanded) argument to upper case.
\def\gradu@HeadToUpper#1{%
  \edef\fooA{#1}%
  \def\fooB##1{##1}%
  \def\fooC##1##2\relax{\uppercase{\fooB{##1}}##2}%
  \expandafter\fooC\fooA\relax%
}

\renewcommand{\maketitle}{%
  {%
    %%%% TITLE PAGE
    \begin{titlepage}%
      \thispagestyle{empty}
      \renewcommand\Large{\@setfontsize\Large{16}{16}}
      \begin{singlespace}%
        \mbox{}\vfill%
          {%
            \def\gradu@f##1{\centerline{\textbf{##1}}}%
            \gradu@map\gradu@f\gradu@author\par%
          }%
        \begin{onehalfspace}%
        \begin{center}%
        \Large\textbf{%
          \MakeUppercase{\gradu@title}}%
        \end{center}%
        \begin{center}%
        \Large\textbf{%
          % \MakeUppercase{\gradu@titlesecond}
        }%
        \end{center}%
        \end{onehalfspace}%
        \newcommand{\tablefontsizeorig}{\tablefontsize}
        \newcommand{\tablespacingorig}{\tablespacing}
        \renewcommand{\tablefontsize}{\tablefontsizeorig}
        \renewcommand{\tablespacing}{\tablespacingorig}
        \vfill%
        \begin{center}%
          \includegraphics[height=2.7cm]{logo.jpg}\par%
          \MakeUppercase{\gradu@university}\par%
          \MakeUppercase{\gradu@department}\par%
          \gradu@year\par%
        \end{center}%
      \end{singlespace}%
    \end{titlepage}%
    \newpage%
    %%% METADATA PAGE
    % Main abstract
    \iflanguage{finnish}{%
      \subsection*{TIIVISTELM\"A}
    }{%
      \subsection*{ABSTRACT}
    }%
    \thispagestyle{empty}
    \noindent\textbf{\ifthenelse{\value{gradu@author@count}>1}{s}{}}%
    \gradu@author@render{\\\space}{\\\space\\\space}\\
    \iflanguage{finnish}{%
      \noindent\gradu@title\\
      \noindent\gradu@location: \gradu@default@university, \gradu@year, \gradu@TotalPageCount p.\\
      \noindent\gradu@subject, \gradu@type\par
      \vspace{0.5cm}
      \noindent\gradu@tiivistelma\par%
      \vspace{0.5cm}
      \noindent Avainsanat: \gradu@avainsanat
      \newpage
    }{%
    \begin{otherlanguage}{english}
      \noindent\gradu@title\\
      \noindent\gradu@location: \gradu@default@university, \gradu@year, \gradu@TotalPageCount p.\\
      \noindent\gradu@subject, \gradu@type\par
      \vspace{0.5cm}
      \noindent\gradu@abstract\par%
      \vspace{0.5cm}
      \noindent Keywords: \gradu@keywords
      \newpage
    \end{otherlanguage}
    }%
    % Foreign abstract
    \iflanguage{finnish}{%
      \subsection*{ABSTRACT}
    }{%
      \subsection*{TIIVISTELM\"A}
    }%
    \thispagestyle{empty}
    \noindent%
    \noindent\textbf{\ifthenelse{\value{gradu@author@count}>1}{s}{}}%
    \gradu@author@render{\\\space}{\\\space\\\space}\\
    \iflanguage{finnish}{%
      \noindent\gradu@translatedtitle\\
      \noindent\gradu@location: \gradu@university, \gradu@year, \gradu@TotalPageCount s.\\
      \noindent\gradu@subject, \gradu@type\par
      \vspace{0.5cm}
      \noindent\gradu@abstract\par
      \vspace{0.5cm}
      \noindent Keywords: \gradu@keywords
      \newpage
    }{%
    \begin{otherlanguage}{finnish}
      \noindent\gradu@translatedtitle\\
      \noindent\gradu@location: \gradu@university, \gradu@year, \gradu@TotalPageCount s.\\
      \noindent\gradu@subject, \gradu@type\par
      \vspace{0.5cm}
      \noindent\gradu@tiivistelma\par%
      \vspace{0.5cm}
      \noindent Avainsanat: \gradu@avainsanat
      \newpage
    \end{otherlanguage}
    }%
    %%% POSTPROCESSING
    \def\gradu@f##1{%
      \expandafter\gdef\csname##1\endcsname{\gradu@toolate}%
    }%
    \gradu@map\gradu@f\gradu@metadatacommands%
  }%
  \global\let\author\gradu@toolate%
  \global\let\date\gradu@toolate%  
  \global\let\tiivistelma\gradu@toolate%  
  \global\let\abstract\gradu@toolate%  
}

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% LIST OF FIGURES AND TABLES; THE TABLE OF CONTENTS

\counterwithout{figure}{chapter}
\counterwithout{table}{chapter}

\setcounter{tocdepth}{3}
\renewcommand{\@dotsep}{1}
\renewcommand{\@pnumwidth}{2ex}
\def\l@chapter#1{%
  \vspace{10pt}%
  \@dottedtocline{2}{0cm}{1cm}{\uppercase{#1}}%
}
\renewcommand{\l@section}   {\@dottedtocline{2}{1cm}{1cm}}
\renewcommand{\l@subsection}{\@dottedtocline{3}{2cm}{1cm}}
\renewcommand{\l@figure}    {\@dottedtocline{1}{0cm}{1cm}}
\renewcommand{\l@table}     {\@dottedtocline{1}{0cm}{1cm}}
% The lists are automatically generated by the class, no user commands needed
\let\listoftables\@undefined
\let\listoffigures\@undefined
\let\tableofcontents\@undefined

\newcommand{\mainmatter}{%
  % lists of figures and tables and contents
  {%
    \setlength\parskip{0pt}%
    \def\addvspace##1{}%
    \ifthenelse{\gradu@FigureCount = 0 \and \gradu@TableCount = 0}{}{%
      \clearpage%
      \gradu@topvspace{12pt}%
    }
    \ifthenelse{\gradu@FigureCount = 0}{%
      \gradu@opentocfile{lof}%
    }{%
      {%
        \section*{\listfigurename}%
        \renewcommand{\baselinestretch}{1}\normalfont%
        \def\numberline##1{\figurename~##1.~}%
        \@starttoc{lof}%
      }%
      \vspace{24pt}%
    }%
    \ifthenelse{\gradu@TableCount = 0}{%
      \gradu@opentocfile{lot}%
    }{%
      {%
        \section*{\listtablename}%
        \renewcommand{\baselinestretch}{1}\normalfont%
        \def\numberline##1{\tablename~##1.~}%
        \@starttoc{lot}%
      }%
    }%
    \thispagestyle{empty}
    \clearpage%
    \subsection*{\tocname}%
    \renewcommand{\baselinestretch}{1}\normalfont%
    {\setlength{\parindent}{0cm}%
      \iflanguage{finnish}{%
        TIIVISTELM\"A \\
      }{%
        ABSTRACT \\
      }%
      \iflanguage{finnish}{%
        ABSTRACT \\
      }{%
        TIIVISTELM\"A \\
      }%
    }%
    \listfigurename \\
    \listtablename \\
    \vspace{-10pt}%
    \@starttoc{toc}%
    \thispagestyle{empty}
  }%
  \clearpage%
  \setcounter{chapter}{0}%
}

% This is automatically done by \@starttoc, but we need to do it
% manually when we don't actually call \@starttoc, so that the
% corresponding file is written to.  Otherwise, we'd first get an
% empty list with a section title and then, on the third run, would
% the list be actually there.
\def\gradu@opentocfile#1{%
  \if@filesw%
    \expandafter\newwrite\csname tf@#1\endcsname%
    \immediate\openout \csname tf@#1\endcsname \jobname.#1\relax%
  \fi%
}
\def\gradu@FigureCount{0}
\def\gradu@TableCount{0}
\AtEndDocument{%
  \clearpage%
  \immediate\write\@auxout%
  {\string\gdef\string\gradu@FigureCount{\the\c@figure}}%
  \immediate\write\@auxout%
  {\string\gdef\string\gradu@TableCount{\the\c@table}}%
}

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% CHAPTERS AND SECTIONS

\def\gradu@chapterheadline#1{%
  {%
    \parindent \z@ \raggedright%
    \normalfont%
    \interlinepenalty\@M%
    \Large \bfseries%
    #1\par\nobreak%
    \vskip 1cm%
  }%
}

\setcounter{secnumdepth}{2}
\def\@makechapterhead#1{%
  \gradu@topvspace{12pt}%
  \gradu@chapterheadline{%
    \ifnum \c@secnumdepth >\m@ne%
    \thechapter\hskip2ex%
    \fi%
    #1%
  }%
}
\def\@makeschapterhead#1{%
  \gradu@topvspace{12pt}%
  \gradu@chapterheadline{#1}%
  \ifthenelse{\equal{\thepage}{\arabic{page}}}{%
    \phantomsection%
    \addcontentsline{toc}{chapter}{#1}%
  }{}%
}

\renewcommand\section{\@startsection%
  {section}%
  {1}%
  {\z@}%
  {18pt}%
  {18pt}%
  {\normalfont\bfseries\large}%
}

\renewcommand\subsection{\@startsection%
  {subsection}%
  {2}%
  {\z@}%
  {18pt}%
  {18pt}%
  {\normalfont\bfseries\normalsize}%
}

\def\gradu@forbiddensection{\ClassError{gradu3}{Don't use sectioning below subsection}{}}
\let\subsubsection\gradu@forbiddensection
\let\paragraph\gradu@forbiddensection
\let\subparagraph\gradu@forbiddensection

\newcommand{\preface}{\chapter*{\prefacename}}

\newenvironment{thetermlist}{% begin
  \chapter*{\termlistname}%
  \begin{list}{% default label
      \texttt{\string\item[\textrm{\textit{%
            \iflanguage{finnish}{%
              T\"am\"a jäi tyhjäksi!%
            }{%
              You left this blank!%
            }%
          }}]}%
    }{%declarations
      \renewcommand{\makelabel}[1]{##1\hfill}%
      \setlength{\labelwidth}{4.8cm}%
      \setlength{\labelsep}{0.2cm}%
      \setlength{\leftmargin}{5cm}%
    }
}{% end
  \end{list}
}

\renewcommand\appendix{\par\clearpage%
  \gdef\gradu@pagecount@curr{gradu@pagecount@app}%
  \gdef\gradu@pagecount@curr{gradu@pagecount@total}%
  \chapter*{\appendicesname}%
  \setcounter{section}{0}%
  \gdef\thesection{\@Alph\c@section}%
  \renewcommand{\chapter}{%
    \ClassError{gradu3}{%
      \iflanguage{finnish}{%
        \string\chapter-komentoa ei saa kayttaa liitteissa%
      }{%
        The \string\chapter command cannot be used in the appendices%
      }%
    }{%
      \iflanguage{finnish}{%
        Kayta sen sijasta \string\section-komentoa.%
      }{%
        Use the \string\section command instead.%
      }%
    }%
  }%
}

\newenvironment{chapterquote}[1]{%
  \begin{quote}\em%
  \def\gradu@quoteattr{#1}%
}{%
  \\\mbox{}\hfill---~\gradu@quoteattr%
  \end{quote}%
  \@endparenv%
}

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

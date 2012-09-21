% Originally written by Antti-Juhani Kaijanaho on December 2002.
% You may treat this file as if it were in the public domain.
% Subsequently modified by Matthieu Weber and Antti-Juhani Kaijanaho.
% Currently maintained by Antti-Juhani Kaijanaho <antti-juhani.kaijanaho@jyu.fi>

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                     PLEASE READ THE MANUAL!                           %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% CLASS DECLARATION

\def\filedate{2012/09/21}
\def\fileversion{3.0pre4}
\def\fileinfo{JY MIT Gradut}
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{gradu3}[\filedate\space\fileversion\space\fileinfo]
\typeout{gradu3 <\filedate:\fileversion> - Tietotekniikan laitoksen graduille}

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% CLASS OPTIONS

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

\DeclareOption{finnish}{\def\selectdefaultlanguage{\selectlanguage{finnish}}}
\DeclareOption{english}{\def\selectdefaultlanguage{\selectlanguage{english}}}

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% LOAD BASE CLASS

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions
\LoadClass[a4paper,12pt]{report}

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% REQUIRED PACKAGES

\RequirePackage{ifthen}
\RequirePackage{chngcntr}
\RequirePackage{everyshi}[1994/12/09]
\RequirePackage[\gradu@inputenc]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage[left=35mm,right=20mm,top=35mm,bottom=35mm,nohead]{geometry}
\RequirePackage[finnish,english]{babel}
\RequirePackage{mathptmx}
\RequirePackage[scaled=.92]{helvet}
\RequirePackage{courier}
\RequirePackage[authordate,backend=biber]{biblatex-chicago}

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% INTERNAL HELPER COMMANDS

% Generic list support
\let\gradu@listitem\relax
\def\gradu@appendlist#1#2{\xdef#1{#1\noexpand\gradu@listitem{#2}}}
\def\gradu@map#1#2{\begingroup\let\gradu@listitem#1#2\endgroup}

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% METADATA COMMANDS

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
\gradu@DeclareMetadataCommand{laitos}{\gradu@default@laitos}
\gradu@DeclareMetadataCommand{aine}{\gradu@default@aine}
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

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% BASIC FORMATTING

\renewcommand{\baselinestretch}{1.2} % this makes for a 1.45 line spacing

\setlength\parindent{0pt}
\setlength\parskip{10pt}

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% LOCALIZATION

\DefineBibliographyStrings{finnish}{%
  bibliography={L\"ahteet}%
}

\addto\captionsfinnish{%
  \def\gradu@msg@muistitko{Muistitko k\"aytt\"a\"a}%
  \def\gradu@msg@komentoa{-komentoa?}%
  \def\termlistname{Termiluettelo}%
  \def\appendicesname{Liitteet}%
  \def\listfigurename{Kuviot}%
  \def\listtablename{Taulukot}%
  \def\figurename{Kuvio}%
  \def\gradu@default@laitos{Tietotekniikan laitos}%
  \def\gradu@default@aine{Tietotekniikan}%
}
\addto\captionsenglish{
  \def\gradu@msg@muistitko{Did you remember to use the}
  \def\gradu@msg@komentoa{ command?}
  \def\termlistname{Glossary}
  \def\appendicesname{Appendices}
  \def\graduDefaultLaitos{Department of Mathematical Information Technology}
  \def\gradu@default@aine{in Information Technology}%
}
\AtBeginDocument{\selectdefaultlanguage}

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% COUNTING THE NUMBER OF PAGES

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

\pagenumbering{roman}
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
  \iflanguage{finnish}{%
    \gradu@aine{} \gradu@tyyppi%
  }{%
    \gradu@type{} \gradu@aine%
  }%
  \par%
  \raggedleft
  \gradu@date%
  \vfill%
  \vspace{1truecm plus 1truecm minus .5truecm}%
  \iflanguage{finnish}{%
    \center{\large\textbf{\gradu@yliopisto}}%
  }{%
    \center{\large\textbf{\gradu@university}}%
  }%
  \center{\textbf{\gradu@laitos}}%
\end{titlepage}%
\newpage%
%%% METADATA PAGE
  \noindent%
  \iflanguage{finnish}{%
    \textbf{Tekij\"a\ifthenelse{\value{gradu@author@count}>1}{t}{}:} %
    \gradu@author@render{,\space}{\space ja\space}\par%
  }{%
    \noindent\textbf{Author\ifthenelse{\value{gradu@author@count}>1}{s}{}:} %
    \gradu@author@render{,\space}{,\space and\space}\par%
  }%
  \iflanguage{finnish}{%
    \noindent\textbf{Yhteystiedot:} %
    \gradu@yhteystiedot@render{,\space}{\space ja\space}\par%
  }{%
    \noindent\textbf{Contact information:}
    \gradu@yhteystiedot@render{,\space}{,\space and\space}\par%
  }%
  \noindent{%
    \textbf{%
      \iflanguage{finnish}{%
        Ohjaaja\ifthenelse{\value{gradu@ohjaaja@count}>1}{t}{}:%
      }{%
        Supervisor\ifthenelse{\value{gradu@ohjaaja@count}>1}{s}{}:%
      }%
    }\space%
    \iflanguage{finnish}{%
      \gradu@ohjaaja@render{,\space}{\space ja\space}\par%
    }{%
      \gradu@ohjaaja@render{,\space}{,\space and\space}\par%
    }%
  }\par%
  \iflanguage{finnish}{%
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
  }{%
    \noindent\textbf{Title:} {\let\\\relax \gradu@title\par}%
    \noindent\textbf{Ty\"on nimi:} \gradu@translatedtitle\par%
    \noindent\textbf{Project:} \gradu@type\par%
    \noindent\textbf{Study line:} \gradu@linja\par%
    \noindent\textbf{Page count:} \gradu@MainPageCount+\gradu@AppPageCount\par%
    \noindent\textbf{Abstract:} \gradu@abstract\par%
    \noindent\textbf{Keywords:} \gradu@keywords\par%
    \noindent\textbf{Suomenkielinen tiivistelm\"a:} \gradu@tiivistelma\par%
    \noindent\textbf{Avainsanat:} \gradu@avainsanat\par%
  }%
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

\newcommand{\mainmatter}{
  % lists of figures and tables and contents
  \begingroup%
  \setlength\parskip{0pt}%
  \def\addvspace##1{}%
  \clearpage%
  \begingroup%
  \def\numberline##1{\figurename~##1.~}
  \@makeschapterhead{\listfigurename}
  \vspace{-10pt}%
  \@starttoc{lof}
  \def\numberline##1{\tablename~##1.~}
  \@makeschapterhead{\listtablename}
  \vspace{-10pt}%
  \@starttoc{lot}
  \endgroup%
  \clearpage%
  \@makeschapterhead{\contentsname}
  \vspace{-10pt}%
  \@starttoc{toc}%
  \endgroup%
  \clearpage
  \pagenumbering{arabic}
  \setcounter{chapter}{0}
}

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% CHAPTERS AND SECTIONS

\setcounter{secnumdepth}{2}
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
  }%
  \ifthenelse{\equal{\thepage}{\arabic{page}}}{%
    \phantomsection%
    \addcontentsline{toc}{chapter}{#1}%
  }{}%
}

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

\newcommand{\preface}{\chapter*{\prefacename}}

\newenvironment{thetermlist}{% begin
  \chapter*{\termlistname}%
  \begin{list}{% default label
      \texttt{\string\item[\textrm{\textit{%
            \iflanguage{finnish}{%
              Tämä jäi tyhjäksi!%
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
  }
}

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% MISCELLANEOUS

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
  \iflanguage{finnish}{%
    \def\refname{L\"ahteet}%
    \def\bibname{L\"ahteet}%
  }{%
    \def\refname{References}%
    \def\bibname{References}%
  }%
  \gradu@thebibliography{#1}%
}

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

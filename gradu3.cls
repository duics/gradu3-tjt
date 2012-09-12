% Originally written by Antti-Juhani Kaijanaho on December 2002.
% You may treat this file as if it were in the public domain.
% Subsequently modified by Matthieu Weber and Antti-Juhani Kaijanaho.
% Currently maintained by Antti-Juhani Kaijanaho <antti-juhani.kaijanaho@jyu.fi>

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                     PLEASE READ THE MANUAL!                           %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\filedate{2012/09/12}
\def\fileversion{3.0pre1}
\def\fileinfo{JY MIT Gradut}
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{gradu3}[\filedate\space\fileversion\space\fileinfo]
\typeout{gradu3 <\filedate:\fileversion> - Tietotekniikan laitoksen graduille}

%% Some packages need special handling if the output is PDF, this \if is just
%% in case we need it
\newif\ifgradu@pdf
\ifx\pdfoutput\undefined
  \gradu@pdffalse
\else
  \ifnum\pdfoutput=1
    \gradu@pdftrue
  \else
    \gradu@pdffalse
  \fi
\fi

\newif\iffi
\fitrue

\newif\ifnottoc
\nottoctrue

\newif\ifshortthesis
\shortthesisfalse
\def\gradu@baseclass{\ifshortthesis article\else report\fi}

\newif\ifgradu@hyperref
\gradu@hyperreffalse

\newif\ifaltlinespread
\altlinespreadfalse

\def\gradu@muistitko#1{\textit{\gradu@msg@muistitko} \texttt{\textbackslash #1}\textit{\gradu@msg@komentoa}}

\def\gradu@title{\gradu@muistitko{title}}
\def\gradu@author{\gradu@muistitko{author}}
\def\gradu@date{\today}
\def\gradu@paikka{Jyv\"askyl\"a}
\def\gradu@yliopisto{Jyv\"askyl\"an yliopisto}
\def\gradu@university{University of Jyv\"askyl\"a}
\def\gradu@laitos{%
  \iffi%
  Tietotekniikan laitos%
  \else%
  Department of Mathematical Information Technology%
  \fi%
}
\def\gradu@aine{%
  \iffi%
  Tietotekniikan%
  \else%
  in Information Technology%
  \fi%
}
\def\gradu@linja{}
\def\gradu@tyyppi{pro gradu -tutkielma}
\def\gradu@type{Master's Thesis}
\def\gradu@tiivistelma{\gradu@muistitko{tiivistelma}}
\def\gradu@abstract{\gradu@muistitko{abstract}}
\def\gradu@titletrans{\gradu@muistitko{translatedtitle}}
\def\gradu@avainsanat{\gradu@muistitko{avainsanat}}
\def\gradu@keywords{\gradu@muistitko{keywords}}
%\def\gradu@yhteystiedot{\gradu@muistitko{yhteystiedot}}
\def\gradu@acmccs{}
\def\gradu@ysa{}

\def\gradu@authors{}

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
\DeclareOption{utf8}{\gdef\gradu@inputenc{utf8}}

\DeclareOption{toc}{\nottocfalse}
\DeclareOption{nottoc}{\nottoctrue}

\DeclareOption{shortthesis}{\shortthesistrue}

\DeclareOption{kandi}{\shortthesistrue%
  \gdef\gradu@tyyppi{kandidaatintutkielma}%
  \gdef\gradu@type{Bachelor's Thesis}%
}

\let\gradu@lof\relax
\let\gradu@lot\relax
\DeclareOption{lof}{\gdef\gradu@lof{\listoffigures}}
\DeclareOption{lot}{\gdef\gradu@lot{\listoftables}}


\DeclareOption{finnish}{\fitrue}
\DeclareOption{english}{\fifalse}

\DeclareOption{altlinespread}{\altlinespreadtrue}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{\gradu@baseclass}}
\ProcessOptions
\LoadClass[a4paper,12pt]{\gradu@baseclass}

%\RequirePackage{color}
\RequirePackage{everyshi}[1994/12/09]
\RequirePackage[\gradu@inputenc]{inputenc}
\RequirePackage[T1]{fontenc}
\ifaltlinespread
\renewcommand{\baselinestretch}{1.5}
\else
\renewcommand{\baselinestretch}{1.2}
\fi
\RequirePackage[left=35mm,right=20mm,top=35mm,bottom=35mm,nohead]{geometry}
\RequirePackage[finnish,english]{babel}
\ifnottoc
\RequirePackage[nottoc]{tocbibind}
\else  %nottoc
\RequirePackage{tocbibind}
\fi %nottoc

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

\newcounter{pages}

\iffi
\def\selectdefaultlanguage{\selectlanguage{finnish}}
\else
\def\selectdefaultlanguage{\selectlanguage{english}}
\fi

%% This requires extensive explanation.
%%
%% Defining the command that displays the total number of pages requires to know
%% if hyperref is loaded or not, because it relies on \if-commands that do not
%% exist unless hyperref is loaded.
%%   But hyperref must be loaded by the user, not by gradu3, because hyperref
%% overwrites definitions made in many packages. The user may use such
%% packages, therefore hyperref must be loaded *after* these packages. In
%% addition, hyperref must be loaded before packages based on the float package,
%% because the latter is incompatible with hyperref.
%% gradu3 therefore expects the user to potentially load hyperref, and if it is
%% the case, it defines \TotPages@putlabel just before \begin{document}. This
%% could not be done with \AtBeginDocument, because hyperref also uses
%% \AtBeginDocument extensively, and gradu3' \AtBeginDocument{\def\@schapter...}
%% would have been executed *before* hyperref is loaded (\begin{document} hooks
%% are executed in the same order they are defined, and gradu3 would define its
%% hook before hyperref defines its ones).  Defining a hook in a hook i.e.,
%% \AtBeginDocument{\AtBeginDocument{\def\whatever}} does not work, gradu3
%% therefore needs to define its own hook, independently from the normal
%% \begin{document} hooks. The proper way of doing so would be to redefine
%% \document, but for some obscure reason, this does not work. The working
%% solution consists in redefining \begin and check if it is \begin{document}
%% (and then execute gradu3' own hook before actually executing
%% \begin{document}) or \begin{sometingelse} (then do nothing special).
%%   gradu3' own hook is one \AtBeginDocument that puts its own commands after every others
%% (defining \TotPages@putlabel, then calling \maketitle).

%%%% Begin dirty hack
\def\gradu@before@begin@document{
\AtBeginDocument{%
  \@ifpackageloaded{hyperref}{
  \gradu@hyperreftrue
  \def\toclevel@schapter{0}%
  \def\toclevel@appendix{0}%
  \def\toclevel@algorithm{0}%

   \define@Hy@TotPages@putlabel
   }{%
   \gradu@hyperreffalse
   \define@TotPages@putlabel
   }%
   \pagenumbering{roman}
   \selectdefaultlanguage
   \maketitle
}}

\RequirePackage{ifthen}
\let\gradu@begin=\begin
\renewcommand*{\begin}[1]{%
\ifthenelse{\equal{#1}{document}}{%
\gradu@before@begin@document
}{}%
\gradu@begin{#1}%
}
%%%% End dirty hack

\newcounter{TotPages}
\EveryShipout{\stepcounter{TotPages}}

%% The definition of \TotPages@putlabel must be delayed, since hyperref is not
%% yet loaded at this point, all the \ifHy@xxx are undefined but latex
%% still complains about the corresponding \fi
\def\define@Hy@TotPages@putlabel{
\def\TotPages@putlabel{%
  \addtocounter{page}{-1}%
  \if@filesw
    \begingroup
      \ifHy@pageanchor
        \ifHy@hypertexnames
          \ifHy@plainpages
             \def\Hy@temp{\arabic{page}}%
          \else
             \let\textlatin\@firstofone
             \edef\Hy@temp{\thepage}%
          \fi
        \else
          \def\Hy@temp{\the\Hy@pagecounter}%
        \fi
      \fi
      \immediate\write\@mainaux{%
          \string\newlabel{TotPages}{{\theTotPages}{\thepage}{}{%
          \ifHy@pageanchor page.\Hy@temp\fi
        }{}}%
      }%
    \endgroup
  \fi
  \addtocounter{page}{1}%
}}
\def\define@TotPages@putlabel{
\def\TotPages@putlabel{%
  \addtocounter{page}{-1}%
  \if@filesw
    \begingroup
      \immediate\write\@mainaux{%
          \string\newlabel{TotPages}{{\theTotPages}{\thepage}}%
      }%
    \endgroup
  \fi
  \addtocounter{page}{1}%
}}%

\AtEndDocument{%
\clearpage\TotPages@putlabel
}


\renewcommand{\title}[1]{\gdef\gradu@title{#1}}
\renewcommand{\author}[1]{\gdef\gradu@authors{#1}}

\renewcommand{\date}[1]{%
  \ClassWarning{gradu3}{\noexpand\date is deprecated!}%
  \gdef\gradu@date{#1}%
}
\newcommand{\setdate}[3]{\gdef\day{#1}\gdef\month{#2}\year=#3}
\newcommand{\paikka}[1]{\gdef\gradu@paikka{#1}}
\newcommand{\yliopisto}[1]{\gdef\gradu@yliopisto{#1}}
\newcommand{\university}[1]{\gdef\gradu@university{#1}}
\newcommand{\laitos}[1]{\gdef\gradu@laitos{#1}}
\newcommand{\aine}[1]{\gdef\gradu@aine{#1}}
\newcommand{\linja}[1]{\gdef\gradu@linja{(#1)}}
\newcommand{\tyyppi}[1]{\gdef\gradu@tyyppi{#1}}
\newcommand{\type}[1]{\gdef\gradu@type{#1}}
\newcommand{\keywords}[1]{\gdef\gradu@keywords{\begin{foreignlanguage}{english}#1\end{foreignlanguage}}}
\newcommand{\avainsanat}[1]{\gdef\gradu@avainsanat{\begin{foreignlanguage}{finnish}#1\end{foreignlanguage}}}
\newcommand{\contactinformation}[1]{\yhteystiedot{#1}}
%\newcommand{\yhteystiedot}[1]{\gdef\gradu@yhteystiedot{#1}}

\newcounter{gradu@yhteystiedotcount}
\def\gradu@yhteystiedot{}
\let\gradu@yhteystiedotstart\relax
\let\gradu@yhteystiedotend\relax

\newcommand{\yhteystiedot}[1]{%
  \@cons\gradu@yhteystiedot{\gradu@yhteystiedotstart#1\gradu@yhteystiedotend}
	\addtocounter{gradu@yhteystiedotcount}{1}
}
\newcounter{gradu@yhteystiedot@count}
\def\gradu@makeyhteystiedot{%
  \setcounter{gradu@yhteystiedot@count}{\value{gradu@yhteystiedotcount}}%
	\gdef\gradu@yhteystiedotend{%
		\addtocounter{gradu@yhteystiedot@count}{-1}%
	  \ifthenelse{\value{gradu@yhteystiedot@count} = 0}{}{,\space}%
	}%
	\gradu@yhteystiedot
}

\long\def\tiivistelma#1{\gdef\gradu@tiivistelma{\begin{foreignlanguage}{finnish}#1\end{foreignlanguage}}}
\long\def\abstract#1{\gdef\gradu@abstract{\begin{foreignlanguage}{english}#1\end{foreignlanguage}}}
\newcommand{\translatedtitle}[1]{\gdef\gradu@titletrans{#1}}
\newcommand{\acmccs}[1]{\gdef\gradu@acmccs{\textbf{ACM Categories and Subject Descriptors:} \begin{foreignlanguage}{english}#1\end{foreignlanguage}\par}}
\newcommand{\ysa}[1]{\gdef\gradu@ysa{\textbf{Asiasanat (YSA):} \begin{foreignlanguage}{finnish}#1\end{foreignlanguage}\par}}

\newcommand{\fulltitle}{\gradu@title: \gradu@tyo}


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

%\@ifundefined{\csname gradu@numpages \endcsname}
%  \def\gradu@numpages{\textbf{?}}
%\fi

\newcommand{\mainmatter}{
  \ifshortthesis
	\clearpage
	\fi
  \tableofcontents
  \gradu@lof
  \gradu@lot
  \setcounter{pages}{\value{page}}
  \clearpage
  \pagenumbering{arabic}
\ifshortthesis\else
  \setcounter{chapter}{0}
\fi
}
\renewcommand{\maketitle}{%
\begingroup
\newcounter{authorcount}
\iffi
    \def\gradu@tyo{\gradu@aine{} %
    \gradu@linja{}\if\gradu@linja\else\ \fi\gradu@tyyppi}%
\else
    \def\gradu@tyo{\gradu@type{} \gradu@aine{} \gradu@linja}%
\fi
\begin{titlepage}%
  \vspace*{7truecm plus 1truecm minus 3truecm}%
  \centerline{\textbf{%
      \setcounter{authorcount}{0}%
      \def\and{\\[0.2em]\addtocounter{authorcount}{1}}%
      \gradu@authors
    }}%
  \vspace{2truecm}%
  \centerline{\Large\textbf{\parbox[top][\height][c]{\textwidth}{\centering \gradu@title}}}%
  \vspace{4truecm}%
  \par{%
    \parindent9truecm\parskip0pt%
    \parbox{6.5cm}{\raggedright 
      \iffi%
      \gradu@aine\ \gradu@linja\par%
      \gradu@tyyppi%
      \else%
      \gradu@type\par%
      \gradu@aine\ \gradu@linja%
      \fi%
      \par%
      \gradu@date%
    }}%
  \vfill%
  \vspace{1truecm plus 1truecm minus .5truecm}%
  \iffi
  \center{\large\textbf{\gradu@yliopisto}}%
  \else
  \center{\large\textbf{\gradu@university}}%
  \fi
  \center{\textbf{\gradu@laitos}}%
  \center{\textbf{\gradu@paikka}}%
\end{titlepage}%
\newpage%
\begin{titlepage}%
  \noindent%
  \iffi%
  \textbf{Tekij\"a\ifthenelse{\value{authorcount}>1}{t}{}:} %
  \else%
  \noindent\textbf{Author\ifthenelse{\value{authorcount}>1}{s}{}:} %
  \fi%
  {%
    \newcounter{count}%
    \setcounter{count}{\value{authorcount}}%
    \def\and{\unskip%
      \addtocounter{count}{-1}%
      \ifthenelse{\value{count} = 0}{%
        \iffi\space ja \else, and \fi%
      }{%
        , %
      }%
    }%
    \def\\{\space}%
    \gradu@authors%
  }\par%
  \iffi%
  \noindent\textbf{Yhteystiedot:} \gradu@makeyhteystiedot\par%
  \noindent\textbf{Ty\"on nimi:} {\let\\\relax \gradu@title\par}%
  \noindent\textbf{Title in English:} \gradu@titletrans\par%
  \noindent\textbf{Ty\"o:} \gradu@tyo\par%
  \noindent\textbf{Sivum\"a\"ar\"a:} \ref{TotPages}\par%
  \noindent\textbf{Tiivistelm\"a:} \gradu@tiivistelma\par%
  \noindent\textbf{Abstract:} \gradu@abstract\par%
  \noindent\gradu@ysa%
  \noindent\textbf{Avainsanat:} \gradu@avainsanat\par%
  \noindent\gradu@acmccs%
  \noindent\textbf{Keywords:} \gradu@keywords\par%
  \else%
  \noindent\textbf{Contact information:} \gradu@makeyhteystiedot\par%
  \noindent\textbf{Title:} {\let\\\relax \gradu@title\par}%
  \noindent\textbf{Ty\"on nimi:} \gradu@titletrans\par%
  \noindent\textbf{Project:} \gradu@tyo\par%
  \noindent\textbf{Page count:} \ref{TotPages}\par%
  \noindent\textbf{Abstract:} \gradu@abstract\par%
  \noindent\textbf{Suomenkielinen tiivistelm\"a:} \gradu@tiivistelma\par%
  \noindent\gradu@acmccs%
  \noindent\textbf{Keywords:} \gradu@keywords\par%
  \noindent\gradu@ysa%
  \noindent\textbf{Avainsanat:} \gradu@avainsanat\par%
  \fi%
\end{titlepage}%
\endgroup
  \global\let\title\gradu@toolate%
  \global\let\author\gradu@toolate%
  \global\let\date\gradu@toolate%  
  \global\let\linja\gradu@toolate%  
  \global\let\tyyppi\gradu@toolate%  
  \global\let\keywords\gradu@toolate%  
  \global\let\linja\gradu@toolate%  
  \global\let\tyyppi\gradu@toolate%  
  \global\let\keywords\gradu@toolate%  
  \global\let\avainsanat\gradu@toolate%  
  \global\let\contactinformation\gradu@toolate%  
  \global\let\yhteystiedot\gradu@toolate%  
  \global\let\tiivistelma\gradu@toolate%  
  \global\let\abstract\gradu@toolate%  
  \global\let\translatedtitle\gradu@toolate%  
}

\ifshortthesis
\newcommand{\preface}{\section*{\prefacename}
\addcontentsline{toc}{section}{\prefacename}
}

\newcommand{\termlist}{\section*{\termlistname}
\addcontentsline{toc}{section}{\termlistname}
}
\else
\newcommand{\preface}{\chapter*{\prefacename}
\addcontentsline{toc}{chapter}{\prefacename}
}

\newcommand{\termlist}{\chapter*{\termlistname}
\addcontentsline{toc}{chapter}{\termlistname}
}
\fi

\renewcommand\appendix{\par
  \ifshortthesis
    \addtocontents{toc}{\protect\contentsline{section}{\appendicesname}{}{}}
	\else
    \addtocontents{toc}{\protect\contentsline{chapter}{\appendicesname}{}{}}
    \setcounter{chapter}{0}%
	\fi
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

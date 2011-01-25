\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{problemset}[2008/01/22 Class for mathematical problem sets]
\RequirePackage{fancyhdr,amsthm}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% default options
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\@stretchbreak}{\vfil \goodbreak}
\newcommand{\@nostretchbreak}{\vfil \goodbreak \vfilneg}
\newcommand{\@probstretch}{\@stretchbreak}
\newcommand{\@partstretch}{\@nostretchbreak}
\newlength{\commentlength}
\setlength{\commentlength}{0in} %no comment space by default
\newcommand{\titlefont}{\large\bfseries}
\newcommand{\reminderfont}{}
\newcommand{\sectionfont}{\bfseries}
\newcommand{\pagepos}{C}
\newcommand{\reminderpos}{OR,EL}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% option declarations, package loading
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\DeclareOption{stretchpart}{\renewcommand{\@partstretch}{\@stretchbreak}}
\DeclareOption{ignorepart}{\renewcommand{\@partstretch}{}}
\DeclareOption{nostretchproblem}{\renewcommand{\@probstretch}{\@nostretchbreak}}
\DeclareOption{ignoreproblem}{\renewcommand{\@probstretch}{}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions
\LoadClass[titlepage]{article}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% redefine maketitle to clear to a double page
%  (why doesn't article do this by default?)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\let\@oldmaketitle=\maketitle
\renewcommand{\maketitle}{{\pagestyle{empty}\@oldmaketitle\cleardoublepage\setcounter{page}{1}}}
\newcommand{\maketitleblank}{\maketitle} %compatability
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% General ``chapterlike'' setup
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newif\if@needchap
\pagestyle{fancy}
\fancyhead{}
\fancyfoot{}
\newcommand{\@chapheadtext}{}
\newcommand{\@chapremindertext}{}
\newcommand{\@chaphead}{{\titlefont \@chapheadtext}}
\newcommand{\@chapreminder}{{\reminderfont \@chapremindertext}}
\fancyhead[L]{\if@needchap \@chaphead \fi}
\fancyhead[R]{\global\@needchapfalse}
\fancyfoot[\pagepos]{\thepage}
\fancyfoot[\reminderpos]{\@chapreminder}
\newcommand{\genchaplike}[2]{\newpage\global\@needchaptrue%
\renewcommand{\@chapheadtext}{#1}%
\renewcommand{\@chapremindertext}{#2}}
\def\newchaplike#1#2#3{\newcommand{#1}[1]{\genchaplike{#2 ##1}{#3~##1}}}
\def\renewchaplike#1#2#3{\renewcommand{#1}[1]{\genchaplike{#2 ##1}{#3~##1}}}
\def\nonumchaplike#1#2#3{\newcommand{#1}{\genchaplike{#2}{#3}}}
\setbox0=\vbox{\hbox{\@chapheadtext{foo}}\hbox{\@chapheadtext{foo}}}
\setlength{\headheight}{\ht0}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{.5pt}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Specific chapterlikes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newchaplike{\chapter}{Chapter}{Ch.}
\renewchaplike{\section}{Section}{Sec.}
\nonumchaplike{\standalone}{Standalone Problems}{SA}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Multipart problems
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newif\if@interpart
\newcommand{\@ppartsec}{\@startsection{problempart}{2}{0in}{-1em}{-1ex}{\sectionfont}}
\newcommand{\newpartlike}[2]{%
\newenvironment{#1}[1]%
{\if@interpart \qed \@partstretch\fi\@ppartsec*{#2{##1}.}}%
{\global\@interparttrue}}
\newpartlike{problempart}{Part }
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problems, solutions, spacing
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\@comment}%
 {\par\nobreak\rule{0pt}{\commentlength}}
\newcommand{\@problemsec}{\@startsection{problem}{1}{0in}{-.01ex}{1ex}{\sectionfont}}
\newcommand{\@solnsec}{\@startsection{solution}{3}{0in}{-1em}{-1ex}{\sectionfont}}
\newcommand{\@genproblem}[1]{\@problemsec*{#1}}
\newcommand{\newproblem}[2]{\newenvironment{#1}[1]%
{\@problemsec*{#2##1}\global\@interpartfalse}{\qed \@comment \@probstretch}}
\newproblem{problem}{Problem }
\newcommand{\solution}{\@solnsec*{Solution.}}
\newcommand{\antiskip}{\vspace{-1em}}

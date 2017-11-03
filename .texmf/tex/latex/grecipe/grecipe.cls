\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{grecipe}

% Set document class
\LoadClass{article}

% Include packages
\RequirePackage[left=0.75in,right=0.75in]{geometry}
\RequirePackage{multicol}
\RequirePackage{titling}
\RequirePackage{enumitem}
\RequirePackage{setspace}
\RequirePackage{textcomp}
\newcommand{\textapprox}{\raisebox{0.5ex}{\texttildelow}}

% Margins
\topmargin=0.25in
\headsep=0.25in 

% Header and footer
\pagenumbering{gobble}
\setlength{\droptitle}{-1in}
\title{}
\author{}
\date{}
\posttitle{\par\end{center}}

% Set values
\setlength{\columnsep}{-12em}
\newcommand{\topitemsep}{0.5em}
\newcommand{\prepitemsep}{0.75em}
\newcommand{\ingitemsep}{1em}
\newcommand{\procitemsep}{1.5em}

% Change set commands
\renewcommand{\labelitemi}{\small$\bullet$}

% ******************************************************************************
% COMMANDS
% ******************************************************************************

% Fractional measurement
\newcommand{\ul}[1]{\underline{#1}}

% Title of recipe
\newcommand{\recipename}[1]{\title{{\Huge{\textbf{#1}}}}}

% Fractional measurement
\newcommand{\msr}[2]{$\frac{#1}{#2}$}

% Section title
\newcommand{\sectiontitle}[1]
{
  {\large\textbf{\underline{\smash{#1}}}}
}

% Preparation section
\newenvironment{preparation}
{
  \sectiontitle{Preparation}
  \vspace{\topitemsep}
  \begin{itemize}[itemsep=\prepitemsep]
}
{
  \end{itemize}
  \bigskip
  \bigskip
  \bigskip
}

% Ingredients section
\newenvironment{ingredients}[1][Ingredients]
{
  \sectiontitle{#1}
  \vspace{\topitemsep}
  \begin{itemize}[itemsep=\ingitemsep]
}
{
  \end{itemize}
  \vfill\null
  \columnbreak
}

% Procedure section
\newenvironment{procedure}
{
  \setstretch{1.4}
  \sectiontitle{Procedure}
  \vspace{-0.25em}
  \begin{enumerate}[itemsep=1.5em]
}
{
  \end{enumerate}
  \vfill\null
  \setstretch{1.0}
}

% ******************************************************************************
% Execute at beginning of document start
\AtBeginDocument{\maketitle}

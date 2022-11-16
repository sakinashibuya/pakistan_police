/*
This dofile is to be executed from Master_Pooledanalysis.do.
It creates a latex file with a weekly data check report.
*/


* Initialize the latex file
texdoc init "$output/ExploratoryNotes.tex", replace
	

* Load data
use "$modData/ExploratoryNotes.dta", clear


******************************************************************************** 
* 
******************************************************************************** 
	
	
/***

\documentclass[11pt]{article}


%%%%%%%%%%%%%%%%%%%%%
%%%%%% Packages %%%%%
%%%%%%%%%%%%%%%%%%%%%

\usepackage[utf8]{inputenc}
\usepackage{booktabs}
\usepackage{amsmath}
\usepackage{amsfonts}
\usepackage{amssymb}
\usepackage{float}
\usepackage{color}
%\usepackage{appendix}
\usepackage{booktabs}
%\usepackage{etex}
\usepackage{microtype}
\usepackage{geometry}
\geometry{
	a4paper,
	left=20mm,
	top=20mm,
	right=20mm,
	bottom=20mm
}

%\usepackage[pdfborder={0 0 0},pdfusetitle]{hyperref}
%\usepackage{doi}
\usepackage{tikz}
\usepackage{pgfplots}
%\usepackage{imakeidx}
\usepackage{hyperref}
\usepackage{multirow}
\usepackage{setspace}
\usepackage{comment}
%\usepackage[labelformat=parens,labelsep=quad,skip=3pt]{caption}
\usepackage{graphicx}
\usepackage{caption}
\usepackage{subcaption}
\usepackage{stata}

\usepackage{tabularx}

\usepackage{enumitem}

\usepackage{adjustbox}

%%%%%%%%%%%%%%%%%%%%%
%%%%%% Document %%%%%
%%%%%%%%%%%%%%%%%%%%% 


\title{Pakistan Police Project: \\ Data Exploration Notes}
\date{\today}

\begin{document}
	
\maketitle

This document provides notes on our exploration of the Complaints and First Impression Reports data.

%\begin{table}[H]
%\adjustbox{max width=\textwidth}{
%\input{Effects_Updating_Other_exp_donate_pmcf}
%}
%\end{table}

						    
%\begin{figure}[H]
%\centering
%\caption{Estimated Effects: All Treatment Categories}
%\begin{subfigure}[b]{0.49\textwidth}
%	\includegraphics[width=\textwidth]{Effects_AllTreatCats_exp_donate_pmcf}
%	\label{fig:checkattenbeforeaug22}
%\end{subfigure}
%
%\begin{subfigure}[b]{0.49\textwidth}
%	\includegraphics[width=\textwidth]{Effects_AllTreatCats_exp_vote_bjp_if}
%	\label{fig:checkattenafteraug22}
%\end{subfigure}
%\medskip
%\begin{subfigure}[b]{0.49\textwidth}
%	\includegraphics[width=\textwidth]{Effects_AllTreatCats_exp_vote_bjp_lkl_more}
%	\label{fig:checkattenbeforeaug22}
\5end{subfigure}
%
%\begin{subfigure}[b]{0.49\textwidth}
%	\includegraphics[width=\textwidth]{Effects_AllTreatCats_exp_vote_nda_if}
%	\label{fig:checkattenafteraug22}
%\end{subfigure}
%
%\end{figure}

\end{document}

***/
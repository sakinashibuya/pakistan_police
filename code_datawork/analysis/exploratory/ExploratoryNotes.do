/*
This dofile is to be executed from Master_Pooledanalysis.do.
It creates a latex file with a weekly data check report.
*/


* Initialize the latex file
texdoc init "$output/ExploratoryNotes.tex", replace


* Load data
use "$modData/merged_fir_complaints_lahore.dta", clear
tempfile mergedData
save `mergedData'

use "$modData/FIR/clean_fir_allyears.dta", clear
tempfile fir
save `fir'

use "$modData/Complaints/clean_complaints_lahore.dta", clear
tempfile complaints
save `complaints'
	
		
******************************************************************************** 
* Data Overview
******************************************************************************** 

texdoc stlog, nolog

	use `fir', clear
	qui: unique firid
	texdoc local firUniN = r(unique)

	use `complaints', clear
	qui: unique compid
	texdoc local cmpUniN = r(unique)

	
	use `mergedData', clear
	qui table source, statistic(freq) statistic(percent)
	collect title "Match between the FIR and Complaint Data"
	collect export "$output/freq_dataSource.tex", replace tableonly
	
texdoc stlog close
		

	
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

\section{Dataset Overview}

The numbers of unique observations for each of the FIR and Complaint datasets are the following: \\
\noindent Unique Complaints cases $\rightarrow$  `cmpUniN' \\
\noindent Unique FIR cases $\rightarrow$ `firUniN'

The merged FIR + Complaint dataset looks like this. The ``In both" category shows the unique matched observations between the two datasets.
\input{freq_dataSource}

***/	

******************************************************************************** 
* Time from Complaint to FIR
******************************************************************************** 

use `mergedData', clear
keep if source == 3

texdoc stlog, nolog	
	
	gen responsetime_hr = responsetime/(60*60)
	label var responsetime_hr "Complaint-1st Contact Time (hours)"
	
	estpost tabstat responsetime_hr time_comp2fir, stat(count min max med mean) col(stat)
	esttab using "$output/sum_time.tex", replace label nonumber title("Response Speed") ///
		cells("count min max p50 mean") float
	
	estpost tabstat responsetime_hr time_comp2fir if responsetime_hr > 0 & time_comp2fir > 0, stat(count min max med mean) col(stat)
	esttab using "$output/sum_time_noNeg.tex", replace label nonumber title("Response Speed") ///
		cells("count min max p50 mean") float
	
	
	histogram responsetime_hr if responsetime_hr < 100, freq
	graph export "$output/Hist_responsetime.png", replace
	
	histogram time_comp2fir if time_comp2fir > 0 & time_comp2fir < 100, freq
	graph export "$output/Hist_timeComp2Fir.png", replace
	
	
texdoc stlog close

/***

\section{Response Speed}

These are summary statistics on police response seped. 

Once thing to note is that there are quit a bit of negative values. 

	\input{sum_time}
	
Without negative values, the summary statistics look like this.

	\input{sum_time_noNeg}
	

Here are the distributions. I cut off some outliers so that we can see some patterns. 

A question: Why do we see some waves? 

	\begin{figure}[H]
		\centering
		\caption{Estimated Effects: All Treatment Categories}
		\begin{subfigure}[b]{0.49\textwidth}
			\includegraphics[width=\textwidth]{Hist_responsetime}
			\label{fig:Hist_responsetime}
		\end{subfigure}
		%
		\begin{subfigure}[b]{0.49\textwidth}
			\includegraphics[width=\textwidth]{Hist_timeComp2Fir}
			\label{fig:Hist_timeComp2Fir}
		\end{subfigure}
	\end{figure}
	
***/


/*** 
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
%\end{subfigure}
%
%\begin{subfigure}[b]{0.49\textwidth}
%	\includegraphics[width=\textwidth]{Effects_AllTreatCats_exp_vote_nda_if}
%	\label{fig:checkattenafteraug22}
%\end{subfigure}
%
%\end{figure}

\end{document}

***/
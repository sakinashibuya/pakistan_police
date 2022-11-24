/*******************************************************************************
							India Voting Project

Purpose: This do file produces tables and graphs for a weekly data check report 
		 for the Uttar Pradesh pilot of the online survey experiment. 
		 The report is found below. 

		 
*******************************************************************************/

	***** Housekeeping

	clear all
	set more off
	set graphics off
	
	*** Directories
	if c(username) == "sakina" {
		global dropbox "C:\Users\sakina\Dropbox\Projects\Pakistan_police"
		global git 	   "C:\Users\sakina\Documents\Git\pakistan_police"
	}

	if c(username) == "UserName" {
		global dropbox "LocalDropboxPath"	
		global git 	   "LocalGitFolderPath"
	}

	global rawData "$dropbox/Data/rawData"
	global modData "$dropbox/Data/modifiedData"
	global doFiles "$git/code_datawork/analysis/exploratory"
	global output  "$git/output\analysis_notes\exploratory"
	
	
	*** User-written commands
	local download = 0 // Switch to 1 to downlaod
	if `download' {
		ssc install texdoc, replace
		ssc install texsave, replace
		ssc install ietoolkit, replace
		ssc install fs, replace
		net install binsreg, from(https://raw.githubusercontent.com/nppackages/binsreg/master/stata) replace
		}
	
	texdoc do "$doFiles/ExploratoryNotes.do"

	
	
	
/*******************************************************************************
Project: Pakistan Punjab Police Project

Purpose: Clean the FIR data
output: clean_fir_allyears.dta
********************************************************************************/
	

	***************
	* Housekeeping 
	***************
	
	clear all
	set more off

	* Directories
	if c(username) == "sakina" {
		global dropbox "C:\Users\sakina\Dropbox\Projects\Pakistan_police"
		global git	   "C:\Users\sakina\Documents\Git\pakistan_police"
	}

	if c(username) == "YourUserName" {
		global dropbox "YourPathToYourDropboxFolder"
		global git	   "YourPathToYourGitHubFolder"
	}

	global rawData 		"$dropbox/Data/rawData"
	global modData 		"$dropbox/Data/modifiedData"
	global dofiles		"$git/code_datawork"
	
	
	****************
	* Data cleaning
	****************

	***** Read all raw data
	local filelist: dir "$rawData/FIR/" files `"*.xlsx"', respectcase
	di `filelist'
	foreach file of local filelist {
		
		di "`file'"
		import excel "$rawData/FIR/`file'", firstrow clear
		local fname = subinstr("`file'", ".xlsx", "", .)
		local fname2 = subinstr("`fname'", "-", "_", .)
		tempfile `fname2'
		save ``fname2''
	}
	
	use `FIRList2016', clear
	append using `FIRList2017'
	append using `FIRList2018'
	append using `FIRList2019_1'
	append using `FIRList2019_2'
	append using `FIRList2020_1'
	append using `FIRList2020_2'
	
	***** Check for and clean duplicates 
	
	* Remove completely identifcal cases
	local allvars "fir_no fir_year fir_datetime datetime_of_event other_not_event_datetime dist_name_eng ps_name_eng crime_name_eng secName pe_name"
	duplicates report `allvars'
	duplicates drop `allvars', force 
	qui: duplicates report `allvars'
	assert r(unique_value) == r(N) // Sanity check
	
	* Each case should be identified with the following ID variables
	local idvars "fir_no fir_year dist_name_eng ps_name_eng"
	duplicates report `idvars'
	duplicates drop `idvars', force
	qui: duplicates report `idvars'
	assert r(unique_value) == r(N) // Sanity check
	
	
	***** Make an unique FIR ID
	gen firid = _n
	label var firid "FIR ID (unique)"
	
	label var fir_no "FIR number"
	label var fir_year "Year (FIR created)"
	label var fir_datetime "Date + Time (FIR created)"
	label var datetime_of_event "Date + Time (Event)"
	label var other_not_event_datetime "Notes about event time"
	label var dist_name_eng "District" // Is tis the district of FIR or event?
	label var ps_name_eng "Station name"
	label var crime_name_eng "Crime name"
	label var secName "Relevant law"
	label var pe_name "Officer name and ranks"
	
	order firid
	
	save "$modData/FIR/clean_fir_allyears.dta", replace 
	

/*******************************************************************************
Project: Pakistan Punjab Police Project

Purpose: Merge the FIR and complaint data
Output: merged_fir_complaints_lahore.dta
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



	use "$modData/FIR/clean_fir_allyears.dta", clear


	***** Merge the FIR & Complaint data
	merge 1:1 fir_no fir_year dist_name_eng ps_name_eng ///
		using "$modData/Complaints/clean_complaints_lahore.dta", ///
		gen(source)
		
	/* Notes:
	duplicates report firid 
	All duplicates come from source == 2 (using data with no match in FIR data)
	*/
	label def source 1 "FIR" 2 "Complaints (Lahore)" 3 "In both"
	label val source source
	label var source "Data source"
	
	tab source
	
		
	**** Make variables
	gen time_comp2fir = clockdiff_frac(comp_datetime, fir_datetime, "hour")
	label var time_comp2fir "Complaint-FIR convertion time (hours)"
	
	save "$modData/merged_fir_complaints_lahore.dta", replace 

	
	
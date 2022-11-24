/*******************************************************************************
Project: Pakistan Punjab Police Project

Purpose: Make a dataset with the front desk reform assignment timing
Output: treatment_frontdesk 
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
	

	
	* Get a list of unique police stations
	use "$modData/merged_fir_complaints_lahore.dta", clear
	keep if dist_name_eng == "Lahore"
	gen one = 1
	collapse one, by(ps_name_eng)
	drop one 
	
	* Inpur reform start dates
	gen trt_year = .
	replace trt_year = 2015 if ps_name_eng == "Defence Area (A)" | ps_name_eng == "Defence Area (B)" | ///
							   ps_name_eng == "Defence Area (C)" | ps_name_eng == "Sarwar Road"		 | ///
							   ps_name_eng == "North Cantt" 	 | ps_name_eng == "South Cantt"		 | ///
							   ps_name_eng == "Mustafa Abad"	 | ps_name_eng == "Baghbanpura"		 | ///
							   ps_name_eng == "Model Town"		 | ps_name_eng == "Gulberg"
							   
							   
							   
	replace trt_year = 2016 if ps_name_eng != "Defence Area (A)" & ps_name_eng != "Defence Area (B)" & /// 
							   ps_name_eng != "Defence Area (C)" & ps_name_eng != "Sarwar Road"		 & ///
							   ps_name_eng != "North Cantt" 	 & ps_name_eng != "South Cantt"		 & ///
							   ps_name_eng != "Mustafa Abad"	 & ps_name_eng != "Baghbanpura"		 & ///
							   ps_name_eng != "Model Town"		 & ps_name_eng != "Gulberg"   
	label var trt_year "Front Desk Policy Start Year"
	
	gen trt_month = .
	replace trt_month = 3 if ps_name_eng == "Defence Area (A)" | ps_name_eng == "Defence Area (B)"   | ///
							 ps_name_eng == "Defence Area (C)" | ps_name_eng == "Sarwar Road"		 | ///
							 ps_name_eng == "North Cantt" 	   | ps_name_eng == "South Cantt"		 | ///
							 ps_name_eng == "Mustafa Abad"	   | ps_name_eng == "Baghbanpura"		 | ///
							 ps_name_eng == "Model Town"	   | ps_name_eng == "Gulberg" 
	
	replace trt_month = 5 if ps_name_eng != "Defence Area (A)" & ps_name_eng != "Defence Area (B)"   & /// 
							 ps_name_eng != "Defence Area (C)" & ps_name_eng != "Sarwar Road"		 & ///
							 ps_name_eng != "North Cantt" 	   & ps_name_eng != "South Cantt"		 & ///
							 ps_name_eng != "Mustafa Abad"	   & ps_name_eng != "Baghbanpura"		 & ///
							 ps_name_eng != "Model Town"	   & ps_name_eng != "Gulberg"   
	label var trt_month "Front Desk Policy Start Month"

	
	tab trt_year trt_month
		
	gen trt_date = ym(trt_year,trt_month)
	format trt_date %tm
	label var trt_date "Front Desk Policy Start Date"
	
	
	save "$rawData/Frontdesk Timeline/treatment_frontdesk.dta", replace
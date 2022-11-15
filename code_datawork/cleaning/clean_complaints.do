/*******************************************************************************
Project: Pakistan Punjab Police Project

Purpose: Clean the complaints data
Output: clean_complaints_lahore
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
	
	
	import excel using ///
		"$rawData/Complaints/FIRS_Police Report Complaints From 2017-01-01 to 2019-05-01_01-05-2019.xlsx", ///
		cellrange(A2:R162368) firstrow
		

	***** Make ID variables common with the FIR data
	gen fir_no = substr(FIRNo, 1, strpos(FIRNo, "/")-1)
	label var fir_no "FIR number"
	
	gen fir_year = substr(FIRNo, strpos(FIRNo, "/")+1, 2)
	label var fir_year "Year (FIR created)"
	
	destring fir_no fir_year, replace
	
	rename PoliceStation ps_name_eng
	label var ps_name_eng "Station name"
	
	gen dist_name_eng = "Lahore"
	label var dist_name_eng "District"
	
	
	***** Identify and drop duplicates
	duplicates report fir_no fir_year ps_name_eng ComplaintRecord
	duplicates drop fir_no fir_year ps_name_eng ComplaintRecord, force // Drop identical cases
	
	
	***** Clean variables
	
	gen comp_datetime = clock(CreatedDate, "MDYhms")
	format comp_datetime %tc
	label var comp_datetime "Date + Time (Complaint created)"
	
	gen comp_mod_datetime = clock(StatusModifiedDate, "MDYhms")
	format comp_mod_datetime %tc
	label var comp_mod_datetime "Date + Time (Complaint status modified)"
	
	gen fup_datetime = clock(LastFollowupDateTime, "MDYhms")
	format fup_datetime %tc
	label var fup_datetime "Date + Time (Last follow-up)"
	
	destring responsetime TotalFollowupCount, replace
	label var responsetime "Response time (from the complaint data)"
	
	gen responsetime2 = (comp_mod_datetime - comp_datetime)/60
	
	
	
	***** Drop the test cases
	drop if ps_name_eng == "Test PS"
	drop if PersonName == "test"
	
	
	drop FIRNo PersonName PersonContact OfficerName OfficerMobileNo ///
		 CreatedDate StatusModifiedDate LastFollowupDateTime
		
	order fir_no fir_year dist_name_eng ps_name_eng ///
		  comp_datetime comp_mod_datetime responsetime IsFIRRegistered ///
		  Category Offense ComplaintStatus PendingAtLevel ///
		  TotalFollowupCount fup_datetime LastFollowupRemarks
	
	save "$modData/FIR/clean_complaints_lahore.dta", replace 
	
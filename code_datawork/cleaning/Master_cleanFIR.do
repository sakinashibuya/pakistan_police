/*******************************************************************************
Project: Pakistan Costs of Hiring Women

Purpose: Conduct basic data cleaning on the baseline survey data
********************************************************************************/
	

	***************
	* Housekeeping 
	***************
	
	clear all
	set more off

	* Directories
	if c(username) == "sakina" {
		global dropbox "C:\Users\sakina\Dropbox\Projects\Pakistan_HiringCostsWomen"
		global git	   "C:\Users\sakina\Documents\Git\pakistan_flfp"
	}

	if c(username) == "YourUserName" {
		global dropbox "YourPathToYourDropboxFolder"
		global git	   "YourPathToYourGitHubFolder"
	}

	global rawData 		"$dropbox/Data/PrimaryData/rawData"
	global modData 		"$dropbox/Data/PrimaryData/modifiedData"
	global dofiles		"$git/code_datawork"	
	

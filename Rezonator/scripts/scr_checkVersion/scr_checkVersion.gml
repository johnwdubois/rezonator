function scr_checkVersion(currentVer, newVer){
	
	// compare versions, return TRUE if currentVer has its first 3 digits up to date
	// return false otherwise
	if (!is_string(currentVer) || !is_string(newVer)) return false;
	
	var upToDate = false;
	
	// split version strings
	var currentVerSplit = scr_splitString(currentVer, ".");
	var newVerSplit = scr_splitString(newVer, ".");
	show_debug_message("scr_checkVersion, currentVerSplit: " + scr_getStringOfList(currentVerSplit));
	show_debug_message("scr_checkVersion, newVerSplit: " + scr_getStringOfList(newVerSplit));
	
	if (ds_list_size(currentVerSplit) >= 3 && ds_list_size(newVerSplit) >= 3) {
		try {
			// check first 3 digits
			if (real(currentVerSplit[| 0]) >= real(newVerSplit[| 0])
			&& real(currentVerSplit[| 1]) >= real(newVerSplit[| 1])
			&& real(currentVerSplit[| 2]) >= real(newVerSplit[| 2])) upToDate = true;
		}
		catch(e) {
			show_debug_message("scr_checkVersion Error: " + string(e.message));
		}
	}
	
	// dont need anymore
	ds_list_destroy(currentVerSplit);
	ds_list_destroy(newVerSplit);
	
	show_debug_message("scr_checkVersion, upToDate: " + string(upToDate));
	return upToDate;

}
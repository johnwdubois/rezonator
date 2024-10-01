function scr_URLOpenReliable(url) {
	
	// GameMaker's url_open function is a bit unreliable for Windows,
	// so we use execute shell to launch the browser
	if (BUILDTYPE == "Web") {
		url_open(url);
	} else {
		var escapedfolder = string_replace_all(url, "\"", "\\\"");
		if (os_type = os_windows) execute_shell("cmd", "explorer \"" + escapedfolder + "\"");
		else if (os_type = os_macosx) execute_shell("open", "\"" + escapedfolder + "\"");
		else if (os_type = os_linux) execute_shell("xdg-open", "\"" + escapedfolder + "\"");
	}
}
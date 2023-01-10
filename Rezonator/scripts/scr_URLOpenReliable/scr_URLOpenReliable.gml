function scr_URLOpenReliable(url){
	
	// GameMaker's url_open function is a bit unreliable for Windows,
	// so we use execute shell to launch the browser
	if (os_type == os_windows) {
		
		var _url = url;
		var _path = game_save_id + "/shortcut.url";
		var _txt = file_text_open_write(_path);
		// note: use '' instead of @'' in GMS1
		file_text_write_string(_txt, @'[{000214A0-0000-0000-C000-000000000046}]
		Prop3=19,11
		[InternetShortcut]
		IDList=
		URL=' + _url);
		file_text_close(_txt);
		execute_shell_simple(_path);
		
	}
	else {
		url_open(url);
	}

}
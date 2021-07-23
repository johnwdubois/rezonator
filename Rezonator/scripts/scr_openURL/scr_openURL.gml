// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_openURL(url){
	
	//if (os_type == os_macosx) {
		url_open(url);
		/*
	}
	else {
		var path = game_save_id + "/shortcut.url";
		var file = file_text_open_write(path);
		file_text_write_string(file, @'[{000214A0-0000-0000-C000-000000000046}]
		Prop3=19,11
		[InternetShortcut]
		IDList=
		URL=' + url);
		file_text_close(file);
		execute_shell_simple(path);
	}
	*/

}
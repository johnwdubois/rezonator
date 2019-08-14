if (directory_exists(global.rezonatorDirString)) {
	var filename = global.rezonatorDirString + "\\~usersettings.ini";
	userSettingsIniFile = file_text_open_write(filename);
	
	var fileStr = "";
	fileStr += "rememberMe:" + string(global.rememberMe) + "#";
	fileStr += "userName:" + string(global.userName) + "#";
	fileStr += "lineHeight:" + string(obj_control.gridSpaceVertical) + "#";
	fileStr += "fontSize:" + string(global.fontSize) + "#";
	fileStr += "end" + "#";
	
	file_text_write_string(userSettingsIniFile, string_hash_to_newline(fileStr));
	file_text_close(userSettingsIniFile);
}

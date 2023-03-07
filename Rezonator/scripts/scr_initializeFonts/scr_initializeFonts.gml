function scr_initializeFonts() {
	
	// find font file
	var delimiter = (os_type == os_macosx) ? "/" : "\\";
	var font_file_name = file_find_first( working_directory + "IncludedFiles" + delimiter + "Fonts" + delimiter + "*.ttf", 0);		// find the ttf file
	var font_file_name_full = "IncludedFiles" + delimiter + "Fonts" + delimiter + font_file_name;
		
	show_debug_message("font_file_name: " + string(font_file_name));
	
	global.fontSizeMax = 12;
	global.fontMap = ds_map_create();
	
	for (var i = 0; i < global.fontSizeMax + 1; i++) {
		
		var _sizeS = 10 + (i * 2);
		var _sizeM = _sizeS + 2;
		var _sizeL = _sizeM + 2;
		
		var _fontS = font_add(font_file_name_full, _sizeS, false, false, 32, 127);
		var _fontM = font_add(font_file_name_full, _sizeM, false, false, 32, 127);
		var _fontL = font_add(font_file_name_full, _sizeL, false, false, 32, 127);
		
		global.fontMap[? "nonCJK_S_" + string(i)] = _fontS;
		global.fontMap[? "nonCJK_M_" + string(i)] = _fontM;
		global.fontMap[? "nonCJK_L_" + string(i)] = _fontL;
		global.fontMap[? "CJK_S_" + string(i)] = 0;
		global.fontMap[? "CJK_M_" + string(i)] = 0;
		global.fontMap[? "CJK_L_" + string(i)] = 0;
	}

	// special sizes
	global.localeEN_Title = font_add(font_file_name_full, 30, false, false, 32, 127);		
	global.localeCJK_Title = 0;

}
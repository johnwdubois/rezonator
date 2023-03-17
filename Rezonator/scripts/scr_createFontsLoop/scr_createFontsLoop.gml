function scr_createCJKFontsLoop() {
	
	// find font file
	var delimiter = (os_type == os_macosx) ? "/" : "\\";
	var CKJFont_file_name = file_find_first( working_directory + "IncludedFiles" + delimiter + "Fonts" + delimiter + "*.otf", 0); // find the ttf file
	var CKJFont_file_name_full = "IncludedFiles" + delimiter + "Fonts" + delimiter + CKJFont_file_name;
	
	// continue creating CJK fonts if build is true
	if (global.build) {
		
		if (CJKLoopIteration <= global.fontSizeMax) {
			scr_createCJKFonts(CKJFont_file_name_full, CJKLoopIteration);
			CJKLoopIteration++;
			alarm[4] = 8;
		}
		else {
			scr_createCJKFonts(CKJFont_file_name_full, 6);
			global.fontsLoaded = true;
			with (obj_openingScreen) runFontSizeTest = true;
		}
		
	}
	else {
		global.fontsLoaded = true;
	}

}
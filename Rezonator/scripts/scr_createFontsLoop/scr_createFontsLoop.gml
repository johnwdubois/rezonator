

function scr_createFontsLoop(){
	

	
	// find font file
	var delimiter = (os_type == os_macosx) ? "/" : "\\";
	var CKJFont_file_name = file_find_first( working_directory + "IncludedFiles" + delimiter + "Fonts" + delimiter + "*.otf", 0 );		// find the ttf file
	var CKJFont_file_name_full = "IncludedFiles" + delimiter + "Fonts" + delimiter + CKJFont_file_name;
	
	// continue creating CJK fonts if build is true
	if (global.build) {
		if (CJKLoopIteration <= 5) {
			scr_createFonts(CKJFont_file_name_full, CJKLoopIteration);

			smallFontSize +=2;
			mediumFontSize +=2;
			largeFontSize +=2;
			CJKLoopIteration++;
	
			alarm[4] = 2;
		}
		else {
			scr_createFonts(CKJFont_file_name_full, 6);
			global.fontsLoaded = true;
		}
	}
	else {
		global.fontsLoaded = true;
	}

}
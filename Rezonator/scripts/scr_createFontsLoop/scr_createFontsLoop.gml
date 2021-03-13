// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_createFontsLoop(){
	
	// CHANGE THIS VAR WHEN MAKING A BUILD
	// if build is true --> CJK fonts will be loaded
	// if build is false --> CJK fonts will not be loaded
	var build = false;
	
	// find font file
	var delimiter = (os_type == os_macosx) ? "/" : "\\";
	var CKJFont_file_name = file_find_first( working_directory + "IncludedFiles" + delimiter + "Fonts" + delimiter + "*.otf", 0 );		// find the ttf file
	var CKJFont_file_name_full = "IncludedFiles" + delimiter + "Fonts" + delimiter + CKJFont_file_name;
	
	// continue creating CJK fonts if build is true
	if (build) {
		if(CJKLoopIteration <= 5 ){
			scr_createFonts(CKJFont_file_name_full, CJKLoopIteration);

			smallFontSize +=2;
			mediumFontSize +=2;
			largeFontSize +=2;
			CJKLoopIteration ++;
	
			alarm[4] = 2;
		}
		else {
			global.fontsLoaded = true;
		}
	}
	else {
		global.fontsLoaded = true;
	}

}
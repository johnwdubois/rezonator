/// @description create fonts asychronously
// You can write your code in this editor



var delimiter = (os_type == os_macosx) ? "/" : "\\";
//var ENFont_file_name = file_find_first( "IncludedFiles" + delimiter + "Fonts" + delimiter + "*.ttf", 0 );		// find the ttf file
var CKJFont_file_name = file_find_first( working_directory + "IncludedFiles" + delimiter + "Fonts" + delimiter + "*.otf", 0 );		// find the ttf file
var CKJFont_file_name_full = "IncludedFiles" + delimiter + "Fonts" + delimiter + CKJFont_file_name;

var build = true;
if(build){
	if(CJKLoopIteration <= 5 ){
		scr_createFonts(CKJFont_file_name_full, CJKLoopIteration);

		smallFontSize +=2;
		mediumFontSize +=2;
		largeFontSize +=2;
		CJKLoopIteration ++;
	
		alarm[4] = 2;
	}
	else
	{
		global.fontsLoaded = true;
	}
}
else {
	global.fontsLoaded = true;
}
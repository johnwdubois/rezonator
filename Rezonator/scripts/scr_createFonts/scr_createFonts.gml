// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_createFonts(){


	if	(os_type == os_macosx)	{	
		global.localeJA = font_add(global.rezonatorFontDirString +"/NotoSansCJKjp-Regular.otf",12,false,false,32,127);

		global.localeSC = font_add(global.rezonatorFontDirString + "/NotoSansCJKsc-Regular.otf",12,false,false,32,127);

		global.localeHE = fnt_localeHE;//font_add(global.rezonatorFontDirString + "/NotoSansHebrew-Regular.otf",12,false,false,32,127);

	}
	else{
		
		global.localeJA = font_add(global.rezonatorFontDirString +"\\NotoSansCJKjp-Regular.otf",12,false,false,32,127);

		global.localeSC = font_add(global.rezonatorFontDirString + "\\NotoSansCJKsc-Regular.otf",12,false,false,32,127);

		global.localeHE = fnt_localeHE;//font_add(global.rezonatorFontDirString + "\\NotoSansHebrew-Regular.otf",12,false,false,32,127);
	}
}
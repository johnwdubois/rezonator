function scr_createCJKFonts(filePath, size) {
	
	var _sizeS = 10 + (size * 2);
	var _sizeM = _sizeS + 2;
	var _sizeL = _sizeM + 2;
	
	var _font = font_add(filePath, _sizeM, false, false, 32, 127);
	global.fontMap[? "CJK_S_" + string(size)] = _font;
	global.fontMap[? "CJK_M_" + string(size)] = _font;
	global.fontMap[? "CJK_L_" + string(size)] = _font;
	
	if (size == 0) {		
		// Title font 	
		global.localeCJK_Title = font_add(filePath, 30, false, false, 32, 127);
		show_debug_message("global.localeCJK_Title loaded");
	}	
}
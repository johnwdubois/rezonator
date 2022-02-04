

function scr_createFonts(filePath, i){



	// main fonts
	if(i == 0 ){
		global.localeCJK_S_0 = font_add(filePath,smallFontSize,false,false,32,127);
		global.localeCJK_M_0 = font_add(filePath,mediumFontSize,false,false,32,127);
		global.localeCJK_L_0 = font_add(filePath,largeFontSize,false,false,32,127);
		show_debug_message("Loop 0 CLEAR");
	}
	else if( i == 1){
	//size_1	
		global.localeCJK_S_1 = font_add(filePath,smallFontSize,false,false,32,127);
		global.localeCJK_M_1 = font_add(filePath,mediumFontSize,false,false,32,127);
		global.localeCJK_L_1 = font_add(filePath,largeFontSize,false,false,32,127);
		show_debug_message("Loop 1 CLEAR");
	}
	else if( i == 2){		
	//size_2	
		global.localeCJK_S_2 = font_add(filePath,smallFontSize,false,false,32,127);
		global.localeCJK_M_2 = font_add(filePath,mediumFontSize,false,false,32,127);
		global.localeCJK_L_2 = font_add(filePath,largeFontSize,false,false,32,127);
		show_debug_message("Loop 2 CLEAR");
	}
	else if( i == 3){		
	//size_3	
		global.localeCJK_S_3 = font_add(filePath,smallFontSize,false,false,32,127);
		global.localeCJK_M_3 = font_add(filePath,mediumFontSize,false,false,32,127);
		global.localeCJK_L_3 = font_add(filePath,largeFontSize,false,false,32,127);
		show_debug_message("Loop 3 CLEAR");
	}
	else if( i == 4){		
	//size_4	
		global.localeCJK_S_4 = font_add(filePath,smallFontSize,false,false,32,127);
		global.localeCJK_M_4 = font_add(filePath,mediumFontSize,false,false,32,127);
		global.localeCJK_L_4 = font_add(filePath,largeFontSize,false,false,32,127);
		show_debug_message("Loop 4 CLEAR");
	}
	else if( i == 5){		
	//size_5	
		global.localeCJK_S_5 = font_add(filePath,smallFontSize,false,false,32,127);
		global.localeCJK_M_5 = font_add(filePath,mediumFontSize,false,false,32,127);
		global.localeCJK_L_5 = font_add(filePath,largeFontSize,false,false,32,127);
		show_debug_message("Loop 5 CLEAR");
	}	
	
	else if( i == 6){		
	//Title font 	
		global.localeCJK_Title = font_add(filePath,30,false,false,32,127);
		show_debug_message("Loop 5 CLEAR");
	}	
	
	
}
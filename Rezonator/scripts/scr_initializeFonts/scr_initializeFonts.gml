// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_initializeFonts(){
		// find font file
		var delimiter = (os_type == os_macosx) ? "/" : "\\";
		var font_file_name = file_find_first( working_directory + "IncludedFiles" + delimiter + "Fonts" + delimiter + "*.ttf", 0 );		// find the ttf file
		var font_file_name_full = "IncludedFiles" + delimiter + "Fonts" + delimiter + CKJFont_file_name;
	

		global.localeEN_S_0 = font_add(font_file_name_full,10,false,false,32,127);
		global.localeEN_M_0 = font_add(font_file_name_full,12,false,false,32,127);
		global.localeEN_L_0 = font_add(font_file_name_full,14,false,false,32,127);
		
			

	//size_1
		global.localeEN_S_1 = font_add(font_file_name_full,12,false,false,32,127);		
		global.localeEN_M_1 = font_add(font_file_name_full,14,false,false,32,127);		
		global.localeEN_L_1 = font_add(font_file_name_full,16,false,false,32,127);		


		
	//size_2
		global.localeEN_S_2 = font_add(font_file_name_full,14,false,false,32,127);		
		global.localeEN_M_2 = font_add(font_file_name_full,16,false,false,32,127);		
		global.localeEN_L_2 = font_add(font_file_name_full,18,false,false,32,127);		

		
	//size_3
		global.localeEN_S_3 = font_add(font_file_name_full,16,false,false,32,127);		
		global.localeEN_M_3 = font_add(font_file_name_full,18,false,false,32,127);		
		global.localeEN_L_3 = font_add(font_file_name_full,20,false,false,32,127);		

		
	//size_4
		global.localeEN_S_4 = font_add(font_file_name_full,18,false,false,32,127);		
		global.localeEN_M_4 = font_add(font_file_name_full,20,false,false,32,127);		
		global.localeEN_L_4 = font_add(font_file_name_full,22,false,false,32,127);		

		
	//size_5
		global.localeEN_S_5 = font_add(font_file_name_full,20,false,false,32,127);		
		global.localeEN_M_5 = font_add(font_file_name_full,22,false,false,32,127);		
		global.localeEN_L_5 = font_add(font_file_name_full,24,false,false,32,127);		

		
		//size_0
		global.localeCJK_S_0 = 0;
		global.localeCJK_M_0 = 0;
		global.localeCJK_L_0 = 0;
		
		//size_1
		
		global.localeCJK_S_1 = 0;
		global.localeCJK_M_1 = 0;
		global.localeCJK_L_1 = 0;
		
		//size_2
		
		global.localeCJK_S_2 = 0;
		global.localeCJK_M_2 = 0;
		global.localeCJK_L_2 = 0;
		
		//size_3
		
		global.localeCJK_S_3 = 0;
		global.localeCJK_M_3 = 0;
		global.localeCJK_L_3 = 0;
		
		//size_4
		
		global.localeCJK_S_4 = 0;
		global.localeCJK_M_4 = 0;
		global.localeCJK_L_4 = 0;
		
		//size_5		
		global.localeCJK_S_5 = 0;		
		global.localeCJK_M_5 = 0;
		global.localeCJK_L_5 = 0;

}
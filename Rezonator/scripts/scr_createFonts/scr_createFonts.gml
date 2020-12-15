// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_createFonts(){


	if	(os_type == os_macosx)	{	
		// main fonts
		
		global.localeEN_S_0 = font_add(global.rezonatorFontDirString +"/KlokanTechNotoSans-Regular.ttf",10,false,false,32,127);
		global.localeCJK_S_0 = font_add(global.rezonatorFontDirString +"/KlokanTechNotoSansCJK-Regular.otf",10,false,false,32,127);
		global.localeEN_M_0 = font_add(global.rezonatorFontDirString +"/KlokanTechNotoSans-Regular.ttf",12,false,false,32,127);
		global.localeCJK_M_0 = font_add(global.rezonatorFontDirString +"/KlokanTechNotoSansCJK-Regular.otf",12,false,false,32,127);
		global.localeEN_L_0 = font_add(global.rezonatorFontDirString +"/KlokanTechNotoSans-Regular.ttf",14,false,false,32,127);
		global.localeCJK_L_0 = font_add(global.rezonatorFontDirString +"/KlokanTechNotoSansCJK-Regular.otf",14,false,false,32,127);


		//size_1
		global.localeEN_S_1 = font_add(global.rezonatorFontDirString +"/KlokanTechNotoSans-Regular.ttf",12,false,false,32,127);		
		global.localeCJK_S_1 = font_add(global.rezonatorFontDirString +"/KlokanTechNotoSansCJK-Regular.otf",12,false,false,32,127);
		global.localeEN_M_1 = font_add(global.rezonatorFontDirString +"/KlokanTechNotoSans-Regular.ttf",14,false,false,32,127);		
		global.localeCJK_M_1 = font_add(global.rezonatorFontDirString +"/KlokanTechNotoSansCJK-Regular.otf",14,false,false,32,127);
		global.localeEN_L_1 = font_add(global.rezonatorFontDirString +"/KlokanTechNotoSans-Regular.ttf",16,false,false,32,127);		
		global.localeCJK_L_1 = font_add(global.rezonatorFontDirString +"/KlokanTechNotoSansCJK-Regular.otf",16,false,false,32,127);
		
		//size_2
		global.localeEN_S_2 = font_add(global.rezonatorFontDirString +"/KlokanTechNotoSans-Regular.ttf",14,false,false,32,127);		
		global.localeCJK_S_2 = font_add(global.rezonatorFontDirString +"/KlokanTechNotoSansCJK-Regular.otf",14,false,false,32,127);
		global.localeEN_M_2 = font_add(global.rezonatorFontDirString +"/KlokanTechNotoSans-Regular.ttf",16,false,false,32,127);		
		global.localeCJK_M_2 = font_add(global.rezonatorFontDirString +"/KlokanTechNotoSansCJK-Regular.otf",16,false,false,32,127);
		global.localeEN_L_2 = font_add(global.rezonatorFontDirString +"/KlokanTechNotoSans-Regular.ttf",18,false,false,32,127);		
		global.localeCJK_L_2 = font_add(global.rezonatorFontDirString +"/KlokanTechNotoSansCJK-Regular.otf",18,false,false,32,127);
		
		//size_3
		global.localeEN_S_3 = font_add(global.rezonatorFontDirString +"/KlokanTechNotoSans-Regular.ttf",16,false,false,32,127);		
		global.localeCJK_S_3 = font_add(global.rezonatorFontDirString +"/KlokanTechNotoSansCJK-Regular.otf",16,false,false,32,127);
		global.localeEN_M_3 = font_add(global.rezonatorFontDirString +"/KlokanTechNotoSans-Regular.ttf",18,false,false,32,127);		
		global.localeCJK_M_3 = font_add(global.rezonatorFontDirString +"/KlokanTechNotoSansCJK-Regular.otf",18,false,false,32,127);
		global.localeEN_L_3 = font_add(global.rezonatorFontDirString +"/KlokanTechNotoSans-Regular.ttf",20,false,false,32,127);		
		global.localeCJK_L_3 = font_add(global.rezonatorFontDirString +"/KlokanTechNotoSansCJK-Regular.otf",20,false,false,32,127);
		
		//size_4
		global.localeEN_S_4 = font_add(global.rezonatorFontDirString +"/KlokanTechNotoSans-Regular.ttf",18,false,false,32,127);		
		global.localeCJK_S_4 = font_add(global.rezonatorFontDirString +"/KlokanTechNotoSansCJK-Regular.otf",18,false,false,32,127);
		global.localeEN_M_4 = font_add(global.rezonatorFontDirString +"/KlokanTechNotoSans-Regular.ttf",20,false,false,32,127);		
		global.localeCJK_M_4 = font_add(global.rezonatorFontDirString +"/KlokanTechNotoSansCJK-Regular.otf",20,false,false,32,127);
		global.localeEN_L_4 = font_add(global.rezonatorFontDirString +"/KlokanTechNotoSans-Regular.ttf",22,false,false,32,127);		
		global.localeCJK_L_4 = font_add(global.rezonatorFontDirString +"/KlokanTechNotoSansCJK-Regular.otf",22,false,false,32,127);
		
		//size_5
		global.localeEN_S_5 = font_add(global.rezonatorFontDirString +"/KlokanTechNotoSans-Regular.ttf",20,false,false,32,127);		
		global.localeCJK_S_5 = font_add(global.rezonatorFontDirString +"/KlokanTechNotoSansCJK-Regular.otf",20,false,false,32,127);
		global.localeEN_M_5 = font_add(global.rezonatorFontDirString +"/KlokanTechNotoSans-Regular.ttf",22,false,false,32,127);		
		global.localeCJK_M_5 = font_add(global.rezonatorFontDirString +"/KlokanTechNotoSansCJK-Regular.otf",22,false,false,32,127);
		global.localeEN_L_5 = font_add(global.rezonatorFontDirString +"/KlokanTechNotoSans-Regular.ttf",24,false,false,32,127);		
		global.localeCJK_L_5 = font_add(global.rezonatorFontDirString +"/KlokanTechNotoSansCJK-Regular.otf",24,false,false,32,127);





	}
	else{
		// main fonts
		
		//size_0
		global.localeEN_S_0 = font_add(global.rezonatorFontDirString +"\\KlokanTechNotoSans-Regular.ttf",10,false,false,32,127);		
		global.localeCJK_S_0 = font_add(global.rezonatorFontDirString +"\\KlokanTechNotoSansCJK-Regular.otf",10,false,false,32,127);
		global.localeEN_M_0 = font_add(global.rezonatorFontDirString +"\\KlokanTechNotoSans-Regular.ttf",12,false,false,32,127);		
		global.localeCJK_M_0 = font_add(global.rezonatorFontDirString +"\\KlokanTechNotoSansCJK-Regular.otf",12,false,false,32,127);
		global.localeEN_L_0 = font_add(global.rezonatorFontDirString +"\\KlokanTechNotoSans-Regular.ttf",14,false,false,32,127);		
		global.localeCJK_L_0 = font_add(global.rezonatorFontDirString +"\\KlokanTechNotoSansCJK-Regular.otf",14,false,false,32,127);
		
		//size_1
		global.localeEN_S_1 = font_add(global.rezonatorFontDirString +"\\KlokanTechNotoSans-Regular.ttf",12,false,false,32,127);		
		global.localeCJK_S_1 = font_add(global.rezonatorFontDirString +"\\KlokanTechNotoSansCJK-Regular.otf",12,false,false,32,127);
		global.localeEN_M_1 = font_add(global.rezonatorFontDirString +"\\KlokanTechNotoSans-Regular.ttf",14,false,false,32,127);		
		global.localeCJK_M_1 = font_add(global.rezonatorFontDirString +"\\KlokanTechNotoSansCJK-Regular.otf",14,false,false,32,127);
		global.localeEN_L_1 = font_add(global.rezonatorFontDirString +"\\KlokanTechNotoSans-Regular.ttf",16,false,false,32,127);		
		global.localeCJK_L_1 = font_add(global.rezonatorFontDirString +"\\KlokanTechNotoSansCJK-Regular.otf",16,false,false,32,127);
		
		//size_2
		global.localeEN_S_2 = font_add(global.rezonatorFontDirString +"\\KlokanTechNotoSans-Regular.ttf",14,false,false,32,127);		
		global.localeCJK_S_2 = font_add(global.rezonatorFontDirString +"\\KlokanTechNotoSansCJK-Regular.otf",14,false,false,32,127);
		global.localeEN_M_2 = font_add(global.rezonatorFontDirString +"\\KlokanTechNotoSans-Regular.ttf",16,false,false,32,127);		
		global.localeCJK_M_2 = font_add(global.rezonatorFontDirString +"\\KlokanTechNotoSansCJK-Regular.otf",16,false,false,32,127);
		global.localeEN_L_2 = font_add(global.rezonatorFontDirString +"\\KlokanTechNotoSans-Regular.ttf",18,false,false,32,127);		
		global.localeCJK_L_2 = font_add(global.rezonatorFontDirString +"\\KlokanTechNotoSansCJK-Regular.otf",18,false,false,32,127);
		
		//size_3
		global.localeEN_S_3 = font_add(global.rezonatorFontDirString +"\\KlokanTechNotoSans-Regular.ttf",16,false,false,32,127);		
		global.localeCJK_S_3 = font_add(global.rezonatorFontDirString +"\\KlokanTechNotoSansCJK-Regular.otf",16,false,false,32,127);
		global.localeEN_M_3 = font_add(global.rezonatorFontDirString +"\\KlokanTechNotoSans-Regular.ttf",18,false,false,32,127);		
		global.localeCJK_M_3 = font_add(global.rezonatorFontDirString +"\\KlokanTechNotoSansCJK-Regular.otf",18,false,false,32,127);
		global.localeEN_L_3 = font_add(global.rezonatorFontDirString +"\\KlokanTechNotoSans-Regular.ttf",20,false,false,32,127);		
		global.localeCJK_L_3 = font_add(global.rezonatorFontDirString +"\\KlokanTechNotoSansCJK-Regular.otf",20,false,false,32,127);
		
		//size_4
		global.localeEN_S_4 = font_add(global.rezonatorFontDirString +"\\KlokanTechNotoSans-Regular.ttf",18,false,false,32,127);		
		global.localeCJK_S_4 = font_add(global.rezonatorFontDirString +"\\KlokanTechNotoSansCJK-Regular.otf",18,false,false,32,127);
		global.localeEN_M_4 = font_add(global.rezonatorFontDirString +"\\KlokanTechNotoSans-Regular.ttf",20,false,false,32,127);		
		global.localeCJK_M_4 = font_add(global.rezonatorFontDirString +"\\KlokanTechNotoSansCJK-Regular.otf",20,false,false,32,127);
		global.localeEN_L_4 = font_add(global.rezonatorFontDirString +"\\KlokanTechNotoSans-Regular.ttf",22,false,false,32,127);		
		global.localeCJK_L_4 = font_add(global.rezonatorFontDirString +"\\KlokanTechNotoSansCJK-Regular.otf",22,false,false,32,127);
		
		//size_5
		global.localeEN_S_5 = font_add(global.rezonatorFontDirString +"\\KlokanTechNotoSans-Regular.ttf",20,false,false,32,127);		
		global.localeCJK_S_5 = font_add(global.rezonatorFontDirString +"\\KlokanTechNotoSansCJK-Regular.otf",20,false,false,32,127);
		global.localeEN_M_5 = font_add(global.rezonatorFontDirString +"\\KlokanTechNotoSans-Regular.ttf",22,false,false,32,127);		
		global.localeCJK_M_5 = font_add(global.rezonatorFontDirString +"\\KlokanTechNotoSansCJK-Regular.otf",22,false,false,32,127);
		global.localeEN_L_5 = font_add(global.rezonatorFontDirString +"\\KlokanTechNotoSans-Regular.ttf",24,false,false,32,127);		
		global.localeCJK_L_5 = font_add(global.rezonatorFontDirString +"\\KlokanTechNotoSansCJK-Regular.otf",24,false,false,32,127);

	}
}
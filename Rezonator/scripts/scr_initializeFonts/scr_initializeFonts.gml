// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_initializeFonts(){
	
	
		if	(os_type == os_macosx)	{	
			global.localeEN_S_0 = font_add(global.rezonatorFontDirString +"/KlokanTechNotoSans-Regular.ttf",10,false,false,32,127);
			global.localeEN_M_0 = font_add(global.rezonatorFontDirString +"/KlokanTechNotoSans-Regular.ttf",12,false,false,32,127);
			global.localeEN_L_0 = font_add(global.rezonatorFontDirString +"/KlokanTechNotoSans-Regular.ttf",14,false,false,32,127);
		
		}
		else{
			global.localeEN_S_0 = font_add(global.rezonatorFontDirString +"\\KlokanTechNotoSans-Regular.ttf",10,false,false,32,127);
			global.localeEN_M_0 = font_add(global.rezonatorFontDirString +"\\KlokanTechNotoSans-Regular.ttf",12,false,false,32,127);
			global.localeEN_L_0 = font_add(global.rezonatorFontDirString +"\\KlokanTechNotoSans-Regular.ttf",14,false,false,32,127);
			
		}
	
		
		//size_0
		global.localeCJK_S_0 = 0;
		global.localeCJK_M_0 = 0;
		global.localeCJK_L_0 = 0;
		
		//size_1
		global.localeEN_S_1 = 0;		
		global.localeCJK_S_1 = 0;
		global.localeEN_M_1 = 0;		
		global.localeCJK_M_1 = 0;
		global.localeEN_L_1 = 0;		
		global.localeCJK_L_1 = 0;
		
		//size_2
		global.localeEN_S_2 = 0;		
		global.localeCJK_S_2 = 0;
		global.localeEN_M_2 = 0;		
		global.localeCJK_M_2 = 0;
		global.localeEN_L_2 = 0;		
		global.localeCJK_L_2 = 0;
		
		//size_3
		global.localeEN_S_3 = 0;		
		global.localeCJK_S_3 = 0;
		global.localeEN_M_3 = 0;		
		global.localeCJK_M_3 = 0;
		global.localeEN_L_3 = 0;		
		global.localeCJK_L_3 = 0;
		
		//size_4
		global.localeEN_S_4 = 0;		
		global.localeCJK_S_4 = 0;
		global.localeEN_M_4 = 0;		
		global.localeCJK_M_4 = 0;
		global.localeEN_L_4 = 0;		
		global.localeCJK_L_4 = 0;
		
		//size_5
		global.localeEN_S_5 = font_add(global.rezonatorFontDirString +"\\KlokanTechNotoSans-Regular.ttf",20,false,false,32,127);		
		global.localeCJK_S_5 = font_add(global.rezonatorFontDirString +"\\KlokanTechNotoSansCJK-Regular.otf",20,false,false,32,127);
		global.localeEN_M_5 = font_add(global.rezonatorFontDirString +"\\KlokanTechNotoSans-Regular.ttf",22,false,false,32,127);		
		global.localeCJK_M_5 = font_add(global.rezonatorFontDirString +"\\KlokanTechNotoSansCJK-Regular.otf",22,false,false,32,127);
		global.localeEN_L_5 = font_add(global.rezonatorFontDirString +"\\KlokanTechNotoSans-Regular.ttf",24,false,false,32,127);		
		global.localeCJK_L_5 = font_add(global.rezonatorFontDirString +"\\KlokanTechNotoSansCJK-Regular.otf",24,false,false,32,127);

}
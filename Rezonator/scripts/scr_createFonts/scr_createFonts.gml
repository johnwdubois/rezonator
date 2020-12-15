// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_createFonts(build){

	if(build){
		if	(os_type == os_macosx)	{	
			// main fonts

				global.localeCJK_S_0 = font_add(global.rezonatorFontDirString +"/KlokanTechNotoSansCJK-Regular.otf",10,false,false,32,127);
				global.localeCJK_M_0 = font_add(global.rezonatorFontDirString +"/KlokanTechNotoSansCJK-Regular.otf",12,false,false,32,127);
				global.localeCJK_L_0 = font_add(global.rezonatorFontDirString +"/KlokanTechNotoSansCJK-Regular.otf",14,false,false,32,127);
		

			//size_1	
				global.localeCJK_S_1 = font_add(global.rezonatorFontDirString +"/KlokanTechNotoSansCJK-Regular.otf",12,false,false,32,127);	
				global.localeCJK_M_1 = font_add(global.rezonatorFontDirString +"/KlokanTechNotoSansCJK-Regular.otf",14,false,false,32,127);	
				global.localeCJK_L_1 = font_add(global.rezonatorFontDirString +"/KlokanTechNotoSansCJK-Regular.otf",16,false,false,32,127);

		
			//size_2	
				global.localeCJK_S_2 = font_add(global.rezonatorFontDirString +"/KlokanTechNotoSansCJK-Regular.otf",14,false,false,32,127);	
				global.localeCJK_M_2 = font_add(global.rezonatorFontDirString +"/KlokanTechNotoSansCJK-Regular.otf",16,false,false,32,127);	
				global.localeCJK_L_2 = font_add(global.rezonatorFontDirString +"/KlokanTechNotoSansCJK-Regular.otf",18,false,false,32,127);

		
			//size_3	
				global.localeCJK_S_3 = font_add(global.rezonatorFontDirString +"/KlokanTechNotoSansCJK-Regular.otf",16,false,false,32,127);		
				global.localeCJK_M_3 = font_add(global.rezonatorFontDirString +"/KlokanTechNotoSansCJK-Regular.otf",18,false,false,32,127);	
				global.localeCJK_L_3 = font_add(global.rezonatorFontDirString +"/KlokanTechNotoSansCJK-Regular.otf",20,false,false,32,127);

		
			//size_4	
				global.localeCJK_S_4 = font_add(global.rezonatorFontDirString +"/KlokanTechNotoSansCJK-Regular.otf",18,false,false,32,127);		
				global.localeCJK_M_4 = font_add(global.rezonatorFontDirString +"/KlokanTechNotoSansCJK-Regular.otf",20,false,false,32,127);	
				global.localeCJK_L_4 = font_add(global.rezonatorFontDirString +"/KlokanTechNotoSansCJK-Regular.otf",22,false,false,32,127);

		
			//size_5	
				global.localeCJK_S_5 = font_add(global.rezonatorFontDirString +"/KlokanTechNotoSansCJK-Regular.otf",20,false,false,32,127);	
				global.localeCJK_M_5 = font_add(global.rezonatorFontDirString +"/KlokanTechNotoSansCJK-Regular.otf",22,false,false,32,127);	
				global.localeCJK_L_5 = font_add(global.rezonatorFontDirString +"/KlokanTechNotoSansCJK-Regular.otf",24,false,false,32,127);


		}
		else{
			// main fonts
		
			//size_0		
				global.localeCJK_S_0 = font_add(global.rezonatorFontDirString +"\\KlokanTechNotoSansCJK-Regular.otf",10,false,false,32,127);		
				global.localeCJK_M_0 = font_add(global.rezonatorFontDirString +"\\KlokanTechNotoSansCJK-Regular.otf",12,false,false,32,127);	
				global.localeCJK_L_0 = font_add(global.rezonatorFontDirString +"\\KlokanTechNotoSansCJK-Regular.otf",14,false,false,32,127);
		
			//size_1		
				global.localeCJK_S_1 = font_add(global.rezonatorFontDirString +"\\KlokanTechNotoSansCJK-Regular.otf",12,false,false,32,127);		
				global.localeCJK_M_1 = font_add(global.rezonatorFontDirString +"\\KlokanTechNotoSansCJK-Regular.otf",14,false,false,32,127);	
				global.localeCJK_L_1 = font_add(global.rezonatorFontDirString +"\\KlokanTechNotoSansCJK-Regular.otf",16,false,false,32,127);

		
			//size_2		
				global.localeCJK_S_2 = font_add(global.rezonatorFontDirString +"\\KlokanTechNotoSansCJK-Regular.otf",14,false,false,32,127);		
				global.localeCJK_M_2 = font_add(global.rezonatorFontDirString +"\\KlokanTechNotoSansCJK-Regular.otf",16,false,false,32,127);		
				global.localeCJK_L_2 = font_add(global.rezonatorFontDirString +"\\KlokanTechNotoSansCJK-Regular.otf",18,false,false,32,127);

		
			//size_3		
				global.localeCJK_S_3 = font_add(global.rezonatorFontDirString +"\\KlokanTechNotoSansCJK-Regular.otf",16,false,false,32,127);		
				global.localeCJK_M_3 = font_add(global.rezonatorFontDirString +"\\KlokanTechNotoSansCJK-Regular.otf",18,false,false,32,127);		
				global.localeCJK_L_3 = font_add(global.rezonatorFontDirString +"\\KlokanTechNotoSansCJK-Regular.otf",20,false,false,32,127);

		
			//size_4		
				global.localeCJK_S_4 = font_add(global.rezonatorFontDirString +"\\KlokanTechNotoSansCJK-Regular.otf",18,false,false,32,127);		
				global.localeCJK_M_4 = font_add(global.rezonatorFontDirString +"\\KlokanTechNotoSansCJK-Regular.otf",20,false,false,32,127);		
				global.localeCJK_L_4 = font_add(global.rezonatorFontDirString +"\\KlokanTechNotoSansCJK-Regular.otf",22,false,false,32,127);

		
			//size_5		
				global.localeCJK_S_5 = font_add(global.rezonatorFontDirString +"\\KlokanTechNotoSansCJK-Regular.otf",20,false,false,32,127);		
				global.localeCJK_M_5 = font_add(global.rezonatorFontDirString +"\\KlokanTechNotoSansCJK-Regular.otf",22,false,false,32,127);		
				global.localeCJK_L_5 = font_add(global.rezonatorFontDirString +"\\KlokanTechNotoSansCJK-Regular.otf",24,false,false,32,127);

		}
	}
	global.fontsLoaded = true;
	
}
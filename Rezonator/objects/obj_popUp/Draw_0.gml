/// @description Insert description here
// You can write your code in this editor

if(currentPopUp == 0){

	draw_set_colour(global.colorThemeBG);
	draw_roundrect(camera_get_view_width(camera_get_active()) - 295, 0 + obj_menuBar.menuHeight, camera_get_view_width(camera_get_active()) - 105,200 + obj_menuBar.menuHeight, false);
	draw_set_colour(global.colorThemeBorders);
	draw_roundrect(camera_get_view_width(camera_get_active()) - 295, 0 + obj_menuBar.menuHeight, camera_get_view_width(camera_get_active()) - 105,200 + obj_menuBar.menuHeight, true);
	draw_rectangle(camera_get_view_width(camera_get_active()) - 295, 175 + obj_menuBar.menuHeight, camera_get_view_width(camera_get_active()) - 105,175 + obj_menuBar.menuHeight, true);
	draw_rectangle(mean(camera_get_view_width(camera_get_active()) - 295,camera_get_view_width(camera_get_active()) - 105), 175 + obj_menuBar.menuHeight,mean(camera_get_view_width(camera_get_active()) - 295,camera_get_view_width(camera_get_active()) - 105),200 + obj_menuBar.menuHeight, true);
	

	draw_set_halign(fa_center);
	scr_adaptFont("TOOL PANE","L");
	draw_text(mean(camera_get_view_width(camera_get_active()) - 295,  camera_get_view_width(camera_get_active()) - 105)-10, 20 + obj_menuBar.menuHeight, "TOOL PANE");
	draw_rectangle(camera_get_view_width(camera_get_active()) - 295 + 30, 35 + obj_menuBar.menuHeight,  camera_get_view_width(camera_get_active()) - 105 - 50, 35 + obj_menuBar.menuHeight, true);
	draw_rectangle(camera_get_view_width(camera_get_active()) - 295 + 30, 36 + obj_menuBar.menuHeight,  camera_get_view_width(camera_get_active()) - 105 - 50, 36 + obj_menuBar.menuHeight, true);
	draw_rectangle(camera_get_view_width(camera_get_active()) - 295 + 30, 37 + obj_menuBar.menuHeight,  camera_get_view_width(camera_get_active()) - 105 - 50, 37 + obj_menuBar.menuHeight, true);
	
	
	
	draw_sprite_ext(spr_xButton, 0,camera_get_view_width(camera_get_active()) - 125, 20 + obj_menuBar.menuHeight, 1, 1, 90, c_black, 1);
	
	
	if(mouseOverExitButton){
			draw_rectangle(camera_get_view_width(camera_get_active()) - 105 -30 , 10 + obj_menuBar.menuHeight, camera_get_view_width(camera_get_active()) - 105 -10 ,30 + obj_menuBar.menuHeight, true);
	}
	
	scr_adaptFont(popUpText1, "M");
	draw_text( mean(camera_get_view_width(camera_get_active()) - 285, camera_get_view_width(camera_get_active()) - 105 ), 110 + obj_menuBar.menuHeight , popUpText1);
	
	draw_sprite_ext(spr_ascend, 0, mean(mean(camera_get_view_width(camera_get_active()) - 295,camera_get_view_width(camera_get_active()) - 105),camera_get_view_width(camera_get_active()) -  105), mean(175 + obj_menuBar.menuHeight,200 + obj_menuBar.menuHeight), 1, 1, 270, c_white, 1);
}
else if(currentPopUp == 1){
	
	
	
	draw_set_colour(global.colorThemeBG);
	draw_roundrect(camera_get_view_width(camera_get_active()) - 295, 0 + obj_menuBar.menuHeight, camera_get_view_width(camera_get_active()) - 105,200 + obj_menuBar.menuHeight, false);
	draw_set_colour(global.colorThemeBorders);
	draw_roundrect(camera_get_view_width(camera_get_active()) - 295, 0 + obj_menuBar.menuHeight, camera_get_view_width(camera_get_active()) - 105,200 + obj_menuBar.menuHeight, true);
	draw_rectangle(camera_get_view_width(camera_get_active()) - 295, 175 + obj_menuBar.menuHeight, camera_get_view_width(camera_get_active()) - 105,175 + obj_menuBar.menuHeight, true);
	draw_rectangle(mean(camera_get_view_width(camera_get_active()) - 295,camera_get_view_width(camera_get_active()) - 105), 175 + obj_menuBar.menuHeight,mean(camera_get_view_width(camera_get_active()) - 295,camera_get_view_width(camera_get_active()) - 105),200 + obj_menuBar.menuHeight, true);
	
	scr_adaptFont("NAV WINDOW","L");
	draw_set_halign(fa_center);
	draw_text(mean(camera_get_view_width(camera_get_active()) - 295,  camera_get_view_width(camera_get_active()) - 105)-10, 20 + obj_menuBar.menuHeight, "NAV WINDOW");
	draw_rectangle(camera_get_view_width(camera_get_active()) - 295 + 30, 35 + obj_menuBar.menuHeight,  camera_get_view_width(camera_get_active()) - 105 - 50, 35 + obj_menuBar.menuHeight, true);
	draw_rectangle(camera_get_view_width(camera_get_active()) - 295 + 30, 36 + obj_menuBar.menuHeight,  camera_get_view_width(camera_get_active()) - 105 - 50, 36 + obj_menuBar.menuHeight, true);
	draw_rectangle(camera_get_view_width(camera_get_active()) - 295 + 30, 37 + obj_menuBar.menuHeight,  camera_get_view_width(camera_get_active()) - 105 - 50, 37 + obj_menuBar.menuHeight, true);
	
	
	
	draw_sprite_ext(spr_xButton, 0,camera_get_view_width(camera_get_active()) - 125, 20 + obj_menuBar.menuHeight, 1, 1, 90, c_black, 1);
	
	
	if(mouseOverExitButton){
			draw_rectangle(camera_get_view_width(camera_get_active()) - 105 -30 , 10 + obj_menuBar.menuHeight, camera_get_view_width(camera_get_active()) - 105 -10 ,30 + obj_menuBar.menuHeight, true);
	}
	
	scr_adaptFont(popUpText2, "M");
	draw_text( mean(camera_get_view_width(camera_get_active()) - 285, camera_get_view_width(camera_get_active()) - 105 ), 110 + obj_menuBar.menuHeight , popUpText2);
	
	
	draw_sprite_ext(spr_ascend, 0, mean(mean(camera_get_view_width(camera_get_active()) - 295,camera_get_view_width(camera_get_active()) - 105), camera_get_view_width(camera_get_active()) - 295), mean(175 + obj_menuBar.menuHeight ,200 + obj_menuBar.menuHeight ), 1, 1, 90, c_white, 1);
	draw_sprite_ext(spr_ascend, 0,  mean(mean(camera_get_view_width(camera_get_active()) - 295,camera_get_view_width(camera_get_active()) - 105),camera_get_view_width(camera_get_active()) -  105), mean(175 + obj_menuBar.menuHeight,200 + obj_menuBar.menuHeight), 1, 1, 270, c_white, 1);
	/*
	draw_set_colour(global.colorThemeBG);
	draw_roundrect(secondPopUpX1 , 0 + obj_menuBar.menuHeight, secondPopUpX2 ,200 + obj_menuBar.menuHeight, false);
	draw_set_colour(global.colorThemeBorders);
	draw_roundrect(secondPopUpX1 , 0 + obj_menuBar.menuHeight, secondPopUpX2 ,200 + obj_menuBar.menuHeight, true);
	draw_rectangle(secondPopUpX1 , 175 + obj_menuBar.menuHeight, secondPopUpX2 ,175 + obj_menuBar.menuHeight, true);
	draw_rectangle(mean(secondPopUpX1 ,secondPopUpX2 ), 175 + obj_menuBar.menuHeight,mean(secondPopUpX1 ,secondPopUpX2 ),200 + obj_menuBar.menuHeight, true);
	
	draw_set_font(fnt_mainBold);
	draw_set_halign(fa_center);
	draw_text(mean(secondPopUpX1,secondPopUpX2)-10, 20 + obj_menuBar.menuHeight, "NAV WINDOW");
	draw_rectangle(secondPopUpX1 + 20, 35 + obj_menuBar.menuHeight, secondPopUpX2 - 40, 35 + obj_menuBar.menuHeight, true);
	draw_rectangle(secondPopUpX1 + 20, 36 + obj_menuBar.menuHeight, secondPopUpX2 - 40, 36 + obj_menuBar.menuHeight, true);
	draw_rectangle(secondPopUpX1 + 20, 37 + obj_menuBar.menuHeight, secondPopUpX2 - 40, 37 + obj_menuBar.menuHeight, true);
	
	
	draw_sprite_ext(spr_xButton, 0,secondPopUpX2 -20, 20 + obj_menuBar.menuHeight, 1, 1, 90, c_black, 1);
	
	if(mouseOverExitButton){
			draw_rectangle(secondPopUpX2 -30 , 10 + obj_menuBar.menuHeight, secondPopUpX2 -10 ,30 + obj_menuBar.menuHeight, true);
	}
	
	draw_set_font(fnt_main);
	draw_text( mean(secondPopUpX1,secondPopUpX2), 110  + obj_menuBar.menuHeight, popUpText2);
	
	draw_sprite_ext(spr_ascend, 0, mean(mean(secondPopUpX1,secondPopUpX2 ), secondPopUpX1), mean(175 + obj_menuBar.menuHeight,200 + obj_menuBar.menuHeight), 1, 1, 90, c_white, 1);
	draw_sprite_ext(spr_ascend, 0, mean(mean(secondPopUpX1,secondPopUpX2 ), secondPopUpX2) , mean(175 + obj_menuBar.menuHeight,200 + obj_menuBar.menuHeight), 1, 1, 270, c_white, 1);
	
	*/
}
else if(currentPopUp == 2){

	draw_set_colour(global.colorThemeBG);
	draw_roundrect(camera_get_view_width(camera_get_active()) - 295, 0 + obj_menuBar.menuHeight, camera_get_view_width(camera_get_active()) - 105,200 + obj_menuBar.menuHeight, false);
	draw_set_colour(global.colorThemeBorders);
	draw_roundrect(camera_get_view_width(camera_get_active()) - 295, 0 + obj_menuBar.menuHeight, camera_get_view_width(camera_get_active()) - 105,200 + obj_menuBar.menuHeight, true);
	draw_rectangle(camera_get_view_width(camera_get_active()) - 295, 175 + obj_menuBar.menuHeight, camera_get_view_width(camera_get_active()) - 105,175 + obj_menuBar.menuHeight, true);
	draw_rectangle(mean(camera_get_view_width(camera_get_active()) - 295,camera_get_view_width(camera_get_active()) - 105), 175 + obj_menuBar.menuHeight,mean(camera_get_view_width(camera_get_active()) - 295,camera_get_view_width(camera_get_active()) - 105),200 + obj_menuBar.menuHeight, true);
	
	scr_adaptFont("TOOL PANE","L");
	draw_set_halign(fa_center);
	draw_text(mean(camera_get_view_width(camera_get_active()) - 295,  camera_get_view_width(camera_get_active()) - 105)-10, 20 + obj_menuBar.menuHeight, "TOOL PANE");
	draw_rectangle(camera_get_view_width(camera_get_active()) - 295 + 30, 35 + obj_menuBar.menuHeight,  camera_get_view_width(camera_get_active()) - 105 - 50, 35 + obj_menuBar.menuHeight, true);
	draw_rectangle(camera_get_view_width(camera_get_active()) - 295 + 30, 36 + obj_menuBar.menuHeight,  camera_get_view_width(camera_get_active()) - 105 - 50, 36 + obj_menuBar.menuHeight, true);
	draw_rectangle(camera_get_view_width(camera_get_active()) - 295 + 30, 37 + obj_menuBar.menuHeight,  camera_get_view_width(camera_get_active()) - 105 - 50, 37 + obj_menuBar.menuHeight, true);
	
	
	
	draw_sprite_ext(spr_xButton, 0,camera_get_view_width(camera_get_active()) - 125, 20 + obj_menuBar.menuHeight, 1, 1, 90, c_black, 1);
	
	
	if(mouseOverExitButton){
			draw_rectangle(camera_get_view_width(camera_get_active()) - 105 -30 , 10 + obj_menuBar.menuHeight, camera_get_view_width(camera_get_active()) - 105 -10 ,30 + obj_menuBar.menuHeight, true);
	}
	
	scr_adaptFont(popUpText3, "M");
	draw_text( mean(camera_get_view_width(camera_get_active()) - 285, camera_get_view_width(camera_get_active()) - 105 ), 110 + obj_menuBar.menuHeight , popUpText3);
	
	draw_sprite_ext(spr_ascend, 0,mean(mean(camera_get_view_width(camera_get_active()) - 295,camera_get_view_width(camera_get_active()) - 105), camera_get_view_width(camera_get_active()) - 295), mean(175 + obj_menuBar.menuHeight ,200 + obj_menuBar.menuHeight ), 1, 1, 90, c_white, 1);
}
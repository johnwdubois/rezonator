/// @description Insert description here
// You can write your code in this editor

if(currentPopUp == 0){

	draw_set_colour(global.colorThemeBG);
	draw_roundrect(camera_get_view_width(view_camera[0]) - 295, 0, camera_get_view_width(view_camera[0]) - 105,200, false);
	draw_set_colour(global.colorThemeBorders);
	draw_roundrect(camera_get_view_width(view_camera[0]) - 295, 0, camera_get_view_width(view_camera[0]) - 105,200, true);
	draw_rectangle(camera_get_view_width(view_camera[0]) - 295, 175, camera_get_view_width(view_camera[0]) - 105,175, true);
	draw_rectangle(mean(camera_get_view_width(view_camera[0]) - 295,camera_get_view_width(view_camera[0]) - 105), 175,mean(camera_get_view_width(view_camera[0]) - 295,camera_get_view_width(view_camera[0]) - 105),200, true);
	
	draw_set_font(fnt_mainBold);
	draw_set_halign(fa_center);
	draw_text(mean(camera_get_view_width(view_camera[0]) - 295,  camera_get_view_width(view_camera[0]) - 105)-10, 20, "TOOL PANE");
	draw_rectangle(camera_get_view_width(view_camera[0]) - 295 + 30, 35,  camera_get_view_width(view_camera[0]) - 105 - 50, 35, true);
	draw_rectangle(camera_get_view_width(view_camera[0]) - 295 + 30, 36,  camera_get_view_width(view_camera[0]) - 105 - 50, 36, true);
	draw_rectangle(camera_get_view_width(view_camera[0]) - 295 + 30, 37,  camera_get_view_width(view_camera[0]) - 105 - 50, 37, true);
	
	
	
	draw_sprite_ext(spr_xButton, 0,camera_get_view_width(view_camera[0]) - 125, 20, 1, 1, 90, c_black, 1);
	
	
	if(mouseOverExitButton){
			draw_rectangle(camera_get_view_width(view_camera[0]) - 105 -30 , 10, camera_get_view_width(view_camera[0]) - 105 -10 ,30, true);
	}
	
	draw_set_font(fnt_main);
	draw_text( mean(camera_get_view_width(view_camera[0]) - 285, camera_get_view_width(view_camera[0]) - 105 ), 110 , popUpText1);
	
	draw_sprite_ext(spr_ascend, 0, mean(mean(camera_get_view_width(view_camera[0]) - 295,camera_get_view_width(view_camera[0]) - 105),camera_get_view_width(view_camera[0]) -  105), mean(175,200), 1, 1, 270, c_white, 1);
}
else if(currentPopUp == 1){
	
	with(obj_panelPane){
		
	}
	
	draw_set_colour(global.colorThemeBG);
	draw_roundrect(secondPopUpX1 , 0, secondPopUpX2 ,200, false);
	draw_set_colour(global.colorThemeBorders);
	draw_roundrect(secondPopUpX1 , 0, secondPopUpX2 ,200, true);
	draw_rectangle(secondPopUpX1 , 175, secondPopUpX2 ,175, true);
	draw_rectangle(mean(secondPopUpX1 ,secondPopUpX2 ), 175,mean(secondPopUpX1 ,secondPopUpX2 ),200, true);
	
	draw_set_font(fnt_mainBold);
	draw_set_halign(fa_center);
	draw_text(mean(secondPopUpX1,secondPopUpX2)-10, 20, "NAV WINDOW");
	draw_rectangle(secondPopUpX1 + 20, 35, secondPopUpX2 - 40, 35, true);
	draw_rectangle(secondPopUpX1 + 20, 36, secondPopUpX2 - 40, 36, true);
	draw_rectangle(secondPopUpX1 + 20, 37, secondPopUpX2 - 40, 37, true);
	
	
	draw_sprite_ext(spr_xButton, 0,secondPopUpX2 -20, 20, 1, 1, 90, c_black, 1);
	
	if(mouseOverExitButton){
			draw_rectangle(secondPopUpX2 -30 , 10, secondPopUpX2 -10 ,30, true);
	}
	
	draw_set_font(fnt_main);
	draw_text( mean(secondPopUpX1,secondPopUpX2), 110 , popUpText2);
	
	draw_sprite_ext(spr_ascend, 0, mean(mean(secondPopUpX1,secondPopUpX2 ), secondPopUpX1), mean(175,200), 1, 1, 90, c_white, 1);
	draw_sprite_ext(spr_ascend, 0, mean(mean(secondPopUpX1,secondPopUpX2 ), secondPopUpX2) , mean(175,200), 1, 1, 270, c_white, 1);
	
	
}
else if(currentPopUp == 2){

	draw_set_colour(global.colorThemeBG);
	draw_roundrect(camera_get_view_width(view_camera[0]) - 295, 0, camera_get_view_width(view_camera[0]) - 105,200, false);
	draw_set_colour(global.colorThemeBorders);
	draw_roundrect(camera_get_view_width(view_camera[0]) - 295, 0, camera_get_view_width(view_camera[0]) - 105,200, true);
	draw_rectangle(camera_get_view_width(view_camera[0]) - 295, 175, camera_get_view_width(view_camera[0]) - 105,175, true);
	draw_rectangle(mean(camera_get_view_width(view_camera[0]) - 295,camera_get_view_width(view_camera[0]) - 105), 175,mean(camera_get_view_width(view_camera[0]) - 295,camera_get_view_width(view_camera[0]) - 105),200, true);
	
	
		
	draw_set_font(fnt_mainBold);
	draw_set_halign(fa_center);
	draw_text(mean(camera_get_view_width(view_camera[0]) - 295,  camera_get_view_width(view_camera[0]) - 105)-10, 20, "HELP MENU");
	draw_rectangle(camera_get_view_width(view_camera[0]) - 295 + 30, 35,  camera_get_view_width(view_camera[0]) - 105 - 50, 35, true);
	draw_rectangle(camera_get_view_width(view_camera[0]) - 295 + 30, 36,  camera_get_view_width(view_camera[0]) - 105 - 50, 36, true);
	draw_rectangle(camera_get_view_width(view_camera[0]) - 295 + 30, 37,  camera_get_view_width(view_camera[0]) - 105 - 50, 37, true);
	
	
	draw_sprite_ext(spr_xButton, 0,camera_get_view_width(view_camera[0]) - 125, 20, 1, 1, 90, c_black, 1);
	
		
		if(mouseOverExitButton){
			draw_rectangle(camera_get_view_width(view_camera[0]) - 105 -30 , 10, camera_get_view_width(view_camera[0]) - 105 -10 ,30, true);
	}
	
	draw_set_halign(fa_center);
	draw_set_font(fnt_main);
	draw_text( mean(camera_get_view_width(view_camera[0]) - 285, camera_get_view_width(view_camera[0]) - 105 ), 110 , popUpText3);
	
	
	draw_sprite_ext(spr_ascend, 0,mean(mean(camera_get_view_width(view_camera[0]) - 295,camera_get_view_width(view_camera[0]) - 105), camera_get_view_width(view_camera[0]) - 295), mean(175,200), 1, 1, 90, c_white, 1);
}
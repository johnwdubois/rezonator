/// @description Insert description here
// You can write your code in this editor
//if (live_call()) return live_result;
//popUpText1 = string_hash_to_newline("You are in Read Mode.# To mark up the #discourse data, choose #either Track Mode or #Rez mode.");
//rectX1 = camera_get_view_width(view_camera[0]) - 245;
//rectY1 = obj_menuBar.menuHeight + obj_toolPane.windowHeight + 50;
//rectX2 = camera_get_view_width(view_camera[0]) - 45;
//rectY2 = 180 + rectY1;//
//if (live_call()) return live_result;
draw_set_font(global.fontMainBold);
rectX2 = rectX1 + 60 + string_width("Track mode (to mark coreference between mentions)");
rectY2 = 40 + rectY1 + string_height(popUpText2) + string_height(popUpText1);
var bubblePlus = obj_control.wordDrawGridFocusedAnimation;
draw_set_colour(global.colorThemeBG);
draw_roundrect(rectX1 - bubblePlus, rectY1 - bubblePlus, rectX2 + bubblePlus, rectY2 + bubblePlus, false);

draw_set_colour(global.colorThemeBorders);
draw_roundrect(rectX1 - bubblePlus, rectY1 - bubblePlus, rectX2 + bubblePlus, rectY2 + bubblePlus, true);

	

draw_set_halign(fa_center);
draw_text(mean(rectX1,  rectX2), 20 + rectY1, popUpText1);
draw_line_width(rectX1 + 30, 35 + rectY1,  rectX2 - 50, 35 + rectY1, 3);
	
	
draw_set_font(global.fontMain);
draw_text( mean(rectX1, rectX2) + 20, mean(rectY1 + 20, rectY2), popUpText2);

var largeHeight = string_height(popUpText1);
draw_set_font(fnt_main);
var standardHeight = string_height(popUpText1);
var spriteRatio = largeHeight/standardHeight;
var spriteSize = 0.25 * spriteRatio;

draw_sprite_ext(spr_toolsNew, 8, rectX1 + 35, mean(rectY1 + 20, rectY2), spriteSize, spriteSize, 0, c_white, 1); 
draw_sprite_ext(spr_toolsNew, 5, rectX1 + 60, mean(rectY1 + 20, rectY2) + largeHeight, spriteSize, spriteSize, 0, c_white, 1); 

draw_sprite_ext(spr_backArrow, 0, camera_get_view_width(view_camera[0]) - 150, obj_menuBar.menuHeight + obj_toolPane.windowHeight -21 + bubblePlus, 1, 1, 270, global.colorThemeBorders, 1); 
draw_sprite_ext(spr_backArrow, 0, camera_get_view_width(view_camera[0]) - 60, obj_menuBar.menuHeight + obj_toolPane.windowHeight -21 + bubblePlus, 1, 1, 270, global.colorThemeBorders, 1); 
/// @description Insert description here
// You can write your code in this editor
//if (live_call()) return live_result;
//popUpText1 = string_hash_to_newline("You are in Read Mode.# To mark up the #discourse data, choose #either Track Mode or #Rez mode.");
//rectX1 = camera_get_view_width(view_camera[0]) - 245;
//rectY1 = obj_menuBar.menuHeight + obj_toolPane.windowHeight + 50;
//rectX2 = camera_get_view_width(view_camera[0]) - 45;
//rectY2 = 180 + rectY1;

draw_set_colour(global.colorThemeBG);
draw_roundrect(rectX1, rectY1, rectX2, rectY2, false);

draw_set_colour(global.colorThemeBorders);
draw_roundrect(rectX1, rectY1, rectX2, rectY2, true);

	
draw_set_font(fnt_mainBold);
draw_set_halign(fa_center);
draw_text(mean(rectX1,  rectX2), 20 + rectY1, "Here's a hint!");
draw_line_width(rectX1 + 30, 35 + rectY1,  rectX2 - 50, 35 + rectY1, 3);
	
	
draw_set_font(fnt_main);
draw_text( mean(rectX1, rectX2), mean(rectY1 + 20, rectY2), popUpText1);


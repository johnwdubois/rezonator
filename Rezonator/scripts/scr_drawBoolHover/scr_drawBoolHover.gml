// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_drawBoolHover(boolObject){
	var currentStateString = "";
					
	if(boolObject){
		currentStateString = scr_get_translation("msg_enabled");
	}
	else{
		currentStateString = scr_get_translation("msg_disabled");
	}
					
	var currentStringWidth = string_width(currentStateString);
	var currentStringHeight = string_height(currentStateString);
					
	var toggleBoxX1 = mouse_x - currentStringWidth/2 - 5;
	var toggleBoxX2 = mouse_x + currentStringWidth/2 + 5;
	var toggleBoxY1 = mouse_y + 20;
	var toggleBoxY2 = toggleBoxY1 + currentStringHeight + 10;
	draw_set_color(c_white);
	draw_rectangle(toggleBoxX1, toggleBoxY1,toggleBoxX2, toggleBoxY2,false);
	draw_set_colour(global.colorThemeBorders);
	draw_rectangle(toggleBoxX1, toggleBoxY1,toggleBoxX2, toggleBoxY2,true);
			
	draw_set_halign(fa_center);
	draw_text(floor(mean(toggleBoxX1,toggleBoxX2)), floor(mean(toggleBoxY1, toggleBoxY2)), currentStateString);
}
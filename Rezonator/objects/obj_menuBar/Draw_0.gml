/// @description Insert description here
// You can write your code in this editor

//if (live_call()) return live_result;

draw_set_alpha(1);
draw_set_font(global.fontMainBold);
menuHeight = string_height("A") * 1.35;
menuWidth = string_width("Advanced");

// draw menu bar
draw_set_colour(global.colorThemeBG);
draw_rectangle(0, 0, camera_get_view_width(camera_get_active()), menuHeight, false);
draw_set_colour(global.colorThemeBorders);
draw_rectangle(-1, -1, camera_get_view_width(camera_get_active()) + 1, menuHeight, true);
	
// draw selection box and outline for file
/*if(mouseOverFile){
	draw_set_colour(global.colorThemeOutOfBounds);
	draw_rectangle(-1, -1, menuWidth, menuHeight, false);
}
//draw_set_colour(global.colorThemeBorders);
//draw_rectangle(-1, -1, menuWidth, menuHeight, true);
	
	
// draw selection box and outline for Edit
if(mouseOverEdit){
	draw_set_colour(global.colorThemeOutOfBounds);
	draw_rectangle(menuWidth, -1, menuWidth*2, menuHeight, false);
}
//draw_set_colour(global.colorThemeBorders);
//draw_rectangle(menuWidth, -1, menuWidth*2, menuHeight, true);
	
	
// draw selection box and outline for View
if(mouseOverView){
	draw_set_colour(global.colorThemeOutOfBounds);
	draw_rectangle(menuWidth*2, -1, menuWidth*3, menuHeight, false);
}
//draw_set_colour(global.colorThemeBorders);
//draw_rectangle(menuWidth*2, -1, menuWidth*3, menuHeight, true);
		
// draw selection box and outline for Search
if(mouseOverSearch){
	draw_set_colour(global.colorThemeOutOfBounds);
	draw_rectangle(menuWidth*3, -1, menuWidth*4.5, menuHeight, false);
}
// draw selection box and outline for Search
if(mouseOverOptions){
	draw_set_colour(global.colorThemeOutOfBounds);
	draw_rectangle(menuWidth*4.5, -1, menuWidth*6, menuHeight, false);
}
//draw_set_colour(global.colorThemeBorders);
//draw_rectangle(menuWidth*3, -1, menuWidth*4.5, menuHeight, true);
if(mouseOverStackShow){
	draw_set_colour(global.colorThemeOutOfBounds);
	draw_rectangle(menuWidth*6, -1, menuWidth*8, menuHeight, false);
}	
if(mouseOverSortPane){
	draw_set_colour(global.colorThemeOutOfBounds);
	draw_rectangle(menuWidth*8, -1, menuWidth*10, menuHeight, false);
}	*/
	
	
//draw text fore boxes
draw_set_colour(global.colorThemeText);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
//var menuOptionY = 0;
//var menuOptionX = 100;
	
/*for (var menuHeaderLoop = 0; menuHeaderLoop < menuBarGridHeight; menuHeaderLoop++){
	var headerString = ds_grid_get(menuBarGrid, menuBarGrid_colString, menuHeaderLoop);
	draw_text(mean(menuWidth * (menuHeaderLoop), menuWidth * (menuHeaderLoop + 1)), menuHeight - 25, headerString);		
}*/
for (var menuHeaderLoop = 0; menuHeaderLoop < menuBarGridHeight; menuHeaderLoop++){
	if (ds_grid_get(menuBarGrid, menuBarGrid_colMouseOver, menuHeaderLoop)) {
		draw_set_colour(global.colorThemeOutOfBounds);
		draw_rectangle((menuWidth * menuHeaderLoop) - 1, -1, menuWidth * (menuHeaderLoop + 1), menuHeight, false);
		draw_set_colour(global.colorThemeText);
	}
	var headerString = ds_grid_get(menuBarGrid, menuBarGrid_colString, menuHeaderLoop);
	draw_text(floor(mean(menuWidth * (menuHeaderLoop), menuWidth * (menuHeaderLoop + 1))), floor(mean(y, y + menuHeight)), headerString);		
}

/*draw_text(mean(0, menuWidth), menuHeight - 25,"File");
draw_text(mean(menuWidth, menuWidth*2), menuHeight - 25,"Edit");
draw_text(mean(menuWidth*2, menuWidth*3), menuHeight - 25,"View");
draw_text(mean(menuWidth*3, menuWidth*4.5), menuHeight - 25,"Search");
draw_text(mean(menuWidth*4.5, menuWidth*6), menuHeight - 25,"Options");
draw_text(mean(menuWidth*6, menuWidth*8), menuHeight - 25,"StackShow");
draw_text(mean(menuWidth*8, menuWidth*10), menuHeight - 25,"Sort Pane");*/
	
	
	
	
	
if (obj_control.showFPS) {
	var fpsTextX = camera_get_view_width(camera_get_active()) - string_width("000");
	var fpsTextY = menuHeight / 2;
	draw_set_halign(fa_right);
	draw_set_valign(fa_middle);
	draw_text(fpsTextX, fpsTextY, "FPS: " + string(fps));
}
/// @description Insert description here
// You can write your code in this editor

	draw_set_alpha(1);
	draw_set_font(fnt_mainBold);

	// draw menu bar
	draw_set_colour(global.colorThemeBG);
	draw_rectangle(0, 0, camera_get_view_width(view_camera[0]), menuHeight, false);
	draw_set_colour(global.colorThemeBorders);
	draw_rectangle(-1, -1, camera_get_view_width(view_camera[0])+1, menuHeight, true);
	
	// draw selection box and outline for file
	if(mouseOverFile){
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
	
	
	
	//draw text fore boxes
	draw_set_colour(global.colorThemeText);
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	var menuOptionY = 0;
	var menuOptionX = 100;
	
	draw_text(mean(0, menuWidth), menuHeight - 25,"File");
	draw_text(mean(menuWidth, menuWidth*2), menuHeight - 25,"Edit");
	draw_text(mean(menuWidth*2, menuWidth*3), menuHeight - 25,"View");
	draw_text(mean(menuWidth*3, menuWidth*4.5), menuHeight - 25,"Search");
	draw_text(mean(menuWidth*4.5, menuWidth*6), menuHeight - 25,"Options");
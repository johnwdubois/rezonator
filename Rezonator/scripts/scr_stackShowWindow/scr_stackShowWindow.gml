
/*
	scr_stackShowWindow();
	
	Last Updated: 2019-06-25
	
	Called from: obj_control
	
	Purpose: draw custom search box for multiple options
	
	Mechanism: draws multiple rectangles and text to represent options to the user when they search,
	this includes booleans for a case sensitive search, transcript search, and a search within a chain
				
	Author: Brady Moore
*/


	var verticleBuffer = 230;
	var horizontalBuffer = 200;
	var stackBoxXOffset = 180;
	var stackBoxYOffset = 160;
	var buttonXOffset = 65;
	var buttonYOffset = 25;


if (stackShowWindowActive) {
	obj_control.mouseoverPanelPane = true;

	

	draw_set_halign(fa_left);
	draw_set_colour(global.colorThemeBG);
	draw_rectangle(camera_get_view_width(view_camera[0]) /2 - horizontalBuffer, camera_get_view_height(view_camera[0])/2 - verticleBuffer, camera_get_view_width(view_camera[0]) /2 + horizontalBuffer, camera_get_view_height(view_camera[0])/2 + verticleBuffer, false);
	x = camera_get_view_width(view_camera[0]) /2 - stackBoxXOffset;
	y = camera_get_view_height(view_camera[0])/2 - stackBoxYOffset - 35;
	
	draw_set_colour(global.colorThemePaneBG);
	if (global.colorTheme ==0) {
	draw_set_colour(c_ltgray);
	}
	// draw background UI
	draw_rectangle(camera_get_view_width(view_camera[0]) /2 - horizontalBuffer, camera_get_view_height(view_camera[0])/2 - verticleBuffer + 30, camera_get_view_width(view_camera[0]) /2 + horizontalBuffer, camera_get_view_height(view_camera[0])/2 + verticleBuffer, false);
	draw_set_colour(global.colorThemeBorders);
	draw_rectangle(camera_get_view_width(view_camera[0]) /2 - horizontalBuffer, camera_get_view_height(view_camera[0])/2 - verticleBuffer + 30, camera_get_view_width(view_camera[0]) /2 + horizontalBuffer, camera_get_view_height(view_camera[0])/2 + verticleBuffer, true);
	draw_rectangle(camera_get_view_width(view_camera[0]) /2 - horizontalBuffer, camera_get_view_height(view_camera[0])/2 - verticleBuffer, camera_get_view_width(view_camera[0]) /2 + horizontalBuffer, camera_get_view_height(view_camera[0])/2 + verticleBuffer, true);
	
	
		
	// draw stack box
	draw_set_colour(c_white);
	draw_rectangle(camera_get_view_width(view_camera[0]) /2 - stackBoxXOffset, camera_get_view_height(view_camera[0])/2 - stackBoxYOffset - 20, camera_get_view_width(view_camera[0]) /2 + stackBoxXOffset, camera_get_view_height(view_camera[0])/2 + stackBoxYOffset - 20, false);
	draw_set_colour(global.colorThemeBorders);
	draw_rectangle(camera_get_view_width(view_camera[0]) /2 - stackBoxXOffset, camera_get_view_height(view_camera[0])/2 - stackBoxYOffset - 20, camera_get_view_width(view_camera[0]) /2 + stackBoxXOffset, camera_get_view_height(view_camera[0])/2 + stackBoxYOffset - 20, true);

	
	draw_set_colour(global.colorThemeText);
	draw_set_font(fnt_mainBold);
	draw_text(camera_get_view_width(view_camera[0])/2 - horizontalBuffer + 15, camera_get_view_height(view_camera[0])/2 - verticleBuffer + 15, string(game_display_name));
	
	draw_set_font(fnt_mainLarge1);

	// draw buttons for OK and Cancel
	draw_set_colour(global.colorThemeBG);
	draw_rectangle(camera_get_view_width(view_camera[0]) /2 - 100 - buttonXOffset, camera_get_view_height(view_camera[0])/2 + 180 - buttonYOffset, camera_get_view_width(view_camera[0]) /2 - 100 + buttonXOffset,camera_get_view_height(view_camera[0])/2 + 180 + buttonYOffset, false);
	draw_set_colour(global.colorThemeBorders);
	draw_rectangle(camera_get_view_width(view_camera[0]) /2 - 100 - buttonXOffset, camera_get_view_height(view_camera[0])/2 + 180 - buttonYOffset, camera_get_view_width(view_camera[0]) /2 - 100 + buttonXOffset,camera_get_view_height(view_camera[0])/2 + 180 + buttonYOffset, true);
	draw_set_colour(global.colorThemeBG);
	draw_rectangle(camera_get_view_width(view_camera[0]) /2 + 100 - buttonXOffset, camera_get_view_height(view_camera[0])/2 + 180 - buttonYOffset, camera_get_view_width(view_camera[0]) /2 + 100 + buttonXOffset,camera_get_view_height(view_camera[0])/2 + 180 + buttonYOffset, false);
	draw_set_colour(global.colorThemeBorders);
	draw_rectangle(camera_get_view_width(view_camera[0]) /2 + 100 - buttonXOffset, camera_get_view_height(view_camera[0])/2 + 180 - buttonYOffset, camera_get_view_width(view_camera[0]) /2 + 100 + buttonXOffset,camera_get_view_height(view_camera[0])/2 + 180 + buttonYOffset, true);
	draw_set_colour(global.colorThemeText);
	draw_set_font(fnt_mainLarge1);
	
	// draw button text
	draw_text(camera_get_view_width(view_camera[0]) /2 - 155, camera_get_view_height(view_camera[0])/2 + 180, "Show Stacks");
	draw_text(camera_get_view_width(view_camera[0]) /2 + 70, camera_get_view_height(view_camera[0])/2 + 180, "Cancel");
	

}



// ok button check
if (point_in_rectangle(mouse_x, mouse_y, camera_get_view_width(view_camera[0]) /2 - 100 - buttonXOffset, camera_get_view_height(view_camera[0])/2 + 180 - buttonYOffset, camera_get_view_width(view_camera[0]) /2 - 100 + buttonXOffset, camera_get_view_height(view_camera[0])/2 + 180 + buttonYOffset) && stackShowWindowActive){
		if (mouse_check_button_pressed(mb_left)) {
			// In here is where the stackShow initiation code will go
			obj_control.currentStackShowListPosition = 0;
			for(var stackShowListLoop = 0; stackShowListLoop < ds_grid_height(obj_chain.stackChainGrid); stackShowListLoop++) {
				// Currently adds Stacks into the list if they are within the filter
				if(ds_grid_get(obj_chain.stackChainGrid, obj_chain.chainGrid_colInFilter, stackShowListLoop)) {
					var currentStackID = ds_grid_get(obj_chain.stackChainGrid, obj_chain.chainGrid_colChainID, stackShowListLoop);
					ds_list_add(obj_control.stackShowList, currentStackID);	
				}
			}
	
			// Clear the Filter of all chains
			ds_grid_set_region(obj_chain.rezChainGrid, obj_chain.chainGrid_colInFilter, 0, obj_chain.chainGrid_colInFilter, ds_grid_height(obj_chain.rezChainGrid), false);
			ds_grid_set_region(obj_chain.trackChainGrid, obj_chain.chainGrid_colInFilter, 0, obj_chain.chainGrid_colInFilter, ds_grid_height(obj_chain.trackChainGrid), false);
			ds_grid_set_region(obj_chain.stackChainGrid, obj_chain.chainGrid_colInFilter, 0, obj_chain.chainGrid_colInFilter, ds_grid_height(obj_chain.stackChainGrid), false);
			instance_destroy();
			// Begin the show
			scr_stackShow();
		}
		
}

// cancel button check
if (point_in_rectangle(mouse_x, mouse_y, camera_get_view_width(view_camera[0]) /2 + 100 - buttonXOffset, camera_get_view_height(view_camera[0])/2 + 180 - buttonYOffset, camera_get_view_width(view_camera[0]) /2 + 100 + buttonXOffset, camera_get_view_height(view_camera[0])/2 + 180 + buttonYOffset) && stackShowWindowActive){
	if (mouse_check_button_pressed(mb_left)) {

		instance_destroy();
	}
		
}


// enter check
if ( keyboard_check_pressed(vk_enter) && stackShowWindowActive) {

	// In here is where the stackShow initiation code will go
	obj_control.currentStackShowListPosition = 0;
	for(var stackShowListLoop = 0; stackShowListLoop < ds_grid_height(obj_chain.stackChainGrid); stackShowListLoop++) {
		// Currently adds Stacks into the list if they are within the filter
		if(ds_grid_get(obj_chain.stackChainGrid, obj_chain.chainGrid_colInFilter, stackShowListLoop)) {
			var currentStackID = ds_grid_get(obj_chain.stackChainGrid, obj_chain.chainGrid_colChainID, stackShowListLoop);
			ds_list_add(obj_control.stackShowList, currentStackID);	
		}
	}
	
	// Clear the Filter of all chains
	ds_grid_set_region(obj_chain.rezChainGrid, obj_chain.chainGrid_colInFilter, 0, obj_chain.chainGrid_colInFilter, ds_grid_height(obj_chain.rezChainGrid), false);
	ds_grid_set_region(obj_chain.trackChainGrid, obj_chain.chainGrid_colInFilter, 0, obj_chain.chainGrid_colInFilter, ds_grid_height(obj_chain.trackChainGrid), false);
	ds_grid_set_region(obj_chain.stackChainGrid, obj_chain.chainGrid_colInFilter, 0, obj_chain.chainGrid_colInFilter, ds_grid_height(obj_chain.stackChainGrid), false);
	instance_destroy();
	// Begin the show
	scr_stackShow();
}

scr_drawStackShowWindow();

// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_drawConfirmStackCreate(){
	
	
	var verticleBuffer = 125;
	var horizontalBuffer = 250;
	var searchBarXOffset = 235;
	var searchBarYOffset = 20;
	var buttonXOffset = 50;
	var buttonYOffset = 25;


	var fullWindowWidth = camera_get_view_width(camera_get_active()) / 3;
	var fullWindowHeight = camera_get_view_height(camera_get_active()) / 6;
	
	// draw dialogue box BG
	var fullWindowX = (camera_get_view_width(camera_get_active()) / 2) - (fullWindowWidth / 2);
	var fullWindowY = (camera_get_view_height(camera_get_active()) / 2) - (fullWindowHeight / 2);
	draw_set_halign(fa_left);
	draw_set_colour(c_ltgray);
	draw_rectangle(fullWindowX, fullWindowY, fullWindowX + fullWindowWidth, fullWindowY + fullWindowHeight, false);
	draw_set_colour(global.colorThemeBorders);
	draw_rectangle(fullWindowX, fullWindowY, fullWindowX + fullWindowWidth, fullWindowY + fullWindowHeight, true);
	
	if (point_in_rectangle(mouse_x, mouse_y, fullWindowX, fullWindowY, fullWindowX + fullWindowWidth, fullWindowY + fullWindowHeight)) {
		obj_control.mouseOverUI = true;	
	}
	
	// draw caption
	scr_adaptFont(string(game_display_name),"L");
	var captionHeight = string_height("0") * 1.25;
	draw_set_color(global.colorThemeBG);
	draw_rectangle(fullWindowX, fullWindowY, fullWindowX + fullWindowWidth, fullWindowY + captionHeight, false);
	draw_set_color(global.colorThemeBorders);
	draw_rectangle(fullWindowX, fullWindowY, fullWindowX + fullWindowWidth, fullWindowY + captionHeight, true);
	draw_set_color(global.colorThemeText);
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_text(floor(fullWindowX + 10), floor(mean(fullWindowY, fullWindowY + captionHeight)), string(game_display_name));
	

	
	
	// get XY positions for buttons
	var buttonXOffset = 65;
	var buttonYOffset = 25;

	var yesButtonX1 = fullWindowX + (fullWindowWidth * 0.25) - buttonXOffset;
	var yesButtonY1 = fullWindowY + fullWindowHeight - captionHeight - buttonYOffset;
	var yesButtonX2 = fullWindowX + (fullWindowWidth * 0.25) + buttonXOffset;
	var yesButtonY2 = fullWindowY + fullWindowHeight - captionHeight + buttonYOffset;
	
	var noButtonX1 = fullWindowX + (fullWindowWidth * 0.5) - buttonXOffset;
	var noButtonY1 = fullWindowY + fullWindowHeight - captionHeight - buttonYOffset;
	var noButtonX2 = fullWindowX + (fullWindowWidth * 0.5) + buttonXOffset;
	var noButtonY2 = fullWindowY + fullWindowHeight - captionHeight + buttonYOffset;
	
	var cancelButtonX1 = fullWindowX + (fullWindowWidth * 0.75) - buttonXOffset;
	var cancelButtonY1 = fullWindowY + fullWindowHeight - captionHeight - buttonYOffset;
	var cancelButtonX2 = fullWindowX + (fullWindowWidth * 0.75) + buttonXOffset;
	var cancelButtonY2 = fullWindowY + fullWindowHeight - captionHeight + buttonYOffset;
	
	
	// yes button
	draw_set_colour(global.colorThemeBG);
	if (point_in_rectangle(mouse_x, mouse_y, yesButtonX1, yesButtonY1, yesButtonX2, yesButtonY2)) {
		draw_set_color(obj_control.c_ltblue);
		
		// click on yes button
		if (mouse_check_button_released(mb_left)) {
			
			// if they say yes, we will delete all of their stacks before creating new ones
			var stackChainGridHeight = ds_grid_height(obj_chain.stackChainGrid);
			var deleteChainsList = ds_list_create();
			for (var i = 0; i < stackChainGridHeight; i++) {
				var currentChainID = ds_grid_get(obj_chain.stackChainGrid, obj_chain.chainGrid_colChainID, i);
				ds_list_add(deleteChainsList, currentChainID);
			}
			var deleteChainsListSize = ds_list_size(deleteChainsList);
			for (var i = 0; i < deleteChainsListSize; i++) {
				var currentChainID = ds_list_find_value(deleteChainsList, i);
				scr_deleteChain(currentChainID);
			}
			ds_list_destroy(deleteChainsList);
			
			// now that all of the old stacks are deleted, we will make the new stacks
			if (createStacksRandom) {
				splitSave = true;
				alarm[1] = 1;
			}
			else if (createStacksTurn) {
				splitSave = true;
				alarm[4] = 1;
			}
			else if (createStacksSentence) {
				showEndNoteWindow = true;
			}
			createStacksRandom = false;
			createStacksTurn = false;
			createStacksSentence = false;
			confirmStackCreate = false;
		}
	}
	draw_rectangle(yesButtonX1, yesButtonY1, yesButtonX2, yesButtonY2, false);
	draw_set_colour(global.colorThemeBorders);
	draw_rectangle(yesButtonX1, yesButtonY1, yesButtonX2, yesButtonY2, true);
	
	
	// no button
	draw_set_colour(global.colorThemeBG);
	if (point_in_rectangle(mouse_x, mouse_y, noButtonX1, noButtonY1, noButtonX2, noButtonY2)) {
		draw_set_color(obj_control.c_ltblue);
		
		// click on no button
		if (mouse_check_button_released(mb_left)) {
			if (createStacksRandom) {
				splitSave = true;
				alarm[1] = 1;
			}
			else if (createStacksTurn) {
				splitSave = true;
				alarm[4] = 1;
			}
			else if (createStacksSentence) {
				showEndNoteWindow = true;
			}
			createStacksRandom = false;
			createStacksTurn = false;
			createStacksSentence = false;
			confirmStackCreate = false;
		}
	}
	draw_rectangle(noButtonX1, noButtonY1, noButtonX2, noButtonY2, false);
	draw_set_colour(global.colorThemeBorders);
	draw_rectangle(noButtonX1, noButtonY1, noButtonX2, noButtonY2, true);
	
	
	// cancel button
	draw_set_colour(global.colorThemeBG);
	if (point_in_rectangle(mouse_x, mouse_y, cancelButtonX1, cancelButtonY1, cancelButtonX2, cancelButtonY2)) {
		draw_set_color(obj_control.c_ltblue);
		
		// click on cancel button
		if (mouse_check_button_released(mb_left)) {
			createStacksRandom = false;
			createStacksTurn = false;
			createStacksSentence = false;
			confirmStackCreate = false;
		}
	}
	draw_rectangle(cancelButtonX1, cancelButtonY1, cancelButtonX2, cancelButtonY2, false);
	draw_set_colour(global.colorThemeBorders);
	draw_rectangle(cancelButtonX1, cancelButtonY1, cancelButtonX2, cancelButtonY2, true);
	
	
	// draw button text
	draw_set_colour(global.colorThemeText);
	scr_adaptFont(scr_get_translation("msg_yes"),"M");
	draw_set_halign(fa_center);
	draw_text(floor(mean(yesButtonX1, yesButtonX2)), floor((yesButtonY2 - yesButtonY1) /2 + yesButtonY1), scr_get_translation("msg_yes"));
	draw_text(floor(mean(noButtonX1, noButtonX2)), floor((noButtonY2 - noButtonY1) /2 + noButtonY1), scr_get_translation("msg_no"));
	draw_text(floor(mean(cancelButtonX1, cancelButtonX2)), floor((cancelButtonY2 - cancelButtonY1)/2 + yesButtonY1), scr_get_translation("msg_cancel"));
	

	// draw prompt text
	draw_set_colour(global.colorThemeText);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	var stackAmount = ds_grid_height(obj_chain.stackChainGrid);
	draw_text(floor(fullWindowX + 20), floor(fullWindowY + captionHeight + (string_height("0") / 2)), scr_get_translation("msg_stacks_created-1") + string(stackAmount) + scr_get_translation("msg_stacks_created-2"));
}

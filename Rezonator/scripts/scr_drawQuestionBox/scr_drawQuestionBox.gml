function scr_drawQuestionBox() {

	
	if (!questionWindowActive) {
		exit;
	}
	
	var verticleBuffer = 125;
	var horizontalBuffer = 250;
	//var searchBarXOffset = 235;
	//var searchBarYOffset = 20;
	var buttonXOffset = 50;
	var buttonYOffset = 25;
	
	



	obj_control.mouseoverPanelPane = true;
	obj_control.quickLinkAllowed = false;
	

	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_set_colour(global.colorThemeBG);
	draw_rectangle(camera_get_view_width(camera_get_active()) /2 - horizontalBuffer, camera_get_view_height(camera_get_active())/2 - verticleBuffer, camera_get_view_width(camera_get_active()) /2 + horizontalBuffer, camera_get_view_height(camera_get_active())/2 + verticleBuffer, false);
	draw_set_colour(global.colorThemePaneBG);
	if (global.colorTheme ==0) {
	draw_set_colour(c_ltgray);
	}
	// draw background UI
	draw_rectangle(camera_get_view_width(camera_get_active()) /2 - horizontalBuffer, camera_get_view_height(camera_get_active())/2 - verticleBuffer + 30, camera_get_view_width(camera_get_active()) /2 + horizontalBuffer, camera_get_view_height(camera_get_active())/2 + verticleBuffer, false);
	draw_set_colour(global.colorThemeBorders);
	draw_rectangle(camera_get_view_width(camera_get_active()) /2 - horizontalBuffer, camera_get_view_height(camera_get_active())/2 - verticleBuffer + 30, camera_get_view_width(camera_get_active()) /2 + horizontalBuffer, camera_get_view_height(camera_get_active())/2 + verticleBuffer, true);
	draw_rectangle(camera_get_view_width(camera_get_active()) /2 - horizontalBuffer, camera_get_view_height(camera_get_active())/2 - verticleBuffer, camera_get_view_width(camera_get_active()) /2 + horizontalBuffer, camera_get_view_height(camera_get_active())/2 + verticleBuffer, true);
	draw_set_colour(global.colorThemeText);
	
	scr_adaptFont(string(game_display_name), "S");
	draw_text(camera_get_view_width(camera_get_active())/2 - horizontalBuffer + 15, camera_get_view_height(camera_get_active())/2 - verticleBuffer + 15, string(game_display_name));
	
		

	// draw buttons for OK and Cancel
	draw_set_colour(global.colorThemeBG);
	draw_rectangle(camera_get_view_width(camera_get_active()) /2 + 40 - buttonXOffset, camera_get_view_height(camera_get_active())/2 + 75 - buttonYOffset, camera_get_view_width(camera_get_active()) /2 + 50 + buttonXOffset,camera_get_view_height(camera_get_active())/2 + 75 + buttonYOffset, false);
	draw_set_colour(global.colorThemeBorders);
	draw_rectangle(camera_get_view_width(camera_get_active()) /2 + 40 - buttonXOffset, camera_get_view_height(camera_get_active())/2 + 75 - buttonYOffset, camera_get_view_width(camera_get_active()) /2 + 50 + buttonXOffset,camera_get_view_height(camera_get_active())/2 + 75 + buttonYOffset, true);
	draw_set_colour(global.colorThemeBG);
	draw_rectangle(camera_get_view_width(camera_get_active()) /2 + 180 - buttonXOffset, camera_get_view_height(camera_get_active())/2 + 75 - buttonYOffset, camera_get_view_width(camera_get_active()) /2 + 175 + buttonXOffset,camera_get_view_height(camera_get_active())/2 + 75 + buttonYOffset, false);
	draw_set_colour(global.colorThemeBorders);
	draw_rectangle(camera_get_view_width(camera_get_active()) /2 + 180 - buttonXOffset, camera_get_view_height(camera_get_active())/2 + 75 - buttonYOffset, camera_get_view_width(camera_get_active()) /2 + 175 + buttonXOffset,camera_get_view_height(camera_get_active())/2 + 75 + buttonYOffset, true);
	draw_set_colour(global.colorThemeText);
	scr_adaptFont(scr_get_translation("msg_yes"), "M");
	
	// draw button text
	draw_text(camera_get_view_width(camera_get_active()) /2 + 30, camera_get_view_height(camera_get_active())/2 + 75, scr_get_translation("msg_yes"));
	draw_text(camera_get_view_width(camera_get_active()) /2 + 150, camera_get_view_height(camera_get_active())/2 + 75, scr_get_translation("msg_no"));
		

	
	
	
	if(clearAllStacks) {
		draw_text(camera_get_view_width(camera_get_active())/2 - horizontalBuffer + 25, camera_get_view_height(camera_get_active())/2 - verticleBuffer + 75, scr_get_translation("msg_warning_clear_stacks"));
	}
	if(clearAllRez) {
		draw_text(camera_get_view_width(camera_get_active())/2 - horizontalBuffer + 25, camera_get_view_height(camera_get_active())/2 - verticleBuffer + 75, scr_get_translation("msg_warning_clear_rez"));
	}
	if(clearAllTracks) {
		draw_text(camera_get_view_width(camera_get_active())/2 - horizontalBuffer + 25, camera_get_view_height(camera_get_active())/2 - verticleBuffer + 75, scr_get_translation("msg_warning_clear_track"));
	}
	if(clearAllLinks) {
		draw_text(camera_get_view_width(camera_get_active())/2 - horizontalBuffer + 25, camera_get_view_height(camera_get_active())/2 - verticleBuffer + 75, scr_get_translation("msg_warning_clear_chains"));
	}
	if (clearChain) {
		draw_text(camera_get_view_width(camera_get_active())/2 - horizontalBuffer + 25, camera_get_view_height(camera_get_active())/2 - verticleBuffer + 75, scr_get_translation("msg_warning_clear_focused_chain"));
	}
	if (clearShow) {
		draw_text(camera_get_view_width(camera_get_active())/2 - horizontalBuffer + 25, camera_get_view_height(camera_get_active())/2 - verticleBuffer + 75, scr_get_translation("You are about to delete this show"));
	}
	if(layerLink) {
		draw_text(camera_get_view_width(camera_get_active())/2 - horizontalBuffer + 25, camera_get_view_height(camera_get_active())/2 - verticleBuffer + 75, scr_get_translation("masg_warning_layer_link"));
	}
	if(combineChains) {
		if (obj_control.stackMerged) {
			draw_text(camera_get_view_width(camera_get_active())/2 - horizontalBuffer + 25, camera_get_view_height(camera_get_active())/2 - verticleBuffer + 75, scr_get_translation("msg_warning_merge_stacks"));
		}
		else{
			draw_text(camera_get_view_width(camera_get_active())/2 - horizontalBuffer + 25, camera_get_view_height(camera_get_active())/2 - verticleBuffer + 75, scr_get_translation("msg_warning_merge_chains"));
		}
	}
	if (removeTagToken || removeTagUnit || removeTagEntry || removeTagChain) {
		draw_text(camera_get_view_width(camera_get_active())/2 - horizontalBuffer + 25, camera_get_view_height(camera_get_active())/2 - verticleBuffer + 75, "This will permanently remove the option to mark tag " + string(stringToBeRemoved));
	}
	if (removeFieldToken || removeFieldUnit || removeFieldEntry || removeFieldChain || removeFieldChunk) {
		draw_text(camera_get_view_width(camera_get_active())/2 - horizontalBuffer + 25, camera_get_view_height(camera_get_active())/2 - verticleBuffer + 75, "This will permanently remove the tag set for Field:  " + string(stringToBeRemoved));
	}
	if (removeSearch) {
		var searchSubMap = global.searchMap[?searchToBeRemoved];
		var searchTermList = searchSubMap[?"searchTermList"];
		draw_text(camera_get_view_width(camera_get_active())/2 - horizontalBuffer + 25, camera_get_view_height(camera_get_active())/2 - verticleBuffer + 75, "This will permanently remove the Search :  " + scr_getStringOfList(searchTermList));
	}

	draw_text(floor(camera_get_view_width(camera_get_active())/2 - horizontalBuffer + 25), floor(camera_get_view_height(camera_get_active())/2 - verticleBuffer + 105), scr_get_translation("msg_ask_sure"));





	var mouseoverOk = point_in_rectangle(mouse_x, mouse_y, camera_get_view_width(camera_get_active()) /2 + 50 - buttonXOffset, camera_get_view_height(camera_get_active())/2 + 75 - buttonYOffset, camera_get_view_width(camera_get_active()) /2 + 50 + buttonXOffset, camera_get_view_height(camera_get_active())/2 + 75 + buttonYOffset);
	var clickOk = mouseoverOk && mouse_check_button_released(mb_left);

	// ok button check
	if (clickOk || keyboard_check_pressed(vk_enter)) {

		obj_control.alarm[11] = 60;

		if (clearAllStacks || clearAllLinks) {
				
			// delete all stack chains!
			show_debug_message("scr_drawQuestionBox() ... clearAllStacks");
			var chainList = ds_map_find_value(global.nodeMap, "stackChainList");
			while (ds_list_size(chainList) > 0) {
				var currentChainID = ds_list_find_value(chainList, 0);
				scr_deleteChain(currentChainID);
				scr_deleteFromList(chainList, currentChainID); // safety check to eliminate infinite loop
			}
		}
		if (clearAllRez || clearAllLinks) {
				
			// delete all rez chains!!
			show_debug_message("scr_drawQuestionBox() ... clearAllRez");
			var chainList = ds_map_find_value(global.nodeMap, "rezChainList");
			while (ds_list_size(chainList) > 0) {
				var currentChainID = ds_list_find_value(chainList, 0);
				scr_deleteChain(currentChainID);
				scr_deleteFromList(chainList, currentChainID); // safety check to eliminate infinite loop
			}
		}
		if (clearAllTracks || clearAllLinks) {
				
			// delete all track chains!!
			show_debug_message("scr_drawQuestionBox() ... clearAllTracks");
			var chainList = ds_map_find_value(global.nodeMap, "trackChainList");
			while (ds_list_size(chainList) > 0) {
				var currentChainID = ds_list_find_value(chainList, 0);
				scr_deleteChain(currentChainID);
				scr_deleteFromList(chainList, currentChainID); // safety check to eliminate infinite loop
			}
		}
		
		if (removeTagToken) scr_removeFromTagSetOptions(string(stringToBeRemoved), "token");
		if (removeTagUnit) scr_removeFromTagSetOptions(string(stringToBeRemoved), "unit");
		if (removeTagEntry) scr_removeFromTagSetOptions(string(stringToBeRemoved), "entry");
		if (removeTagChain) scr_removeFromTagSetOptions(string(stringToBeRemoved), "chain");
		if (removeTagChunk) scr_removeFromTagSetOptions(string(stringToBeRemoved), "chunk");
		
		if (removeFieldToken || removeFieldUnit || removeFieldEntry || removeFieldChain || removeFieldChunk) {
			// delete the field
			scr_deleteField(stringToBeRemoved);
				
			// deselect fields
			if (removeFieldToken) with (obj_panelPane) functionField_tokenFieldSelected = "";
			if (removeFieldEntry) with (obj_panelPane) functionField_entryFieldSelected = "";
			if (removeFieldUnit) with (obj_panelPane) functionField_unitFieldSelected = "";
			if (removeFieldChain) with (obj_panelPane) functionField_chainFieldSelected = "";
			if (removeFieldChunk) with (obj_panelPane) functionField_chunkFieldSelected = "";
		}
		
		
			
		

		if (clearChain) {
			scr_deleteChain(obj_control.selectedChainID);
		}
		if (clearShow) {
			scr_deleteShow(obj_control.selectedChainID);
		}
		if (removeSearch) {
			scr_removeSearch(searchToBeRemoved);
		}
		
			
		if(layerLink) {
			
			// Take the saved wordID & click on it
			obj_control.layerLinkAllow = true;
			with(obj_chain) {
				alarm[8] = 2;	
			}
		}
		
		if(combineChains){
			scr_combineChains(obj_control.combineChainsFocused, obj_control.combineChainsSelected);
		}
		
		scr_closeQuestionBoxVariables();
		instance_destroy();


	}
	
	var mouseoverCancel = point_in_rectangle(mouse_x, mouse_y,camera_get_view_width(camera_get_active()) /2 + 180 - buttonXOffset, camera_get_view_height(camera_get_active())/2 + 75 - buttonYOffset, camera_get_view_width(camera_get_active()) /2 + 175 + buttonXOffset,camera_get_view_height(camera_get_active())/2 + 75 + buttonYOffset);
	var clickCancel = mouseoverCancel && mouse_check_button_released(mb_left);

	// cancel button check
	if (clickCancel || keyboard_check_pressed(vk_escape)) {
		obj_control.alarm[11] = 60;
			
		scr_closeQuestionBoxVariables();
		instance_destroy();
	}


}

function scr_setSpeakerLabelColWidth() {
	
	// if we're not showing speaker name, don't show speaker name rect!
	if (obj_control.showSpeakerName) {
		if (ds_list_size(obj_control.speakerLabelColXList) == 1) {
			var prevColX = obj_control.speakerLabelColXList[| 0];
			ds_list_add(obj_control.speakerLabelColXList, prevColX * 2);
		}
	}
	else {
		while (ds_list_size(obj_control.speakerLabelColXList) > 1) {
			ds_list_delete(obj_control.speakerLabelColXList, 1);
		}
	}


	if (object_index != obj_control) {
		exit;
	}
	
	var camHeight = camera_get_view_height(camera_get_active());
	var minColWidth = string_width("00000");
	var maxColWidth = camera_get_view_width(camera_get_active()) * 0.16;
	var sectionMouseWidth = 3;
	
	// reset variables when not holding left click
	if (!mouse_check_button(mb_left)) {
		speakerLabelColXHolding = -1;
		speakerLabelColXHoldingPrev = 0;
		speakerLabelColXHoldingDiff = 0;
		ds_list_clear(speakerLabelColPrevList);
	}
	
	mouseoverSpeakerLabelWidth = false;
	
	var speakerLabelColXListSize = ds_list_size(speakerLabelColXList);
	for (var i = 0; i < speakerLabelColXListSize; i++) {
		
		var colX = speakerLabelColXList[| i];
		var mouseoverColX = point_in_rectangle(mouse_x, mouse_y, colX - sectionMouseWidth, wordTopMargin, colX + sectionMouseWidth, camHeight) && !instance_exists(obj_dropDown);
		
		if (mouseoverColX) {
			mouseoverSpeakerLabelWidth = true;
			scr_windowSetCursor(cr_size_we);
			if (mouse_check_button_pressed(mb_left)) {
				speakerLabelColXHolding = i;
				speakerLabelColXHoldingPrev = colX;
				ds_list_copy(speakerLabelColPrevList, speakerLabelColXList);
			}
		}
		
		// if we are dragging this column
		if (speakerLabelColXHolding == i) {
			scr_windowSetCursor(cr_size_we);
			global.delayInput = 5;
			
			var newColX = max(mouse_x, minColWidth);
		
			// clamp column x values
			if (speakerLabelColXHolding >= 0) {
				var prevColX = 0;
				if (speakerLabelColXHolding > 0) {
					prevColX = ds_list_find_value(speakerLabelColXList, i - 1);
				}
				var minColX = prevColX + minColWidth;
				var maxColX = prevColX + maxColWidth;
				newColX = clamp(newColX, minColX, maxColX);
			}
		
			ds_list_set(speakerLabelColXList, i, newColX);
			speakerLabelColXHoldingDiff = newColX - speakerLabelColXHoldingPrev;
		
			// set X positions for all following columns
			for (var j = i + 1; j < speakerLabelColXListSize; j++) {
				var currentNewColX = ds_list_find_value(speakerLabelColPrevList, j) + speakerLabelColXHoldingDiff;
				ds_list_set(speakerLabelColXList, j, currentNewColX);
			}
		}
	}

}

function scr_setSpeakerLabelColWidth() {
	/*
		scr_setSpeakerLabelColWidth();
	
		Last Updated: 2019-12-27
	
		Called from: obj_control
	
		Purpose: Adapt the Speaker Label width based on the font size of the Speaker Name
	
		Mechanism: Based off of a sample text, dynamically change the width of the each Speaker Label
	
		Author: Terry DuBois
	*/

	//if (live_call()) return live_result;

	if (object_index != obj_control) {
		exit;
	}

	if ((not mouse_check_button(mb_left)) or speakerLabelColXHolding >= 4) {
		if (speakerLabelColXHolding > -1) {
			wordLeftMargin = ds_list_find_value(obj_control.speakerLabelColXList, ds_list_size(obj_control.speakerLabelColXList) - 1) + 20;
			wordLeftMarginDest = wordLeftMargin;
			obj_control.speakerLabelHoldingDelay = true;
			with(obj_alarm) {
				alarm[2] = 5;	
			}
		}
		speakerLabelColXHolding = -1;
		speakerLabelColXHoldingPrev = 0;
		speakerLabelColXHoldingDiff = 0;
		ds_list_clear(speakerLabelColPrevList);
	}



	draw_set_font(global.fontMain);
	var minColWidth = string_width("AAAAA");
	var maxColWidth = camera_get_view_width(camera_get_active()) / 6;
	var speakerLabelColXListSize = ds_list_size(speakerLabelColXList);
	for (var i = 0; i < speakerLabelColXListSize - 1; i++) {
		if (ds_grid_height(global.fileLineRipGrid) < 2 and i == 0) {
			continue;
		}
		var colX1 = ds_list_find_value(speakerLabelColXList, i);
		var colX2 = ds_list_find_value(speakerLabelColXList, i + 1);
		colX2 = max(colX2, colX1 + minColWidth);
		ds_list_set(speakerLabelColXList, i + 1, colX2);
	}


	// set discorse column to be on/off
	if (ds_grid_height(global.fileLineRipGrid) < 2) {
		ds_list_set(speakerLabelColXList, 0, 0);
		ds_list_set(speakerLabelColXList, 1, 0);
	}
	else if (ds_list_find_value(speakerLabelColXList, 1) < minColWidth) {
		ds_list_set(speakerLabelColXList, 1, 100);
	}





	for (var i = 1; i < speakerLabelColXListSize; i++) {
	
		var colX = ds_list_find_value(speakerLabelColXList, i);
	
		// if this is the speaker column and there's no speaker, set width to 0
		if (i == speakerLabelColXListSize - 1 && !obj_control.showParticipantName) {
			//ds_list_set(speakerLabelColXList, i, );
		}

	
		// clicking to drag size of speakerLabelCol with mouse
		if (point_in_rectangle(mouse_x, mouse_y, colX - 3, wordTopMargin, colX + 3, camera_get_view_height(camera_get_active())) && !instance_exists(obj_dialogueBox) && !instance_exists(obj_dropDown)) {
			if ((ds_grid_height(global.fileLineRipGrid) < 2 and i > 1) or (ds_grid_height(global.fileLineRipGrid) > 1)) {
		
				window_set_cursor(cr_size_we);
				if (mouse_check_button_pressed(mb_left) and speakerLabelColXHolding == -1) {
					speakerLabelColXHoldingPrev = colX;
					speakerLabelColXHolding = i;
					ds_list_clear(speakerLabelColPrevList);
					ds_list_copy(speakerLabelColPrevList, speakerLabelColXList);
				}
			}
		}
	
	
		// dragging size of speakerLabelCol with mouse
		if (speakerLabelColXHolding == i)  {
			window_set_cursor(cr_size_we);
			draw_set_alpha(0.8);
		
			var newColX = max(mouse_x, minColWidth);
		
			// put limit on how small a column can be
			if (speakerLabelColXHolding > 0) {
				var prevColX = ds_list_find_value(speakerLabelColXList, i - 1);
				//newColX = max(newColX, prevColX + minColWidth);
				var minColX = prevColX + minColWidth;
				var maxColX = prevColX + maxColWidth;
			
				newColX = clamp(newColX, minColX, maxColX);
			}
		
			/*
			if (ds_list_find_value(speakerLabelColXList, ds_list_size(speakerLabelColXList) - 1) > 800) {
				newColX = min(newColX, ds_list_find_value(speakerLabelColXList, i));
			}
			*/
		
			ds_list_set(speakerLabelColXList, i, newColX);
			speakerLabelColXHoldingDiff = newColX - speakerLabelColXHoldingPrev;
		
			// set X positions for all following columns
			for (var j = i + 1; j < speakerLabelColXListSize; j++) {

				var currentNewColX = ds_list_find_value(speakerLabelColPrevList, j) + speakerLabelColXHoldingDiff;
				ds_list_set(speakerLabelColXList, j, currentNewColX);
			}
		}
	
	
	}
	

	draw_set_alpha(1);


}

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
for (var i = 0; i < ds_list_size(speakerLabelColXList) - 1; i++) {
	if (ds_grid_height(global.fileLineRipGrid) < 2 and i == 0) {
		continue;
	}
	var colX1 = ds_list_find_value(speakerLabelColXList, i);
	var colX2 = ds_list_find_value(speakerLabelColXList, i + 1);
	colX2 = max(colX2, colX1 + minColWidth);
	ds_list_set(speakerLabelColXList, i + 1, colX2);
}

if (ds_grid_height(global.fileLineRipGrid) < 2) {
	ds_list_set(speakerLabelColXList, 0, 0);
	ds_list_set(speakerLabelColXList, 1, 0);
}
else if (ds_list_find_value(speakerLabelColXList, 1) < minColWidth) {
	ds_list_set(speakerLabelColXList, 1, 100);
}





for (var i = 1; i < ds_list_size(speakerLabelColXList); i++) {
	var colX = ds_list_find_value(speakerLabelColXList, i);
	
	if (point_in_rectangle(mouse_x, mouse_y, colX - 3, wordTopMargin, colX + 3, camera_get_view_height(view_camera[0])) and not instance_exists(obj_dialogueBox)) {
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
	
	
	if (speakerLabelColXHolding == i) {
		window_set_cursor(cr_size_we);
		
		draw_set_alpha(0.8);
		
		var newColX = clamp(mouse_x, minColWidth, 800);
		
		// put limit on how small a column can be
		if (speakerLabelColXHolding > 0) {
			var prevColX = ds_list_find_value(speakerLabelColXList, i - 1);
			newColX = max(newColX, prevColX + minColWidth);
		}
		
		if (ds_list_find_value(speakerLabelColXList, ds_list_size(speakerLabelColXList) - 1) > 800) {
			newColX = min(newColX, ds_list_find_value(speakerLabelColXList, i));
		}
		
		ds_list_set(speakerLabelColXList, i, newColX);
		speakerLabelColXHoldingDiff = newColX - speakerLabelColXHoldingPrev;
		
		// set X positions for all following columns
		for (var j = i + 1; j < ds_list_size(speakerLabelColXList); j++) {

			var currentNewColX = ds_list_find_value(speakerLabelColPrevList, j) + speakerLabelColXHoldingDiff;
			ds_list_set(speakerLabelColXList, j, currentNewColX);
		}
	}
	
	
}
	

draw_set_alpha(1);
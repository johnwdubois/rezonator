var unitID = argument0;
var currentDiscoID = argument1;
var currentLineNumberLabel = argument2;
var participantName = argument3;
var participantColor = argument4;
var speakerLabelTextBuffer = argument5;

// draw speaker label parts
for (var i = 0; i < 3; i++) {
	if (!obj_control.showLineNumber and i != 2) {
		continue;
	}
		
	var speakerLabelCurrentColX1 = ds_list_find_value(obj_control.speakerLabelColXList, i);
	var speakerLabelCurrentColY1 = speakerRectY1;
	var speakerLabelCurrentColX2 = ds_list_find_value(obj_control.speakerLabelColXList, i + 1);
	var speakerLabelCurrentColY2 = speakerRectY2;
		
		
	draw_set_color((i == 2) ? participantColor: c_ltblue);
	draw_rectangle(speakerLabelCurrentColX1, speakerLabelCurrentColY1, speakerLabelCurrentColX2, speakerLabelCurrentColY2, false);
	draw_set_color(global.colorThemeBG);
	draw_rectangle(speakerLabelCurrentColX1, speakerLabelCurrentColY1, speakerLabelCurrentColX2, speakerLabelCurrentColY2, true);
		
	var speakerLabelCurrentColStr = "";
	if (i == 0 and currentDiscoID != undefined) {
		speakerLabelCurrentColStr = (ds_grid_height(global.fileLineRipGrid) < 2) ? "" : string(currentDiscoID);
	}
	else if (i == 1 and currentLineNumberLabel != undefined) {
		speakerLabelCurrentColStr = string(currentLineNumberLabel);
	}
		
	if (i == 2 and participantName != undefined) {
		speakerLabelCurrentColStr = string(participantName);
		
		var speakerNameColWidth = ds_list_find_value(obj_control.speakerLabelColXList, 3) - ds_list_find_value(obj_control.speakerLabelColXList, 2);
		var cutoffs = 0;
		while (string_width(speakerLabelCurrentColStr + "... ") > speakerNameColWidth and cutoffs < 100) {
			speakerLabelCurrentColStr = string_delete(speakerLabelCurrentColStr, string_length(speakerLabelCurrentColStr), 1);
			cutoffs++;
		}
		if (cutoffs > 0) {
			speakerLabelCurrentColStr += "... ";
		}
	}
		
	if (point_in_rectangle(mouse_x, mouse_y,speakerLabelCurrentColX1, speakerLabelCurrentColY1, speakerLabelCurrentColX2, speakerLabelCurrentColY2)
	and not instance_exists(obj_dialogueBox)  and not instance_exists(obj_dropDown) and !obj_control.mouseoverPanelPane) {
		obj_control.mouseoverSpeakerLabel = true;
			
		if(mouse_check_button_pressed(mb_right)) {
			//show_message("clicked here" + string(drawLineLoop));
				
			var dropDownOptionList = ds_list_create();
			
			obj_control.swapLinePos1 = unitID;

			ds_list_add(dropDownOptionList, "Swap", "Shuffle", "Toggle Line #", "Reset Order", "Tag");

			if (ds_list_size(dropDownOptionList) > 0 and obj_control.ableToCreateDropDown) {
				var dropDownInst = instance_create_depth(mouse_x, mouse_y, -999, obj_dropDown);
				dropDownInst.optionList = dropDownOptionList;
				dropDownInst.optionListType = 3;
					
				obj_control.ableToCreateDropDown = false;
				obj_control.alarm[0] = 2;
			}
		}
			
	}
	draw_set_color(global.colorThemeText);
	draw_text(speakerLabelCurrentColX1 + speakerLabelTextBuffer, mean(speakerLabelCurrentColY1, speakerLabelCurrentColY2), speakerLabelCurrentColStr);
		
}
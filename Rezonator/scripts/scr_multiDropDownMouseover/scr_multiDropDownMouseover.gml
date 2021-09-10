function scr_multiDropDownMouseover() {

	// this function makes it so that only one dropDown can be moused over at a time
	var dropDownAmount = instance_number(obj_dropDown);
	if (dropDownAmount > 1) {
		var mouseoverDropDownList = ds_list_create();
		
		// loop over every dropDown on screen, find any that are being moused over
		for (var i = 0; i < dropDownAmount; i++) {
			var currentDropDown = instance_find(obj_dropDown, i);
			var x1 = currentDropDown.x;
			var y1 = currentDropDown.y;
			var x2 = x1 + currentDropDown.windowWidth;
			var y2 = y1 + currentDropDown.windowHeight;
			if (point_in_rectangle(mouse_x, mouse_y, x1, y1, x2, y2)) {
				ds_list_add(mouseoverDropDownList, currentDropDown);
			}
		}
	
		// set only the "last" dropDown to be able to be moused over
		var mouseoverDropDownListSize = ds_list_size(mouseoverDropDownList);
		for (var i = 0; i < mouseoverDropDownListSize; i++) {
			var currentDropDown = mouseoverDropDownList[| i];
			currentDropDown.multiDropDownCancel = (i < mouseoverDropDownListSize - 1);
		}

		ds_list_destroy(mouseoverDropDownList);
	}
	else if (dropDownAmount == 1) {
		
		// if there's only 1 dropDown on screen, it's good
		with (obj_dropDown) multiDropDownCancel = false;
	}


}

function scr_justifyWords() {
	//Change the justification of the discourse text, either to a grid-like structure or to standard English left-justified

	if (obj_control.shapeStartText == true) {
		obj_control.shapeStartText = false;
		//obj_control.shape = obj_control.shapeBlock;
	}
	/*if (obj_control.shape == obj_control.shapeBlock) {
		obj_control.shape = obj_control.shapeText;
	}
	else {
		obj_control.shape = obj_control.shapeBlock;
	}*/
	
	if(++obj_control.justifyLoop = ds_grid_height(obj_control.justifyGrid)) {
		obj_control.justifyLoop = 0;	
	}
	obj_control.shape = ds_grid_get(obj_control.justifyGrid, obj_control.justifyGridColShape, obj_control.justifyLoop);
	obj_control.justify = ds_grid_get(obj_control.justifyGrid, obj_control.justifyGridColJustify, obj_control.justifyLoop);
	

}

function scr_setIDandFieldToChange(ID, field, type){
	
	if (type == "unit") {
		obj_control.unitToChange = ID;
		obj_control.unitFieldToChange = field;
	}
	else if( type == "chain") {
		obj_control.tokenToChange = ID;
		obj_control.tokenFieldToChange = field;
	}
	else {
		obj_control.tokenToChange = ID;
		obj_control.tokenFieldToChange = field;
	}
	
	show_debug_message("scr_setIDandFieldToChange, id: " + string(ID) + ", field: " + string(field) + ", type: " + string(type));

}
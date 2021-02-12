function scr_chainContents1ToManyOptions(optionSelected) {
	
	var fieldList = obj_control.chainContents1toManyFieldList;
	var fieldToChange = obj_control.chainContents1ToManyFieldToChange;
	
	ds_list_set(fieldList, fieldToChange, optionSelected);

}

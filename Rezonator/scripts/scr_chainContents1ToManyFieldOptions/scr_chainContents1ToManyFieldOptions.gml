function scr_chainContents1ToManyFieldOptions(optionSelected) {
	
	var fieldList = obj_control.chain1toManyColFieldList;
	var fieldToChange = obj_control.chain1ToManyColFieldToChange;
	
	ds_list_set(fieldList, fieldToChange, optionSelected);

}

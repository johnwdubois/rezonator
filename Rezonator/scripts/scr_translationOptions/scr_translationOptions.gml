

function scr_translationOptions(optionSelected){
	if(ds_list_find_index(obj_control.unitFieldList,optionSelected) != -1){
		global.currentTranslation = optionSelected;
	}
	instance_destroy(obj_dropDown);
}
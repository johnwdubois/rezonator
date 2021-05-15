// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_translationOptions(optionSelected){
	if(ds_list_find_index(obj_control.unitFieldList,optionSelected) != -1){
		global.currentTranslation = optionSelected;
	}
	instance_destroy(obj_dropDown);
}
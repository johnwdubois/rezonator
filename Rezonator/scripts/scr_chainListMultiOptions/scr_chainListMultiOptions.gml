// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_chainListMultiOptions(optionSelected){
	
	var optionIndex = ds_list_find_index(optionList, optionSelected);
	
	if (optionSelected == "option_add-to-show") {
		var dropDownOptionList = ds_list_create();
		var showList = global.nodeMap[? "showList"];
		ds_list_copy(dropDownOptionList, showList);
		ds_list_insert(dropDownOptionList, 0, "option_create-show");
		with (obj_dropDown) if (level > 1) instance_destroy();
		scr_createDropDown(obj_dropDown.x + obj_dropDown.windowWidth, obj_dropDown.y + (obj_dropDown.optionSpacing * optionIndex), dropDownOptionList, global.optionListTypeSelectShow);
	}

}
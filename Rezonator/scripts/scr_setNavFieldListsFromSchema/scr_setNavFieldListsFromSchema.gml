// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_setNavFieldListsFromSchema(){
	
	show_debug_message("scr_setNavFieldListsFromSchema, schemaNavTokenFieldList: " + scr_getStringOfList(global.schemaNavTokenFieldList));
	show_debug_message("scr_setNavFieldListsFromSchema, schemaNavUnitFieldList: " + scr_getStringOfList(global.schemaNavUnitFieldList));
	
	if (!instance_exists(obj_control)) exit;
	
	scr_setNavFieldListsFromSchemaPart(global.schemaNavTokenFieldList, obj_control.tokenFieldList, obj_control.navTokenFieldList);
	scr_setNavFieldListsFromSchemaPart(global.schemaNavUnitFieldList, obj_control.unitFieldList, obj_control.navUnitFieldList);

	
}
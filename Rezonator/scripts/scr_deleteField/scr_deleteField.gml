// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_deleteField(fieldName){
	
	if(chainViewOneToMany){
		var fieldList = obj_control.tokenFieldList;
		var navWindowList = obj_control.navTokenFieldList;
	}
	else{
		var fieldList = obj_control.unitFieldList;
		var navWindowList = obj_control.navUnitFieldList;
	}
	
	var fieldListSize = ds_list_size(fieldList);


	scr_deleteFromList(fieldList, fieldName);
	
	var placeInNavList = ds_list_find_index(navWindowList, fieldName);
	if( placeInNavList != -1){
		var i = 0;
		var isInNavList = (ds_list_find_index(navWindowList, fieldList[|i]) == -1);
		while (!isInNavList and i < fieldListSize-1){
			i++;
			isInNavList = (ds_list_find_index(navWindowList, fieldList[|i]) == -1);
	
		}
		if(fieldList[|i] != undefined){
			ds_list_replace(navWindowList,placeInNavList, fieldList[|i] );
		}
		else{
			ds_list_delete(navWindowList,placeInNavList);
		}
	}
	


}
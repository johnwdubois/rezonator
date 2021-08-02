// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_deleteField(fieldName){

	// determine the list that this field is in
	var chainViewOneToMany = obj_panelPane.chainViewOneToMany;
	var fieldPaneSwitchButton = obj_panelPane.fieldPaneSwitchButton;
	var fieldList = -1;
	var navWindowList1 = -1;
	var navWindowList2 = -1;
	var navWindowList3 = -1;
	
	
	if (chainViewOneToMany && fieldPaneSwitchButton == obj_panelPane.fieldPaneDocMode) {
		fieldList = obj_control.tokenFieldList;
		navWindowList1 = obj_control.navTokenFieldList;
		var tokenTagMap =  global.nodeMap[? "tokenTagMap"];
		var fieldSubMap = tokenTagMap[?fieldName];
		scr_deleteFromList(fieldSubMap[? "targetList"], "Token");
	}
	else if (!chainViewOneToMany && fieldPaneSwitchButton == obj_panelPane.fieldPaneDocMode) {
		fieldList = obj_control.unitFieldList;
		navWindowList1 = obj_control.navUnitFieldList;
	}
	else if (chainViewOneToMany && fieldPaneSwitchButton == obj_panelPane.fieldPaneChainMode) {
		fieldList = global.chainEntryFieldList;
		navWindowList1 = obj_control.chain1toManyColFieldListRez;
		navWindowList2 = obj_control.chain1toManyColFieldListTrack;
		navWindowList3 = obj_control.chain1toManyColFieldListStack;
	}
	else if (!chainViewOneToMany && fieldPaneSwitchButton == obj_panelPane.fieldPaneChainMode) {
		fieldList = global.chainFieldList;
		navWindowList1 = obj_control.chain1to1ColFieldListRez;
		navWindowList2 = obj_control.chain1to1ColFieldListTrack;
		navWindowList3 = obj_control.chain1to1ColFieldListStack;
	}
	else if (fieldPaneSwitchButton == obj_panelPane.fieldPaneChunkMode) {
		fieldList = obj_control.chunkFieldList;
		navWindowList1 = obj_control.navChunkFieldList;
		var tokenTagMap =  global.nodeMap[? "tokenTagMap"];
		var fieldSubMap = tokenTagMap[?fieldName];
		scr_deleteFromList(fieldSubMap[? "targetList"], "Chunk");
	}
	else if (fieldPaneSwitchButton == obj_panelPane.fieldPaneLinkMode) {
		fieldList = global.linkFieldList;
		var tokenTagMap =  global.nodeMap[? "linkTagMap"];
	}

	if(!scr_isNumericAndExists(fieldList, ds_type_list)){exit;}
	
	// delete field from field list
	scr_deleteFromList(fieldList, fieldName);
	
	// delete from nav field list
	scr_deleteFieldFromNavWindowList(navWindowList1, fieldList, fieldName);
	scr_deleteFieldFromNavWindowList(navWindowList2, fieldList, fieldName);
	scr_deleteFieldFromNavWindowList(navWindowList3, fieldList, fieldName);
	

}
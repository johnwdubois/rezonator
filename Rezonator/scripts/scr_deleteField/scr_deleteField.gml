

function scr_deleteField(fieldName){

	// determine the list that this field is in
	var chainViewOneToMany = obj_panelPane.chainViewOneToMany;
	var fieldPaneSwitchButton = obj_panelPane.fieldPaneSwitchButton;
	var fieldList = -1;
	var navWindowList1 = -1;
	var navWindowList2 = -1;
	var navWindowList3 = -1;
	var deletingTokenField = (fieldPaneSwitchButton == obj_panelPane.fieldPaneTokenMode);
	var deletingUnitField = (fieldPaneSwitchButton == obj_panelPane.fieldPaneUnitMode);
	var deletingEntryField = (fieldPaneSwitchButton == obj_panelPane.fieldPaneEntryMode);
	var deletingChainField = (fieldPaneSwitchButton == obj_panelPane.fieldPaneChainMode);
	var deletingChunkField = (fieldPaneSwitchButton == obj_panelPane.fieldPaneChunkMode);
	var deletingLinkField = (fieldPaneSwitchButton == obj_panelPane.fieldPaneLinkMode);
	
	
	if (deletingTokenField) {
		fieldList = obj_control.tokenFieldList;
		navWindowList1 = obj_control.navTokenFieldList;
		var tokenTagMap =  global.nodeMap[? "tokenTagMap"];
		var fieldSubMap = tokenTagMap[?fieldName];
		scr_deleteFromList(fieldSubMap[? "targetList"], "Token");
	}
	else if (deletingUnitField) {
		fieldList = obj_control.unitFieldList;
		navWindowList1 = obj_control.navUnitFieldList;
	}
	else if (deletingEntryField) {
		fieldList = global.chainEntryFieldList;
		navWindowList1 = obj_control.chain1toManyColFieldListRez;
		navWindowList2 = obj_control.chain1toManyColFieldListTrack;
		navWindowList3 = obj_control.chain1toManyColFieldListStack;
	}
	else if (deletingChainField) {
		fieldList = global.chainFieldList;
		navWindowList1 = obj_control.chain1to1ColFieldListRez;
		navWindowList2 = obj_control.chain1to1ColFieldListTrack;
		navWindowList3 = obj_control.chain1to1ColFieldListStack;
	}
	else if (deletingChunkField) {
		fieldList = obj_control.chunkFieldList;
		navWindowList1 = obj_control.navChunkFieldList;
		var tokenTagMap =  global.nodeMap[? "tokenTagMap"];
		var fieldSubMap = tokenTagMap[?fieldName];
		scr_deleteFromList(fieldSubMap[? "targetList"], "Chunk");
	}
	else if (deletingLinkField) {
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
	
	
	
	// if we're deleting the displayTokenField, and there still is another token field left, let's switch to that one
	if (deletingTokenField) {
		if (global.displayTokenField == fieldName && ds_list_size(fieldList) >= 1) {
			global.displayTokenField = fieldList[| 0];
		}
		
		
		if (ds_list_find_index(obj_control.displayTokenList, fieldName) >= 0) {
			scr_deleteFromList(obj_control.displayTokenList, fieldName);
			obj_control.displayTokenListIndex = ds_list_find_index(obj_control.displayTokenList, global.displayTokenField);
		}
	}
	
	// if we're deleting the participantField, and there still is another unit field left, let's switch to that one
	if (deletingUnitField && global.participantField == fieldName && ds_list_size(fieldList) >= 1) {
		global.participantField = fieldList[| 0];
	}

}
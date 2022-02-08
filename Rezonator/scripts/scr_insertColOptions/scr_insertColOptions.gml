function scr_insertColOptions(optionSelected){
	
	var navFieldList = -1;
	var pos = obj_panelPane.chosenCol;
	if (obj_panelPane.functionChainList_currentTab == obj_panelPane.functionChainList_tabLine) {
		if (obj_panelPane.chainViewOneToMany) {
			navFieldList = obj_control.navTokenFieldList;
		}
		else {
			navFieldList = obj_control.navUnitFieldList;
		}
	}
	else if (obj_panelPane.functionChainList_currentTab == obj_panelPane.functionChainList_tabRezBrush) {
		if (obj_panelPane.chainViewOneToMany) {
			navFieldList = obj_control.chain1toManyColFieldListRez;
		}
		else {
			navFieldList = obj_control.chain1to1ColFieldListRez;
		}
	}
	else if (obj_panelPane.functionChainList_currentTab == obj_panelPane.functionChainList_tabTrackBrush) {
		if (obj_panelPane.chainViewOneToMany) {
			navFieldList = obj_control.chain1toManyColFieldListTrack;
		}
		else {
			navFieldList = obj_control.chain1to1ColFieldListTrack;
		}
	}
	else if (obj_panelPane.functionChainList_currentTab == obj_panelPane.functionChainList_tabStackBrush) {
		if (obj_panelPane.chainViewOneToMany) {
			navFieldList = obj_control.chain1toManyColFieldListStack;
		}
		else {
			navFieldList = obj_control.chain1to1ColFieldListStack;
		}
	}
	
	
	
	show_debug_message("scr_insertColOptions, inserting " + string(optionSelected) + " into pos " + string(pos));
	ds_list_insert(navFieldList, pos, optionSelected);

	with (obj_dropDown) instance_destroy();
}
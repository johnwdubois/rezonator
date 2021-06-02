/// @description initialize panel pane tab list
with (obj_control) {
	ds_list_add(panelPaneTabList, 
		obj_panelPane.functionChainList_tabLine,
		obj_panelPane.functionChainList_tabRezBrush,
		obj_panelPane.functionChainList_tabTrackBrush,
		obj_panelPane.functionChainList_tabStackBrush,
		obj_panelPane.functionChainList_tabShow,
		obj_panelPane.functionChainList_tabField);	
}
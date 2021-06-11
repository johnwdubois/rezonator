/// @description initialize panel pane tab list
with (obj_control) {
	ds_list_add(panelPaneTabList, 
		obj_panelPane.functionChainList_tabLine,
		obj_panelPane.functionChainList_tabRezBrush,
		obj_panelPane.functionChainList_tabTrackBrush,
		obj_panelPane.functionChainList_tabStackBrush,
		obj_panelPane.functionChainList_tabShow,
		obj_panelPane.functionChainList_tabField);	
		
	var translationListSize = ds_list_size(global.translationList);
	var hasTranslation = (translationListSize > 0);
	if(hasTranslation){
		scr_addToListOnce(obj_control.panelPaneTabList, obj_panelPane.functionChainList_tabTranslations);
	}
}
/// @description initialize panel pane tab list
with (obj_control) {
	ds_list_add(panelPaneTabList, 
		NAVTAB_UNIT,
		NAVTAB_STACK,
		NAVTAB_TRACK,
		NAVTAB_RESONANCE,
		NAVTAB_CLIQUE,
		NAVTAB_SHOW,
		NAVTAB_TREE,
		NAVTAB_CHUNK,
		NAVTAB_TAG,
		NAVTAB_SEARCH
		);	
		
	var translationListSize = ds_list_size(global.translationList);
	var hasTranslation = (translationListSize > 0);
	if (hasTranslation) {
		ds_list_add(obj_control.panelPaneTabList, NAVTAB_TRANSLATION);
	}
}
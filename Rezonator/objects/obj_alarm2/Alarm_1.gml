/// @description initialize panel pane tab list
with (obj_control) {
	ds_list_add(panelPaneTabList,
		NAVTAB_UNIT,
		NAVTAB_CHUNK,
		NAVTAB_TRACK,
		NAVTAB_RESONANCE,
		NAVTAB_CLIQUE,
		NAVTAB_STACK,
		NAVTAB_TREE,
		NAVTAB_TAG,
		NAVTAB_SHOW,
		NAVTAB_SEARCH
		);	
		
	var translationListSize = ds_list_size(global.translationList);
	var hasTranslation = (translationListSize > 0);
	if (hasTranslation) {
		ds_list_add(obj_control.panelPaneTabList, NAVTAB_TRANSLATION);
	}
}
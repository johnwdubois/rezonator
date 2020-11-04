function scr_rezPlay() {
	// not allowed to Rez-Play if you have made tracks or stacks
	//var trackRowInLinkGrid = ds_grid_value_y(obj_chain.linkGrid, obj_chain.linkGrid_colTier, 0, obj_chain.linkGrid_colTier, ds_grid_height(obj_chain.linkGrid), 2);
	var stackRowInLinkGrid = ds_grid_value_y(obj_chain.linkGrid, obj_chain.linkGrid_colTier, 0, obj_chain.linkGrid_colTier, ds_grid_height(obj_chain.linkGrid), 3);
	var newWordsAdded = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWordState, ds_grid_height(obj_control.dynamicWordGrid) - 1) == obj_control.wordStateNormal ? false : true;

	if (stackRowInLinkGrid >= 0 or newWordsAdded) {
		show_message(scr_get_translation("msg_cannot_play_rez"));
		exit;
	}
	if (ds_grid_height(obj_chain.linkGrid) < 1) {
		show_message(scr_get_translation("msg_no_playback"));
		exit;
	}




	if (obj_chain.inRezPlay) {
		exit;
	}
	obj_chain.inRezPlay = true;



	obj_chain.rezPlayTime = current_time - obj_control.sessionStartTime;

	scr_setAllValuesInCol(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colBorder, false);
	scr_setAllValuesInCol(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colAligned, false);
	scr_setAllValuesInCol(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colStretch, false);
	obj_chain.rezChainNameCounter = 0;
	obj_chain.trackChainNameCounter = 0;
	obj_chain.chainColorID[1] = 0;
	obj_chain.chainColorID[2] = 0;


	ds_grid_resize(obj_chain.rezPlayLinkGrid, obj_chain.linkGridWidth, ds_grid_height(obj_chain.linkGrid));
	ds_grid_copy(obj_chain.rezPlayLinkGrid, obj_chain.linkGrid);
	ds_grid_sort(obj_chain.rezPlayLinkGrid, obj_chain.linkGrid_colSourceClickTime, true);

	ds_grid_clear(obj_chain.linkGrid, 0);
	ds_grid_clear(obj_chain.rezChainGrid, 0);

	ds_grid_resize(obj_chain.linkGrid, obj_chain.linkGridWidth, 0);
	ds_grid_resize(obj_chain.rezChainGrid, obj_chain.chainGridWidth, 0);
	ds_grid_resize(obj_chain.trackChainGrid, obj_chain.chainGridWidth, 0);


	obj_chain.rezPlayLinkGridRow = 0;
	var currentWordClickTime = ds_grid_get(obj_chain.rezPlayLinkGrid, obj_chain.linkGrid_colSourceClickTime, obj_chain.rezPlayLinkGridRow) * fps;
	currentWordClickTime = min(currentWordClickTime, fps * 10);

	var currentTier = ds_grid_get(rezPlayLinkGrid, linkGrid_colTier, rezPlayLinkGridRow);
	obj_toolPane.currentTool = currentTier;

	with (obj_chain) {
		alarm[7] = currentWordClickTime;
	}


}

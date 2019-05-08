obj_chain.rezPlayTime = current_time - obj_control.sessionStartTime;
show_message("rezPlayTime: " + string(obj_chain.rezPlayTime));

scr_setAllValuesInCol(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colBorder, false);
scr_setAllValuesInCol(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colAligned, false);
scr_setAllValuesInCol(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colStretch, false);


ds_grid_resize(obj_chain.rezPlayLinkGrid, obj_chain.linkGridWidth, ds_grid_height(obj_chain.linkGrid));
ds_grid_copy(obj_chain.rezPlayLinkGrid, obj_chain.linkGrid);

ds_grid_clear(obj_chain.linkGrid, 0);
ds_grid_clear(obj_chain.rezChainGrid, 0);

ds_grid_resize(obj_chain.linkGrid, obj_chain.linkGridWidth, 0);
ds_grid_resize(obj_chain.rezChainGrid, obj_chain.chainGridWidth, 0);


obj_chain.rezPlayLinkGridRow = 0
var currentWordClickTime = ds_grid_get(obj_chain.rezPlayLinkGrid, obj_chain.linkGrid_colSourceClickTime, obj_chain.rezPlayLinkGridRow) * fps;
currentWordClickTime = min(currentWordClickTime, fps * 10);

with (obj_chain) {
	alarm[7] = currentWordClickTime;
}
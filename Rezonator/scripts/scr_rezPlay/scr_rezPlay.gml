// not allowed to Rez-Play if you have made tracks or stacks
//var trackRowInLinkGrid = ds_grid_value_y(obj_chain.linkGrid, obj_chain.linkGrid_colTier, 0, obj_chain.linkGrid_colTier, ds_grid_height(obj_chain.linkGrid), 2);
var stackRowInLinkGrid = ds_grid_value_y(obj_chain.linkGrid, obj_chain.linkGrid_colTier, 0, obj_chain.linkGrid_colTier, ds_grid_height(obj_chain.linkGrid), 3);

if (stackRowInLinkGrid >= 0) {
	show_message("Cannot Rez-Play for tracks or stacks yet");
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
if (not keyboard_check(vk_control)) {
	exit;
}

darkTheme = !darkTheme

var layerID = layer_get_id("Background");
var backID = layer_background_get_id(layerID);
if (darkTheme) {
	layer_background_blend(backID, darkThemeBackColor);
	scr_setAllValuesInCol(wordDrawGrid, wordDrawGrid_colTextColor, darkThemeTextColor);
}
else {
	layer_background_blend(backID, lightThemeBackColor);
	scr_setAllValuesInCol(wordDrawGrid, wordDrawGrid_colTextColor, lightThemeTextColor);
}
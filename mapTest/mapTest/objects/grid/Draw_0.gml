/// @description Insert description here
// You can write your code in this editor
for(var widthLoop = 0; widthLoop < gridWidth; widthLoop++) {
	for(var heightLoop = 0; heightLoop < gridHeight; heightLoop++) {
		var cell = ds_grid_get(testGrid, widthLoop, heightLoop);
		draw_text(widthLoop*60, heightLoop*20, string(cell));
	}
}
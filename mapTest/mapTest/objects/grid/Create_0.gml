/// @description Insert description here
// You can write your code in this editor
gridHeight = 20;
gridWidth = 10;
testGrid = ds_grid_create(gridWidth, gridHeight);
for(var widthLoop = 0; widthLoop < gridWidth; widthLoop++) {
	for(var heightLoop = 0; heightLoop < gridHeight; heightLoop++) {
		ds_grid_set(testGrid, widthLoop, heightLoop, irandom(100));
	}
}
ds_grid_set(testGrid, 6, 9, 69);

wumpy = ds_map_create();
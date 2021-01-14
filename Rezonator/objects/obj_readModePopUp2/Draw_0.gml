/// @description Insert description here
// You can write your code in this editor



var currentWordID = obj_control.hoverWordID;

if(currentWordID == -1){
	exit;
}

var wordPixelX = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colPixelX, currentWordID-1);
var wordDisplayRow = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayRow, currentWordID-1);
var wordPixelY = ds_grid_get(obj_control.lineGrid,obj_control.lineGrid_colPixelY, wordDisplayRow);

draw_set_alpha(1);
draw_set_font(global.fontMain);

var wordDisplayString = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, currentWordID-1);

var wordCenterX = wordPixelX + (string_width(wordDisplayString)/2);

var rectx1, recty1, rectx2, recty2; //rectangle points+
if(obj_toolPane.currentMode == obj_toolPane.modeRead){
	rectx1 = wordPixelX + string_width(wordDisplayString);
	recty1 = wordPixelY + string_height(wordDisplayString)/2;
	rectx2 = rectx1 + 100;
	recty2 = recty1 + 80;
	draw_set_color(c_blue);
	//draw_circle(wordCenterX, wordPixelY, 20, true);
	draw_rectangle(rectx1,recty1,rectx2,recty2,false);
}
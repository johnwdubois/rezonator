/// @description Insert description here
// You can write your code in this editor


// Get wordID of the word currently being hovered
var currentWordID = obj_control.hoverWordID;

if (currentWordID == -1)
{
	// If no word is being hovered, then do nothing
	exit;
}

// Only read-mode has WordTips
if (obj_toolPane.currentMode != obj_toolPane.modeRead)
{
	exit;
}

// Get the (x, y) coordinates of the word
var wordPixelX = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colPixelX, currentWordID-1);
var wordDisplayRow = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayRow, currentWordID-1);
var wordPixelY = ds_grid_get(obj_control.lineGrid, obj_control.lineGrid_colPixelY, wordDisplayRow);

draw_set_alpha(1);
draw_set_font(global.fontMain);

// Get the word's display string
var wordDisplayString = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, currentWordID-1);

var wordCenterX = wordPixelX + (string_width(wordDisplayString) / 2);

// TO-DO: Get the variables to display in the WordTip


// TO-DO: Calculate the box size based on the sizes of the display strings


// Set the rectangle's points
var rectx1 = wordPixelX + string_width(wordDisplayString);
var recty1 = wordPixelY + string_height(wordDisplayString) / 2;
var rectx2 = rectx1 + boxWidth;
var recty2 = recty1 + boxHeight;

// Draw the rectangle
draw_set_color(c_blue);
draw_rectangle(rectx1, recty1, rectx2, recty2, false);

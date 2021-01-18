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


/* --- Fill a grid with the word's attributes' names and values to display --- */

// Init. the grid
var attribGrid = ds_grid_create(2, 6);	// N rows for N attributes

// Set the attribute names
ds_grid_set(attribGrid, 0, 0, "text");
ds_grid_set(attribGrid, 0, 1, "transcript");
ds_grid_set(attribGrid, 0, 2, "POS_Spacy");
ds_grid_set(attribGrid, 0, 3, "DepRel_Spacy");
ds_grid_set(attribGrid, 0, 4, "wordStart");
ds_grid_set(attribGrid, 0, 5, "wordEnd");

// For each attribute, get its value (from the tokenImportGrid) and put it in the 2nd column
for (var i = 0; i < ds_grid_height(attribGrid); i++)
{
	var attribName = ds_grid_get(attribGrid, 0, i);	// Attribute name to find the value of
	var tokenImportGridAttribColNum = ds_list_find_index(global.tokenImportColNameList, attribName);	// Column number which stores the attribute in the tokenImportGrid
	var attribValue = ds_grid_get(global.tokenImportGrid, tokenImportGridAttribColNum, currentWordID - 1);	// Attribute value from the tokenImportGrid
	
	ds_grid_set(attribGrid, 1, i, attribValue);	// Insert attribute value into 2nd column
}

// Calculate the box height based on the number and size of attributes
var lineHeight = string_height(ds_grid_get(attribGrid, 0, 0) );
boxHeight = ds_grid_height(attribGrid) * lineHeight;

// Calculate the box width based on the maximum-width line
var maxLineWidth = 0;
for (var i = 0; i < ds_grid_height(attribGrid); i++)
{
	// For each line, calculate its width
	var attribNameWidth = string_width(string(ds_grid_get(attribGrid, 0, i) ) );
	var attribValWidth = string_width(string(ds_grid_get(attribGrid, 1, i) ) );
	var lineWidth = attribNameWidth + string_width(": ") + attribValWidth;
	
	// Then update the maximum line width
	maxLineWidth = max(lineWidth, maxLineWidth);
}
boxWidth = maxLineWidth;


/* --- Make and display the WordTip box --- */

// Set the rectangle's points
var rectx1 = wordPixelX + string_width(wordDisplayString);
var recty1 = wordPixelY + string_height(wordDisplayString) / 2;
var rectx2 = rectx1 + boxWidth;
var recty2 = recty1 + boxHeight;

// Draw the box's outline
draw_set_color(c_black);
draw_rectangle(rectx1, recty1, rectx2, recty2, true);

// Draw the box's fill color
draw_set_color(c_ltgrey);
draw_rectangle(rectx1, recty1, rectx2, recty2, false);


/* --- Display the word's attributes grid --- */

// Draw the attribute grid
draw_set_color(c_black);
for(var i = 0; i < ds_grid_height(attribGrid); i++)
{
	var attribName = ds_grid_get(attribGrid, 0, i);
	var attribValue = ds_grid_get(attribGrid, 1, i);
	
	// Draw the attribute name
	draw_text(rectx1, recty1 + i * lineHeight + lineHeight / 2, attribName);
	
	// Draw the attribute value to the right
	draw_text(	rectx1 + string_width(attribName),
				recty1 + i * lineHeight + lineHeight / 2,
				": " + string(attribValue) );
}



// TO-DO: Calculate the box size based on the sizes of the display strings
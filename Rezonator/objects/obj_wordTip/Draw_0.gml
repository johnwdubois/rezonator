/// @description Insert description here
// You can write your code in this editor


// Only read-mode has WordTips
if (obj_toolPane.currentMode != obj_toolPane.modeRead)
{
	exit;
}

/*
 * UNCOMMENT BELOW FOR persistent box when clicking a word

if (persistentBoxFlag == false)
{	
	// There is no persistent box currently
	
	if (obj_control.hoverWordID == -1)
	{
		// No word is being hovered
		exit;
	}
	
	else
	{
		// Make the box display the word at the mouse cursor
		currentWordID = obj_control.hoverWordID;
		boxX = floor(mouse_x + mouseCursorWidth);
		boxY = floor(mouse_y + mouseCursorHeight);
	}
}

else
{
	// There is a persistent box currently
	
	// [TODO]: Draw an outline around the word that has the persistent box
}*/

if (obj_control.hoverWordID == -1)
{
	// No word is being hovered
	exit;
}
	
else
{
	// Make the box display the word at the mouse cursor
	currentWordID = obj_control.hoverWordID;
	boxX = floor(mouse_x + mouseCursorWidth);
	boxY = floor(mouse_y + mouseCursorHeight);
}

/* --- Fill a grid with the word's attributes' names and values to display --- */

// N rows for N attributes
// If you want to add more variables, simply add them to the first column of the attribute grid
// The program will automatically resize the box and display the additional variables' values in the second column

var attribGrid = ds_grid_create(2, 7);	// Init. the grid

// Set the attribute names
ds_grid_set(attribGrid, 0, 0, "text");
ds_grid_set(attribGrid, 0, 1, "transcript");
ds_grid_set(attribGrid, 0, 2, "POS_Spacy");
ds_grid_set(attribGrid, 0, 3, "DepRel_Spacy");
ds_grid_set(attribGrid, 0, 4, "wordStart");
ds_grid_set(attribGrid, 0, 5, "wordEnd");

// For each attribute, get its value (from the tokenImportGrid) and put it in the 2nd column; if it does not exist, then remove the row from the attribute grid
for (var i = 0; i < ds_grid_height(attribGrid); i++)
{
	var attribName = ds_grid_get(attribGrid, 0, i);	// Attribute name to find the value of
	var tokenImportGridAttribColNum = ds_list_find_index(global.tokenImportColNameList, attribName);	// Column number which stores the attribute in the tokenImportGrid
	
	if (tokenImportGridAttribColNum == -1)	// No such attribute
	{
		scr_gridDeleteRow(attribGrid, i);
	}
	
	else
	{
		var attribValue = ds_grid_get(global.tokenImportGrid, tokenImportGridAttribColNum, currentWordID - 1);	// Attribute value from the tokenImportGrid
		ds_grid_set(attribGrid, 1, i, attribValue);	// Insert attribute value into 2nd column	
	}
}

if (ds_grid_height(attribGrid) == 0)	// Nothing to display, so stop here
{
	exit;	
}


/* --- Calculate the dimensions of the WordTip box --- */

scr_adaptFont("A", "M");	// Set font to English, Medium

// Box height is based on the number and height of the attributes
var lineHeight = string_height(ds_grid_get(attribGrid, 0, 0) );
boxHeight = ds_grid_height(attribGrid) * lineHeight;

// Calculate the maximum widths of the attribute names and values (including the headers)
var maxAttribNameWidth = string_width("Attribute");
var maxAttribValWidth = string_width("Value");
for (var i = 0; i < ds_grid_height(attribGrid); i++)
{
	// For each line, calculate the widths
	var attribNameWidth = string_width(string(ds_grid_get(attribGrid, 0, i) ) );
	var attribValWidth = string_width(string(ds_grid_get(attribGrid, 1, i) ) );
	
	// Then update the maximum widths
	maxAttribNameWidth = max(maxAttribNameWidth, attribNameWidth);
	maxAttribValWidth = max(maxAttribValWidth, attribValWidth);
}

boxWidth = maxAttribNameWidth + maxAttribValWidth;	// Box width fits the whole row

// Scale the box padding by the box's dimensions
boxPaddingHoriz = floor(0.05 * boxWidth);
boxPaddingVert = floor(0.03 * boxHeight);

var colPadding = boxPaddingHoriz * 2;	// Padding between end of longest attribute name and beginning of longest value

var headerHeight = boxPaddingVert * 2 + max( string_height("Attribute"), string_height("Value") );	// Height of header section/box

// Update the box dimensions to include the padding and header
boxWidth += boxPaddingHoriz * 2 + colPadding;
boxHeight += boxPaddingVert + headerHeight;

/* --- Set the box's coordinates --- */

var rectx2 = boxX + boxWidth;
var recty2 = boxY + boxHeight;

// Handle the case where the box clips off the bottom of the screen
var fullWindowHeight = camera_get_view_height(camera_get_active() );
if (recty2 >= fullWindowHeight)
{
	var overflowHeight = recty2 - fullWindowHeight;
	boxY -= overflowHeight;
	recty2 -= overflowHeight;
}

// Handle the case where the box clips off the right side of the screen
var fullWindowWidth = camera_get_view_width(camera_get_active() );
if (rectx2 >= fullWindowWidth)
{
	var overflowWidth = rectx2 - fullWindowWidth;
	boxX -= overflowWidth;
	rectx2 -= overflowWidth;
}


/* --- Draw the WordTip box and its attribute grid --- */

// Variable for reading purposes
var secondColumnOffsetX = boxPaddingHoriz + maxAttribNameWidth + colPadding;

// Draw the box's outline
draw_set_color(c_black);
draw_rectangle(boxX, boxY, rectx2, recty2, true);

// Draw the box's fill color
draw_set_color(make_color_rgb(245, 245, 245) );
draw_rectangle(boxX, boxY, rectx2, recty2, false);

// Draw the header's fill color
draw_set_color(make_color_rgb(220, 220, 220) );
draw_rectangle(boxX, boxY, rectx2, boxY + headerHeight, false);

// Draw the header and column separator lines
draw_set_color(c_grey);
draw_line(boxX, boxY + headerHeight, rectx2, boxY + headerHeight);	// Header line
draw_line(boxX + secondColumnOffsetX - colPadding / 2, boxY, boxX + secondColumnOffsetX - colPadding / 2, recty2);	// Column separator line

// Set params for drawing text
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_black);
draw_set_alpha(1);

// Draw the headers
draw_text(boxX + boxPaddingHoriz, boxY + boxPaddingVert, "Attribute");
draw_text(boxX + secondColumnOffsetX, boxY + boxPaddingVert, "Value");

// Draw the attribute grid
for(var i = 0; i < ds_grid_height(attribGrid); i++)
{
	var attribName = ds_grid_get(attribGrid, 0, i);
	var attribValueStr = string( ds_grid_get(attribGrid, 1, i) );
	
	var rowY = boxY + headerHeight + boxPaddingVert / 2 + i * lineHeight;
	
	scr_adaptFont(attribName, "M");
	
	// Draw the attribute name
	draw_text(boxX + boxPaddingHoriz, rowY,	attribName);
	
	scr_adaptFont(attribValueStr, "M");
	
	// Draw the attribute value to the right
	draw_text(boxX + secondColumnOffsetX, rowY, attribValueStr);
}
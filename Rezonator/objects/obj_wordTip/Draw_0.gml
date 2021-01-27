/// @description Insert description here
// You can write your code in this editor

// TO-DO: Make click make box persist until a non-word is clicked
// 1. If no persistentBox
//		a. hover word, display
//		b. If click word, display persistent box
// 2. If persistentBox yes
//		a. don't display hover word
//		b. display persistent box
//		c. If click same word or non-word, then turn off persistentBox
//		d. If click different word, then switch persistentBox display

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


/* --- Fill a grid with the word's attributes' names and values to display --- */

// Init. the grid
var attribGrid = ds_grid_create(2, 7);	// N + 1 rows for N attributes
										// If you want to add more variables, simply add them to the first column of the attribute grid
										// The program will automatically resize the box and display the additional variables' values

// Set attribute name-value headers
ds_grid_set(attribGrid, 0, 0, "Attribute");
ds_grid_set(attribGrid, 1, 0, "Value");

// Set the attribute names
ds_grid_set(attribGrid, 0, 1, "text");
ds_grid_set(attribGrid, 0, 2, "transcript");
ds_grid_set(attribGrid, 0, 3, "POS_Spacy");
ds_grid_set(attribGrid, 0, 4, "DepRel_Spacy");
ds_grid_set(attribGrid, 0, 5, "wordStart");
ds_grid_set(attribGrid, 0, 6, "wordEnd");

// For each attribute, get its value (from the tokenImportGrid) and put it in the 2nd column
for (var i = 1; i < ds_grid_height(attribGrid); i++)
{
	var attribName = ds_grid_get(attribGrid, 0, i);	// Attribute name to find the value of
	var tokenImportGridAttribColNum = ds_list_find_index(global.tokenImportColNameList, attribName);	// Column number which stores the attribute in the tokenImportGrid
	var attribValue = ds_grid_get(global.tokenImportGrid, tokenImportGridAttribColNum, currentWordID - 1);	// Attribute value from the tokenImportGrid
	
	ds_grid_set(attribGrid, 1, i, attribValue);	// Insert attribute value into 2nd column
}


/* --- Calculate dimensions of and display the WordTip box --- */

// Calculate the box height based on the number and size of attributes
var lineHeight = string_height(ds_grid_get(attribGrid, 0, 0) );
boxHeight = ds_grid_height(attribGrid) * lineHeight;

// Calculate the box width based on the maximum-width line
var maxAttribNameWidth = 0;
var maxAttribValWidth = 0;
for (var i = 0; i < ds_grid_height(attribGrid); i++)
{
	// For each line, calculate the widths
	var attribNameWidth = string_width(string(ds_grid_get(attribGrid, 0, i) ) );
	var attribValWidth = string_width(string(ds_grid_get(attribGrid, 1, i) ) );
	
	// Then update the maximum widths
	maxAttribNameWidth = max(maxAttribNameWidth, attribNameWidth);
	maxAttribValWidth = max(maxAttribValWidth, attribValWidth);
}

// Set the box width based on the maximum-width line
boxWidth = maxAttribNameWidth + attribGridColPadding + maxAttribValWidth;

// Set the box's coordinates
var rectx1 = mouse_x + mouseCursorWidth;
var recty1 = mouse_y + mouseCursorHeight;
var rectx2 = rectx1 + boxWidth + 2 * boxPaddingHoriz;
var recty2 = recty1 + boxHeight + 2 * boxPaddingVert;

// Handle the case where the box clips off the bottom of the screen
var fullWindowHeight = camera_get_view_height(camera_get_active() );
if (recty2 >= fullWindowHeight)
{
	var overflowHeight = recty2 - fullWindowHeight;
	recty1 -= overflowHeight;
	recty2 -= overflowHeight;
}

// Handle the case where the box clips off the right side of the screen
var fullWindowWidth = camera_get_view_width(camera_get_active() );
if (rectx2 >= fullWindowWidth)
{
	var overflowWidth = rectx2 - fullWindowWidth;
	rectx1 -= overflowWidth;
	rectx2 -= overflowWidth;
}


// Draw the box's outline
draw_set_color(c_black);
draw_rectangle(rectx1, recty1, rectx2, recty2, true);

// Draw the box's fill color
draw_set_color(make_color_rgb(245, 245, 245) );
draw_rectangle(rectx1, recty1, rectx2, recty2, false);


/* --- Display the word's attributes grid --- */

// Calculate width of first column
var attribGridCol1Width = maxAttribNameWidth + attribGridColPadding;

// Set drawing params
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_font(global.fontMain);
scr_adaptFont("", "M");	// set font to English, Medium
draw_set_color(c_black);
draw_set_alpha(1);

// Draw the attribute grid
for(var i = 0; i < ds_grid_height(attribGrid); i++)
{
	var attribName = ds_grid_get(attribGrid, 0, i);
	var attribValue = ds_grid_get(attribGrid, 1, i);
	
	// Draw the attribute name
	draw_text(	floor(rectx1 + boxPaddingHoriz), 
				floor(recty1 + boxPaddingVert + i * lineHeight),
				attribName);
	
	// Draw the attribute value to the right
	draw_text(	floor(rectx1 + boxPaddingHoriz + attribGridCol1Width),
				floor(recty1 + boxPaddingVert + i * lineHeight),
				string(attribValue) );
}
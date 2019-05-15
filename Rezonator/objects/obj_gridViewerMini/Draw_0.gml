if (obj_control.gridView)
{
	exit;
}

draw_set_font(fnt_debug);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_set_alpha(1);

var rectWidth = 500;
var rectHeight = 300;

var headerSpace = 16;

draw_set_color(c_white);
draw_rectangle(x, y, x + rectWidth, y + rectHeight, false);
draw_set_color(c_black);
draw_rectangle(x, y, x + rectWidth, y + rectHeight, true);



var horizontalSpace = 70;
var verticalSpace = 20;

var horizontalSpace2 = 70;
var verticalSpace2 = 20;

var drawRange = 7;
var drawRangeStart = max(0, currentCenterRow - drawRange);
var drawRangeEnd = min(ds_grid_height(grid), currentCenterRow + drawRange);

var controlDrawRangeStart = obj_control.currentCenterDisplayRow - obj_control.drawRange;
var controlDrawRangeEnd = obj_control.currentCenterDisplayRow + obj_control.drawRange;

for (var i = 0; i < ds_grid_width(grid); i++)
{
		var currentHeader = "";
		switch (i)
		{
			case obj_control.lineGrid_colDisplayRow:
				currentHeader = "displayRow";
				break;
			case obj_control.lineGrid_colDiscoID:
				currentHeader = "discoID";
				break;
			case obj_control.lineGrid_colUnitID:
				currentHeader = "unitID";
				break;
			case obj_control.lineGrid_colLineNumberLabel:
				currentHeader = "lineNumberLabel";
				break;
			case obj_control.lineGrid_colPixelY:
				currentHeader = "pixelY";
				break;
			case obj_control.lineGrid_colLineState:
				currentHeader = "lineState";
				break;
			case obj_control.lineGrid_colWordIDList:
				currentHeader = "wordIDList";
				break;
			default:
				currentHeader = "n/a";
				break;
	}
	
	draw_set_color(c_white);
	draw_rectangle(x + (i * horizontalSpace), y, x + (i * horizontalSpace) + string_width(currentHeader), y + headerSpace, false);
	draw_set_color(c_black);
	draw_text(x + (i * horizontalSpace), y + (headerSpace / 2), currentHeader);
	
	for (var j = drawRangeStart; j < drawRangeEnd; j++)
	{
		var currentItemGet = ds_grid_get(grid, i, j)
		var currentItemString = string(currentItemGet);
		
		
		if (i == obj_control.lineGrid_colWordIDList)
		{
			currentItemString = "{";
			for (var k = 0; k < ds_list_size(currentItemGet); k++)
			{
				currentItemString += string(ds_list_find_value(currentItemGet, k)) + ", ";
			}
			currentItemString += "}"
		}
		/*
		lineGrid_colDisplayRow = 0;
lineGrid_colDiscoID = 1;
lineGrid_colUnitID = 2; //lineGrid_colUnit = 2;
lineGrid_colLineNumberLabel = 3;
lineGrid_colPixelY = 4; //lineGrid_colY = 3;
lineGrid_colLineState = 5;
lineGrid_colWordIDList = 6;
		*/
		
		var stringRectX1 = x + (i * horizontalSpace);
		var stringRectY1 = y + ((j - currentCenterRow) * verticalSpace) + (rectHeight / 2) + 8;
		var stringRectX2 = stringRectX1 + string_width(currentItemString);
		var stringRectY2 = stringRectY1 + string_height(currentItemString);
		
		draw_set_alpha(1);
		if (j >= controlDrawRangeStart && j <= controlDrawRangeEnd)
		{
			draw_set_alpha(0.4);
			draw_set_color(c_yellow);
		}
		else
		{
			draw_set_color(c_white);
		}
		
		draw_rectangle(stringRectX1, stringRectY1, stringRectX2, stringRectY2, false);
		draw_set_alpha(1);
		draw_set_color(c_black);
		draw_text(stringRectX1, mean(stringRectY1, stringRectY2), currentItemString);
		
		draw_text(stringRectX1, mean(stringRectY1, stringRectY2), currentItemString);
		
		draw_set_color(c_ltgray);
		draw_line(stringRectX1, y, stringRectX1, y + rectHeight);
		
	}
}

draw_set_color(c_white);
draw_rectangle(x + rectWidth, y, x + (rectWidth * 2), y + rectHeight, false);
draw_set_color(c_black);
draw_rectangle(x + rectWidth, y, x + (rectWidth * 2), y + rectHeight, true);

var drawRange2 = 7;
var drawRangeStart2 = max(0, currentCenterRow2 - drawRange2);
var drawRangeEnd2 = min(ds_grid_height(grid2), currentCenterRow2 + drawRange2);

for (var k = 0; k < ds_grid_width(grid2); k++)
{	
	var currentHeader2 = "";
		switch (k)
		{
			case obj_control.dynamicWordGrid_colWordID:
				currentHeader2 = "wordID";
				break;
			case obj_control.dynamicWordGrid_colDisplayWordSeq:
				currentHeader2 = "displayWordSeq";
				break;
			case obj_control.dynamicWordGrid_colDisplayCol:
				currentHeader2 = "displayCol";
				break;
			case obj_control.dynamicWordGrid_colPixelX:
				currentHeader2 = "pixelX";
				break;
			case obj_control.dynamicWordGrid_colWordState:
				currentHeader2 = "wordState";
				break;
			case obj_control.dynamicWordGrid_colDisplayString:
				currentHeader2 = "displayString";
				break;
			case obj_control.dynamicWordGrid_colInChainList:
				currentHeader2 = "inChainList";
				break;
			case obj_control.dynamicWordGrid_colInBoxList:
				currentHeader2 = "inBoxList";
				break;
			default:
				currentHeader2 = "n/a";
				break;
	}
	
	draw_set_color(c_white);
	draw_rectangle(x + (k * horizontalSpace2) + rectWidth, y, x + (k * horizontalSpace2) + string_width(currentHeader2) + rectWidth, y + headerSpace, false);
	draw_set_color(c_black);
	draw_text(x + (k * horizontalSpace2) + rectWidth, y + (headerSpace / 2), currentHeader2);
	
	
	
	for (var l = drawRangeStart2; l < drawRangeEnd2; l++)
	{
		var currentItemGet2 = ds_grid_get(grid2, k, l)
		var currentItemString2 = string(currentItemGet2);
		
		
		if (k == obj_control.dynamicWordGrid_colInChainList)
		{
			currentItemString2 = "{";
			for (var p = 0; p < ds_list_size(currentItemGet2); p++)
			{
				currentItemString2 += string(ds_list_find_value(currentItemGet2, p)) + ", ";
			}
			currentItemString2 += "}"
		}
		
		if (k == obj_control.dynamicWordGrid_colInBoxList)
		{
			currentItemString2 = "{";
			for (var p = 0; p < ds_list_size(currentItemGet2); p++)
			{
				currentItemString2 += string(ds_list_find_value(currentItemGet2, p)) + ", ";
			}
			currentItemString2 += "}"
		}
		
			
		
		//draw_text(x + (k * horizontalSpace2) + rectWidth, y + ((l - currentCenterRow2) * verticalSpace2) + (rectHeight / 2), currentItemString2);
		
		var stringRect2X1 = x + (k * horizontalSpace) + rectWidth;
		var stringRect2Y1 = y + ((l - currentCenterRow2) * verticalSpace) + (rectHeight / 2) + 8;
		var stringRect2X2 = stringRect2X1 + string_width(currentItemString2);
		var stringRect2Y2 = stringRect2Y1 + string_height(currentItemString2);
		
		//draw_set_color(c_white);
		//draw_rectangle(stringRect2X1, stringRect2Y1, stringRect2X2, stringRect2Y2, false);
		draw_set_color(c_black);
		draw_text(stringRect2X1, mean(stringRect2Y1, stringRect2Y2), currentItemString2);
		
		draw_set_color(c_ltgray);
		draw_line(stringRect2X1, y, stringRect2X1, y + rectHeight);
	}
}

draw_set_color(c_black);
draw_line_width(x + rectWidth - 4, y, x + rectWidth - 4, y + rectHeight, 4);

draw_line(x, y + headerSpace, x + (rectWidth * 2), y + headerSpace);



if (mouse_check_button(mb_right) && keyboard_check(vk_space))
{
	x = mouse_x;
	y = mouse_y;
}

if (keyboard_check(ord("W")) && point_in_rectangle(mouse_x, mouse_y, x, y, x + rectWidth, y + rectHeight))
{
	currentCenterRow++;
}
if (keyboard_check(ord("S")) && point_in_rectangle(mouse_x, mouse_y, x, y, x + rectWidth, y + rectHeight))
{
	currentCenterRow--;
}
if (keyboard_check_pressed(ord("D")) && point_in_rectangle(mouse_x, mouse_y, x, y, x + rectWidth, y + rectHeight))
{
	currentCenterRow = ds_grid_height(grid);
}
if (keyboard_check_pressed(ord("A")) && point_in_rectangle(mouse_x, mouse_y, x, y, x + rectWidth, y + rectHeight))
{
	currentCenterRow = 0;
}


if (keyboard_check(ord("W")) && point_in_rectangle(mouse_x, mouse_y, x + rectWidth, y, x + (rectWidth * 2), y + rectHeight))
{
	currentCenterRow2++;
}
if (keyboard_check(ord("S")) && point_in_rectangle(mouse_x, mouse_y, x + rectWidth, y, x + (rectWidth * 2), y + rectHeight))
{
	currentCenterRow2--;
}
if (keyboard_check_pressed(ord("D")) && point_in_rectangle(mouse_x, mouse_y, x + rectWidth, y, x + (rectWidth * 2), y + rectHeight))
{
	currentCenterRow2 = ds_grid_height(grid2);
}
if (keyboard_check_pressed(ord("A")) && point_in_rectangle(mouse_x, mouse_y, x + rectWidth, y, x + (rectWidth * 2), y + rectHeight))
{
	currentCenterRow2 = 0;
}
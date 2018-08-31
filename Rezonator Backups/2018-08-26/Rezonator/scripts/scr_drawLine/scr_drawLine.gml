/*
	scr_drawLine();
	
	Last Updated: 2018-07-12
	
	Called from: obj_control
	
	Purpose: draws words and lines from the lineGrid that are within the drawRange
	
	Mechanism: loop through the lineGrid (only loop through necessary lines) and get wordIDList from each line, then draw out those words
*/

if (gridView)
{
	exit;
}

draw_set_font(fnt_main);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_set_color(c_black);
draw_set_alpha(1);


var drawRangeStart = currentCenterDisplayRow - drawRange;
var drawRangeEnd = currentCenterDisplayRow + drawRange;

drawRangeStart = max(drawRangeStart, 0);
drawRangeEnd = min(drawRangeEnd, ds_grid_height(currentActiveLineGrid));

for (var drawLineLoop = drawRangeStart; drawLineLoop < drawRangeEnd; drawLineLoop++)
{
	if (drawLineLoop < 0 or drawLineLoop >= ds_grid_height(currentActiveLineGrid))
	{
		continue;
	}
	
	var currentWordIDList = ds_grid_get(currentActiveLineGrid, lineGrid_colWordIDList, drawLineLoop);
	
	var currentLineDestY = (ds_grid_get(currentActiveLineGrid, lineGrid_colDisplayRow, drawLineLoop) - currentCenterDisplayRow) * gridSpaceVertical + (room_height / 2);
	var currentLineY = ds_grid_get(currentActiveLineGrid, lineGrid_colPixelY, drawLineLoop);
	
	if (currentLineY < currentLineDestY)
	{
		currentLineY += abs(currentLineY - currentLineDestY) / 6;
	}
	else if (currentLineY > currentLineDestY)
	{
		currentLineY -= abs(currentLineY - currentLineDestY) / 6;
	}
	
	ds_grid_set(currentActiveLineGrid, lineGrid_colPixelY, drawLineLoop, currentLineY);
	
	var speakerRectX1 = 0;
	var speakerRectY1 = currentLineY - (gridSpaceVertical / 2);
	var speakerRectX2 = speakerLabelMargin - speakerLabelMarginBuffer;
	var speakerRectY2 = speakerRectY1 + gridSpaceVertical;
	
	var unitID = ds_grid_get(currentActiveLineGrid, lineGrid_colUnitID, drawLineLoop);
	var currentDiscoID = ds_grid_get(currentActiveLineGrid, lineGrid_colDiscoID, drawLineLoop);
	var currentLineNumberLabel = ds_grid_get(currentActiveLineGrid, lineGrid_colLineNumberLabel, drawLineLoop);
	
	//var currentLineInStack = ds_grid_get(lineGrid, lineGrid_colInStack, drawLineLoop);
	var currentLineInStack = false;
	

	for (var stackTestLoop = 0; stackTestLoop < ds_list_size(currentWordIDList); stackTestLoop++)
	{
		var currentWordID = ds_list_find_value(currentWordIDList, stackTestLoop) - 1;
		var stackList = ds_grid_get(obj_chain.unitInStackGrid, obj_chain.unitInStackGrid_colStackList, unitID - 1);
		
		if (ds_list_size(stackList) > 0)
		{
			currentLineInStack = ds_list_find_value(stackList, 0);
		}
	}
	
	if (ds_grid_value_exists(obj_chain.stackChainGrid, obj_chain.chainGrid_colChainID, 0, obj_chain.chainGrid_colChainID, ds_grid_height(obj_chain.stackChainGrid), currentLineInStack))
	{
		var rowInStackChainGrid = ds_grid_value_y(obj_chain.stackChainGrid, obj_chain.chainGrid_colChainID, 0, obj_chain.chainGrid_colChainID, ds_grid_height(obj_chain.stackChainGrid), currentLineInStack);
		var stackColor = ds_grid_get(obj_chain.stackChainGrid, obj_chain.chainGrid_colColor, rowInStackChainGrid);
		
		draw_set_color(stackColor);
		draw_set_alpha(0.2);
		
		var stackRectX1 = speakerRectX2;
		var stackRectY1 = speakerRectY1;
		var stackRectX2 = room_width;
		var stackRectY2 = speakerRectY2;
		
		draw_rectangle(stackRectX1, stackRectY1, stackRectX2, stackRectY2, false);
	}
	
	
	
	
	
	var dbWordIDList = "";
	
	var previousWordDisplayCol = -1;
	
	if (searchGridActive)
	{
		scr_drawLineHitIDListLoop(currentWordIDList, previousWordDisplayCol, currentLineY, drawLineLoop);
	}
	else
	{
		scr_drawLineWordIDListLoop(currentWordIDList, previousWordDisplayCol, currentLineY, drawLineLoop);
	}
	

	
	
	if (point_in_rectangle(mouse_x, mouse_y, speakerRectX1, speakerRectY1, speakerRectX2, speakerRectY2))
	{
		draw_set_alpha(1);
		draw_set_font(fnt_debug);
		draw_set_color(c_red);
		draw_text(mouse_x, mouse_y, dbWordIDList);
	}
	
	var participantColorIndex = ds_grid_get(unitGrid, unitGrid_colParticipantColorIndex, unitID - 1);
	draw_set_alpha(1);
	draw_set_color(participantColor[participantColorIndex]);
	draw_rectangle(speakerRectX1, speakerRectY1, speakerRectX2, speakerRectY2, false);

	var participantName = ds_grid_get(unitGrid, unitGrid_colParticipantName, unitID - 1);
	draw_set_alpha(1);
	draw_set_font(fnt_main);
	draw_set_color(c_black);
	draw_set_halign(fa_left);
	
	if (speakerRectY1 == undefined or speakerRectY2 == undefined or currentDiscoID == undefined or currentLineNumberLabel == undefined or participantName == undefined)
	{
		continue;
	}
	
	draw_text(0, mean(speakerRectY1, speakerRectY2), string(currentDiscoID) + ", " + string(currentLineNumberLabel) + " " + participantName);
	
}

if (showDevVars)
{
	draw_set_alpha(1);
	draw_set_font(fnt_debug);
	draw_set_halign(fa_right);
	draw_text(room_width - 100, 250, "drawRange: " + string(drawRangeStart) + " ... " + string(drawRangeEnd));
}

if (drawRangeStart > 0)
{
	ds_grid_set(currentActiveLineGrid, lineGrid_colPixelY, drawRangeStart - 1, -gridSpaceVertical);
}
if (drawRangeEnd < ds_grid_height(currentActiveLineGrid) - 1)
{
	ds_grid_set(currentActiveLineGrid, lineGrid_colPixelY, drawRangeEnd + 1, room_height + gridSpaceVertical);
}
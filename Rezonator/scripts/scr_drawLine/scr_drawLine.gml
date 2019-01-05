/*
	scr_drawLine();
	
	Last Updated: 2018-07-12
	
	Called from: obj_control
	
	Purpose: draws words and lines from the lineGrid that are within the drawRange
	
	Mechanism: loop through the lineGrid (only loop through necessary lines) and get wordIDList from each line, then draw out those words
*/

if (gridView || ds_grid_height(dynamicWordGrid) < 1)
{
	exit;
}

ds_grid_set_region(wordDrawGrid, wordDrawGrid_colVisible, 0, wordDrawGrid_colVisible, ds_grid_height(wordDrawGrid), false);

draw_set_font(fnt_main);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_set_color(c_black);
draw_set_alpha(1);


drawRangeStart = currentCenterDisplayRow - drawRange;
drawRangeEnd = currentCenterDisplayRow + drawRange;

drawRangeStart = max(drawRangeStart, 0);
drawRangeEnd = min(drawRangeEnd, ds_grid_height(currentActiveLineGrid));

if (drawRangeStart == 0 and ds_grid_height(currentActiveLineGrid) > 0)
{
	var firstLinePixelY = ds_grid_get(currentActiveLineGrid, obj_control.lineGrid_colPixelY, 0);
	draw_set_color(c_ltgray);
	draw_rectangle(0, 0, room_width, firstLinePixelY - (obj_control.gridSpaceVertical / 2), false);
}
if (drawRangeEnd == ds_grid_height(currentActiveLineGrid) and ds_grid_height(currentActiveLineGrid) > 0)
{
	var lastLinePixelY = ds_grid_get(currentActiveLineGrid, obj_control.lineGrid_colPixelY, ds_grid_height(currentActiveLineGrid) - 1);
	draw_set_color(c_ltgray);
	draw_rectangle(0, lastLinePixelY + (obj_control.gridSpaceVertical / 2), room_width, room_height, false);
}

if (obj_control.wordLeftMargin > obj_control.speakerLabelMargin + obj_control.speakerLabelMarginBuffer)
{
	draw_set_color(c_ltgray);
	var leftOutOfBoundsRectX1 = obj_control.speakerLabelMargin - obj_control.speakerLabelMarginBuffer;
	var leftOutOfBoundsRectY1 = 0;
	var leftOutOfBoundsRectX2 = obj_control.wordLeftMargin - obj_control.speakerLabelMarginBuffer;
	var leftOutOfBoundsRectY2 = room_height;
	draw_rectangle(leftOutOfBoundsRectX1, leftOutOfBoundsRectY1, leftOutOfBoundsRectX2, leftOutOfBoundsRectY2, false);
}

draw_set_color(c_black);

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
		currentLineY += abs(currentLineY - currentLineDestY) / 4;
	}
	else if (currentLineY > currentLineDestY)
	{
		currentLineY -= abs(currentLineY - currentLineDestY) / 4;
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
	var currentLineInStackList = -1;
	
	if (ds_grid_height(obj_chain.unitInStackGrid) == ds_grid_height(obj_control.unitGrid))
	{
		/*
		for (var stackTestLoop = 0; stackTestLoop < ds_list_size(currentWordIDList); stackTestLoop++)
		{
			var currentWordID = ds_list_find_value(currentWordIDList, stackTestLoop) - 1;
			var stackList = ds_grid_get(obj_chain.unitInStackGrid, obj_chain.unitInStackGrid_colStackList, unitID - 1);
		
			if (ds_list_size(stackList) > 0)
			{
				currentLineInStack = ds_list_find_value(stackList, 0);
			}
		}
		
		currentLineInStack = ds_list_find_value(stackList, 0);
		*/
		currentLineInStackList = ds_grid_get(obj_chain.unitInStackGrid, obj_chain.unitInStackGrid_colStackList, unitID - 1);
	}
	
	if (not (currentLineInStackList == -1) and ds_exists(currentLineInStackList, ds_type_list))
	{
		for (var i = 0; i < ds_list_size(currentLineInStackList); i++)
		{
			var currentStackChainID = ds_list_find_value(currentLineInStackList, i);
			var rowInStackChainGrid = ds_grid_value_y(obj_chain.stackChainGrid, obj_chain.chainGrid_colChainID, 0, obj_chain.chainGrid_colChainID, ds_grid_height(obj_chain.stackChainGrid), currentStackChainID);
			var stackColor = ds_grid_get(obj_chain.stackChainGrid, obj_chain.chainGrid_colColor, rowInStackChainGrid);
			
			if not (typeof(stackColor) == "number")
			{
				continue
			}
		
			draw_set_color(stackColor);
			draw_set_alpha(0.2);
			
			var stackRectWidth = (room_width - speakerRectX2) / ds_list_size(currentLineInStackList);
			var stackRectX1 = speakerRectX2 + (i * stackRectWidth);
			var stackRectY1 = speakerRectY1;
			var stackRectX2 = stackRectX1 + stackRectWidth;
			var stackRectY2 = speakerRectY2;
			
			draw_rectangle(stackRectX1, stackRectY1, stackRectX2, stackRectY2, false);
		}
	}
	
	/*
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
	*/
	
	
	
	
	
	var dbWordIDList = "";
	
	var previousWordDisplayCol = -1;
	
	if (searchGridActive)
	{
		scr_drawLineHitIDListLoop(currentWordIDList, previousWordDisplayCol, currentLineY, drawLineLoop);
	}
	else
	{
		scr_drawLineWordIDListLoop(currentWordIDList, previousWordDisplayCol, currentLineY, drawLineLoop, unitID);
	}
	

	
	
	if (point_in_rectangle(mouse_x, mouse_y, speakerRectX1, speakerRectY1, speakerRectX2, speakerRectY2))
	{
		draw_set_alpha(1);
		draw_set_font(fnt_debug);
		draw_set_color(c_red);
		draw_text(mouse_x, mouse_y, dbWordIDList);
	}
	
	var participantColor = ds_grid_get(unitGrid, unitGrid_colParticipantColor, unitID - 1);
	draw_set_alpha(1);
	draw_set_color(participantColor);
	//draw_set_color(c_red);
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
// Draw a chunkWord to the screen

var currentWordID = argument0;
var currentWordGridRow = currentWordID - 1;

// Here will be functionality to focus on a Chunk and add it to a Chain
// This includes: Hovering over Chunk will visually effect the outline
draw_set_font(global.fontMain);

// Aquire the Chunk's row in the Chunk grid (this is currently too expensive)
var inChunkList = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colInBoxList, currentWordGridRow);
if(ds_list_size(inChunkList) < 1) {
	return;
}
		
// A chunkWord always has its own Chunk as firstin its list
var currentChunkID = (ds_list_find_value(inChunkList, 0)); //ds_grid_value_y(obj_chain.chunkGrid, obj_chain.chainGrid_colName, 0, obj_chain.chainGrid_colName, ds_grid_height(obj_chain.chunkGrid), currentWordID);
if(currentChunkID == undefined) {
	return;
}
// Aquire the relevant row in the chunkGrid
var currentChunkRow = currentChunkID - 1;
if(currentChunkRow < 0) {
	return;	
}

// Grab the Chunk's list of contained words
var currentWordList = ds_grid_get(obj_chain.chunkGrid, obj_chain.chunkGrid_colBoxWordIDList, currentChunkRow);
		
// Safety Check
if (currentWordList == undefined || ds_list_size(currentWordList) < 1) {
	return;
}
		
// Set all variables needed to draw a Chunk
var firstWordID = -1;
var lastWordID = -1;
		
// Get the first and last word within the Chunk
firstWordID = ds_list_find_value(currentWordList, 0);
		
// The true last word within this list is the chunkWordID
var nonChunkWordPos = ds_list_size(currentWordList)-2;
lastWordID = ds_list_find_value(currentWordList, nonChunkWordPos);
		
// Aquire the ID of the last nonChunkWord in this list
var lastWordState = ds_grid_get(dynamicWordGrid, dynamicWordGrid_colWordState, lastWordID - 1);
while(lastWordState == wordStateChunk || lastWordState == wordStateDead) {
	lastWordID = ds_list_find_value(currentWordList, --nonChunkWordPos);
	lastWordState = ds_grid_get(dynamicWordGrid, dynamicWordGrid_colWordState, lastWordID - 1);
}
		
// Set the Buffer to be initially large, so as to allow for nesting
var wordRectBuffer = 15;
if (ds_grid_get(obj_chain.chunkGrid, obj_chain.chunkGrid_colNest, currentChunkRow) == true) {
	wordRectBuffer = 9;
}
		
// Set up the measurements for the drawn box
var leftPixelX = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colPixelX, firstWordID - 1);
var firstDisplayCol = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, firstWordID - 1);
var rightPixelX = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colPixelX, lastWordID - 1);
ds_grid_set(dynamicWordGrid, dynamicWordGrid_colPixelX, currentWordGridRow, leftPixelX);
		
// Get the string of the first word
var firstWordString = ds_grid_get(dynamicWordGrid, dynamicWordGrid_colDisplayString, firstWordID - 1);
// Get the string of the last word
var lastWordString = ds_grid_get(dynamicWordGrid, dynamicWordGrid_colDisplayString, lastWordID - 1);
		
// Set the special wordRect
var topLeftX = leftPixelX - wordRectBuffer;
var topLeftY = currentLineY - (string_height(firstWordString) / 2) - wordRectBuffer;
var bottomRightX = rightPixelX + string_width(lastWordString) + (wordRectBuffer); //*2
var bottomRightY = topLeftY + string_height(firstWordString) + (wordRectBuffer * 2);
		
// Aquire wordDraw specifics
var effectColor = ds_grid_get(wordDrawGrid, wordDrawGrid_colEffectColor, currentWordID - 1);//global.colorThemeSelected1
var drawFocused = ds_grid_get(wordDrawGrid, wordDrawGrid_colFocused, currentWordID - 1);
var borderRounded = ds_grid_get(wordDrawGrid, wordDrawGrid_colBorderRounded, currentWordID - 1);
		
// Draw the Chunks visual representation
if(ds_list_size(ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colInChainList, currentWordGridRow)) > 0) {
	draw_set_color(effectColor);
} else {
	draw_set_color(global.colorThemeText);	
}
for (var drawBorderLoop = 0; drawBorderLoop < 2; drawBorderLoop++) {
	if (borderRounded) {
		draw_roundrect(topLeftX - drawBorderLoop, topLeftY - drawBorderLoop, bottomRightX + drawBorderLoop, bottomRightY + drawBorderLoop, true);
	}
	else {
		draw_rectangle(topLeftX - drawBorderLoop, topLeftY - drawBorderLoop, bottomRightX + drawBorderLoop, bottomRightY + drawBorderLoop, true);
	}
}
if (drawFocused) {
	draw_sprite_ext(spr_focusPoint, 0, topLeftX - wordDrawGridFocusedAnimation, topLeftY - wordDrawGridFocusedAnimation, fontScale, fontScale, 0, effectColor, 1);
	draw_sprite_ext(spr_focusPoint, 0, bottomRightX + wordDrawGridFocusedAnimation, topLeftY - wordDrawGridFocusedAnimation, fontScale, fontScale, 0, effectColor, 1);
	draw_sprite_ext(spr_focusPoint, 0, topLeftX - wordDrawGridFocusedAnimation, bottomRightY + wordDrawGridFocusedAnimation, fontScale, fontScale, 0, effectColor, 1);
	draw_sprite_ext(spr_focusPoint, 0, bottomRightX + wordDrawGridFocusedAnimation, bottomRightY + wordDrawGridFocusedAnimation, fontScale, fontScale, 0, effectColor, 1);
}
		
// Check for mouseover of the Chunk 
var mouseover = false;
if (point_in_rectangle(mouse_x, mouse_y, topLeftX, topLeftY, bottomRightX, bottomRightY) and not (obj_toolPane.currentTool == obj_toolPane.toolNewWord) and not obj_chain.inRezPlay
and not mouseoverPanelPane and (hoverChunkID == currentWordID || hoverChunkID == -1) and hoverWordID == -1 and !instance_exists(obj_dialogueBox) and !instance_exists(obj_stackShow)) {
	mouseover = true;
			
	// May need to make a hoverChunkID
	hoverChunkID = currentWordID;
	hoverChunkIDRow = currentChunkID - 1; 
	// Draw the hover highlight
	draw_set_color(global.colorThemeSelected1);
	draw_set_alpha(0.5);
	draw_rectangle(topLeftX, topLeftY, bottomRightX, bottomRightY, false);
			
	if (device_mouse_check_button_released(0, mb_left)) {
		obj_control.clickedChunkID = currentChunkID; // Debug variable
		// Add this Chunk to a chain
		with (obj_chain) {
			scr_wordClicked(currentWordID, unitID);
		}
	}
			
	if (device_mouse_check_button_released(0, mb_right) and !instance_exists(obj_dialogueBox)and !instance_exists(obj_stackShow)) {

		//newWordHoverUnitID = unitID;
		//newWordHoverWordSeq = ds_grid_get(wordGrid, wordGrid_colWordSeq, currentWordID - 1);
		//newWordHoverWordID = currentWordID;

		if(!instance_exists(obj_dialogueBox)){
			//obj_control.rightClickWordID = obj_control.newWordHoverWordID;
			//obj_control.rightClickUnitID = obj_control.newWordHoverUnitID;
			//obj_control.rightClickWordSeq = obj_control.newWordHoverWordSeq;
				
			ds_grid_set(obj_chain.chunkGrid, obj_chain.chainGrid_colChainState, currentChunkID - 1, obj_chain.chainStateFocus);
			//show_message(string(currentChunkWordID));
			ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colFocused, currentWordID - 1, true);
			currentFocusedChunkID = currentChunkID;
		}

		obj_control.rightClickonWord = true;
		obj_control.wideDropDown = true;
		var dropDownOptionList = ds_list_create();
		if(scr_findInGridTwoParameters(obj_chain.linkGrid, obj_chain.linkGrid_colSource , obj_control.rightClickWordID, obj_chain.linkGrid_colDead, obj_chain.chainStateNormal) != -1){
			ds_list_add(dropDownOptionList,"Delete Chunk", "Delete Link");
		}
		else{
			ds_list_add(dropDownOptionList,"Delete Chunk");
		}
		if (ds_list_size(dropDownOptionList) > 0 and obj_control.ableToCreateDropDown) {
			var dropDownInst = instance_create_depth(mouse_x, mouse_y, -999, obj_dropDown);
			dropDownInst.optionList = dropDownOptionList;
			dropDownInst.optionListType = 8;
					
			obj_control.ableToCreateDropDown = false;
			obj_control.alarm[0] = 2;
		}

	}
}
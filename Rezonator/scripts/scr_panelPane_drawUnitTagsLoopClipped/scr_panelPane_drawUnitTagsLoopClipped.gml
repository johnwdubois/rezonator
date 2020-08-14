/*
    scr_panelPane_drawUnitTagsLoopClipped();
    
    Last Updated: 2019-12-28
    
    Called from: obj_panelPane
    
    Purpose: Draw the translation of each line in the Nav window
    
    Mechanism: loop through LineGrid and translate each line
    
    Author: Georgio Klironomos
*/

if (live_call()) return live_result;
// Access the lineList panelPane object to get it's scrollPlusY

var lineListPanelPaneInst = 0;//lineListPanelPaneInst;

with (obj_panelPane) {
	if (currentFunction == functionChainList) {
		lineListPanelPaneInst = self.id;
	}
}


draw_set_font(global.fontChainList);
var strHeight = string_height("0") * 1.5;

// Set text margin area
var filterRectMargin = 8;
var filterRectSize = (strHeight / 2) + 5;
var textMarginLeft = filterRectMargin;

var textMarginTop = functionChainList_tabHeight;
var textPlusY = 0;
var chainNameRectMinusY = 4;

var focusedElementY = -1;
var focusedLineNameRectY1 = -1;
var focusedLineNameRectY2 = -1;
var xbuffer = (windowWidth / 6);

var drawDropDowns = false;
if (!instance_exists(obj_dropDown)) {
	unitTagsHighlightRow = -1;
}



var headerListSize = unitContentsHeaderListSize;
unitContentsHeaderListSize = min(6,max(1,ds_grid_width(global.unitImportGrid)));
headerListSize = unitContentsHeaderListSize;


// Set opacity, font, and alignment of text chain lists
draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_set_color(global.colorThemeText);

//scr_surfaceStart();
// Not doing a surface here so it can scroll along with the left Navwindow

var lineGridHeight = ds_grid_height(obj_control.lineGrid);
var widthOfUnitGrid = 1;
if(ds_exists(global.unitImportColNameList, ds_type_list)){
widthOfUnitGrid = ds_list_size(global.unitImportColNameList);
}
//show_message(string(headerListSize));
for(var j = 0 ; j < headerListSize; j++) {
	
	textPlusY = 0;
	drawDropDowns = false;


    var colRectX1 = x + (j * (windowWidth / 6));
    var colRectY1 = y;
    var colRectX2 = colRectX1 + (windowWidth / 6);
    var colRectY2 = colRectY1 + windowHeight;
    
    draw_set_color(global.colorThemeBG);
    draw_rectangle(colRectX1 - clipX, colRectY1 - clipY, colRectX2 - clipX, colRectY2 - clipY, false);
    draw_set_color(global.colorThemeBorders);
    draw_rectangle(colRectX1 - clipX, colRectY1 - clipY, colRectX2 - clipX, colRectY2 - clipY, true);
	
	

	for (var i = 0; i < lineGridHeight; i++) {
    
	    if (y + textMarginTop + lineListPanelPaneInst.scrollPlusY + textPlusY < y - strHeight
	    or y + textMarginTop + lineListPanelPaneInst.scrollPlusY + textPlusY > y + windowHeight + strHeight) {
	        textPlusY += strHeight;
	        continue;
	    }
    
    
	    // Get grid info of current chain
	    var currentLineUnitID = ds_grid_get(obj_control.lineGrid, obj_control.lineGrid_colUnitID, i);
	    var currentLineState = ds_grid_get(obj_control.lineGrid, obj_control.lineGrid_colLineState, i);
	    var lineColor = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colParticipantColor, currentLineUnitID - 1); // Access color of line
	    var lineSpeaker = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colParticipantName, currentLineUnitID - 1);
	    // Prevent those pesky comments from showing up in the line list
	    if (lineSpeaker == "COMMENT") {
	        continue;
	    }
    
	    var discoColor = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colDiscoColor, currentLineUnitID - 1);
	    if (discoColor == -1 or discoColor == 0) {
	        discoColor = obj_control.c_ltblue;
	    }

	    var currentLineWordString = "";
	    if(ds_grid_height(global.importGrid) > 0) {
	        currentLineWordString = ds_grid_get(global.importGrid, 12, i + 1);
	    }
	    else {
	        var currentLineWordList = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colWordIDList, currentLineUnitID - 1);
	        var currentLineWordListSize = ds_list_size(currentLineWordList);
			for(var wordListLoop = 0; wordListLoop < currentLineWordListSize; wordListLoop++) {
	            var currentWordID = ds_list_find_value(currentLineWordList, wordListLoop);
	            var currentWordTranscript = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordTranscript, currentWordID - 1);
	            currentLineWordString += currentWordTranscript + " ";
	        }
	    }
    
	    // Get dimensions of rectangle around line name
	    var lineNameRectX1 = x;
	    var lineNameRectY1 = y + textMarginTop + textPlusY + lineListPanelPaneInst.scrollPlusY - (strHeight / 2);
	    var lineNameRectX2 = x + windowWidth;
	    var lineNameRectY2 = lineNameRectY1 + strHeight;
    
	    //Check mouse clicks to focus a line in the list
	    if (scr_pointInRectangleClippedWindow(mouse_x, mouse_y, lineNameRectX1, max(lineNameRectY1, y + textMarginTop), lineNameRectX2, lineNameRectY2)
		&& !instance_exists(obj_dialogueBox) && !instance_exists(obj_dropDown)) {
			drawDropDowns = true;
			unitTagsHighlightRow = i;
        
	        if (device_mouse_check_button_released(0, mb_left)) {
	            //show_message("line");
	            ds_grid_set_region(obj_control.lineGrid, obj_control.lineGrid_colLineState, 0, obj_control.lineGrid_colLineState, ds_grid_height(obj_control.lineGrid), 0);
	            ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colLineState, i, 1);
	            with (obj_panelPane) {
	                functionChainList_lineGridRowFocused = i;
	                functionChainContents_BGColor = lineColor;
	            }
	        }
	    }
		if (unitTagsHighlightRow == i && j > 0) {
			
			// dropdown buttons
			var dropDownButtonX1 = colRectX2 - sprite_get_width(spr_dropDown) - 4;
			var dropDownButtonY1 = lineNameRectY1;
			var dropDownButtonX2 = dropDownButtonX1 + sprite_get_width(spr_dropDown);
			var dropDownButtonY2 = lineNameRectY2;
			draw_sprite_ext(spr_dropDown, 0, mean(dropDownButtonX1, dropDownButtonX2) - clipX, mean(dropDownButtonY1, dropDownButtonY2) - clipY, 1, 1, 0, c_white, 1);
			if (point_in_rectangle(mouse_x, mouse_y, dropDownButtonX1, dropDownButtonY1, dropDownButtonX2, dropDownButtonY2)) {
				draw_set_alpha(1);
				draw_set_color(global.colorThemeBorders);
				draw_rectangle(dropDownButtonX1 - clipX, dropDownButtonY1 - clipY, dropDownButtonX2 - clipX, dropDownButtonY2 - clipY, true);
				
				if (mouse_check_button_released(mb_left)) {
					
					with (obj_panelPane) {
						selectedColUnit = j;
					}
								
					var dropDownOptionList = ds_list_create();
					var colIndex = ds_list_find_value(obj_control.currentDisplayUnitColsList, j - 1);
					var mapKey = ds_list_find_value(global.unitImportColNameList, colIndex);
					var tagMapList = ds_map_find_value(global.unitImportTagMap, mapKey);
					//show_message("tagMapList: " + scr_getStringOfList(tagMapList));
					ds_list_copy(dropDownOptionList, tagMapList);
					obj_control.unitImportColToChange = ds_list_find_value(obj_control.currentDisplayUnitColsList, j - 1);
					obj_control.unitImportRowToChange = currentLineUnitID - 1;
								
					var dropDownX = colRectX1;
					var dropDownY = lineNameRectY2;

					if (ds_list_size(dropDownOptionList) > 0 ) {
						var dropDownInst = instance_create_depth(dropDownX, dropDownY , -999, obj_dropDown);
						dropDownInst.optionList = dropDownOptionList;
						dropDownInst.optionListType = 38;

					}
		
					
				}
			}
			
			// highlight rectangle
			if (j == headerListSize - 1) {
				draw_set_alpha(0.2);
				draw_set_color(global.colorThemeText);
				draw_rectangle(lineNameRectX1 - clipX, lineNameRectY1 - clipY, lineNameRectX2 - clipX, lineNameRectY2 - clipY, false);
			}
		}
		draw_set_alpha(1);
    
    
	    //Color codes the line lists for User
	    draw_set_color(discoColor); //soften the color
	    //draw_set_color(lineColor);
	    //draw_rectangle(lineNameRectX1 - clipX, lineNameRectY1 - clipY, lineNameRectX2 - clipX, lineNameRectY2 - clipY - 2, false);
    
	    // Outline the rectangle in black
	    if (currentLineState == 1) {
	        focusedLineNameRectY1 = lineNameRectY1;
	        focusedLineNameRectY2 = lineNameRectY2;
	        focusedElementY = y + textMarginTop + lineListPanelPaneInst.scrollPlusY + textPlusY;
	        draw_set_font(global.fontChainListFocused);
	    }
	    else {
	        draw_set_font(global.fontMain);
	    }
    
	    // Draw text of chain names
	    draw_set_color(global.colorThemeText);
	    draw_set_halign(fa_left);
	    draw_set_valign(fa_middle);
	    //draw_text(x + (textMarginLeft/2) - clipX - (string_width(currentLineUnitID)/2), y + textMarginTop + lineListPanelPaneInst.scrollPlusY + textPlusY - clipY, string(currentLineUnitID));
    
	    //Color codes the line lists for User
	    draw_set_color(merge_color(lineColor, global.colorThemeBG, 0.4)); //soften the color
	    //draw_set_color(lineColor);
	    //draw_rectangle(x + (textMarginLeft) - clipX, lineNameRectY1 - clipY, lineNameRectX2 - clipX, lineNameRectY2 - clipY - 2, false);
	    draw_set_color(global.colorThemeText);
		
		var tagToDraw = ds_grid_get(global.unitImportGrid,j,i);
		
		var importCol = ds_list_find_value(obj_control.currentDisplayUnitColsList, j-1);
		//show_message(string(importcol));
		if( importCol != undefined ){
			tagToDraw =string(ds_grid_get(global.unitImportGrid, importCol, i));
		}
		else{
			tagToDraw = ds_grid_get(global.unitImportGrid,j,i);
		}
		
		
		
		if(tagToDraw == undefined){
			tagToDraw = "";
		}
	    draw_text(x + (textMarginLeft) + (xbuffer*j) - clipX, y + textMarginTop + lineListPanelPaneInst.scrollPlusY + textPlusY - clipY, string(tagToDraw));
    
	    //draw_set_color(merge_color(lineColor, global.colorThemeBG, 0.4)); //soften the color
	    draw_set_color(global.colorThemeBG);
	    //draw_rectangle(windowWidth/3 - 10, lineNameRectY1 - clipY, lineNameRectX2 - clipX, lineNameRectY2 - clipY - 2, false);
	    draw_set_color(global.colorThemeBG);
	    //draw_line_width(windowWidth/3 - 10, lineNameRectY1 - clipY, windowWidth/3 - 10, lineNameRectY2 - clipY - 2, 1);
	    draw_set_color(global.colorThemeText);
	    //draw_text(windowWidth/3, y + textMarginTop + lineListPanelPaneInst.scrollPlusY + textPlusY - clipY, currentLineWordString);
    
    
    
	    // Get height of chain name
	    textPlusY += strHeight;
	}

}



//draw hover selection
if (focusedLineNameRectY1 > -1 and focusedLineNameRectY2 > -1) {
    draw_set_color(global.colorThemeBorders);
    for (var j = 0; j < 3; j++) {
        draw_rectangle(x + j - clipX, focusedLineNameRectY1 + j - clipY, x + windowWidth - j - clipX, focusedLineNameRectY2 - j - clipY, true);
    }
}





//draw unit Tabs


var tabHeight = functionChainList_tabHeight;
draw_set_color(global.colorThemeBG);
draw_rectangle(x - clipX, colRectY1 - clipY, colRectX2 - clipX, colRectY1 + tabHeight - clipY, false);


/*if(obj_control.showDevVars) {
    headerListSize = 6;
}*/
// Create the column headers
var activeCols = 0;
for (var i = 0; i < headerListSize; i++) {
    var colRectX1 = x + (i * (windowWidth / 6));
    var colRectY1 = y;
    var colRectX2 = colRectX1 + (windowWidth / 6);
	var colWidth = colRectX2 - colRectX1;
    if (i == 5) {
        //var colRectX2 = colRectX1 + (windowWidth);    
    }
    var colRectY2 = colRectY1 + windowHeight;
    
    var colName = "";
    
	var nameFromList =  ds_list_find_value(global.unitImportColNameList, i);
	if(i != 0){
		var unitColValue = ds_list_find_value(obj_control.currentDisplayUnitColsList, i-1);
		//show_message(unitColValue);
		nameFromList = ds_list_find_value(global.unitImportColNameList, unitColValue);
	}	
	if(nameFromList == undefined){
			nameFromList = "";
	}
	colName = nameFromList
    
    draw_set_color(global.colorThemeBG);
    //draw_rectangle(colRectX1 - clipX, colRectY1 - clipY, colRectX2 - clipX, colRectY1 + tabHeight - clipY, false);
    draw_set_color(global.colorThemeBorders);
    draw_rectangle(colRectX1 - clipX, colRectY1 - clipY, colRectX2 - clipX, colRectY1 + tabHeight - clipY, true);
    draw_set_color(global.colorThemeText);
    draw_set_valign(fa_top);
    draw_set_font(global.fontPanelTab);
    draw_text(colRectX1 + 4 - clipX, y - clipY, colName);






	
	// draw wordView button
	var wordViewButtonSize = (tabHeight / 3);
	var wordViewButtonX = colRectX2 - wordViewButtonSize - 4;
	var wordViewButtonY = colRectY1 + (tabHeight / 2);
	
	
	//draw token selection button
	var dropDownButtonSize = sprite_get_width(spr_dropDown);
	var dropDownRectX1 = wordViewButtonX - 16 - dropDownButtonSize;
	var dropDownRectY1 = y + (dropDownButtonSize * 0.2);
	var dropDownRectX2 = dropDownRectX1 + dropDownButtonSize;
	var dropDownRectY2 = y + tabHeight - (dropDownButtonSize * 0.2);
	


	
	if(i == 0 ){
	}
	else{
		var tempColRectX2 = x + ((activeCols + 1) * (windowWidth / 6)) - (windowWidth / 6);
		if (point_in_rectangle(mouse_x, mouse_y, colRectX1, colRectY1, colRectX2, colRectY1 + tabHeight)) {
			if (mouse_check_button_released(mb_right)) {
				with (obj_dropDown) {
					instance_destroy();
				}
				var dropDownOptionList = ds_list_create();		
				ds_list_add(dropDownOptionList, "Create Field");
				if (ds_list_size(dropDownOptionList) > 0) {
					var dropDownInst = instance_create_depth(colRectX1, colRectY1 + tabHeight, -999, obj_dropDown);
					dropDownInst.optionList = dropDownOptionList;
					dropDownInst.optionListType = 37;
				}
			}
		}
		
		
		//user interaction for token selection
		if (point_in_rectangle(mouse_x, mouse_y, dropDownRectX1, dropDownRectY1, dropDownRectX2, dropDownRectY2)) {
			draw_set_color(global.colorThemeBorders);
			draw_rectangle(dropDownRectX1- clipX, dropDownRectY1 - clipY, dropDownRectX2 - clipX, dropDownRectY2 - clipY, true);

			//ascendYScale = (ascendActivated) ? 1 : -1;
			if (mouse_check_button_released(mb_left)) {
				with(obj_panelPane){
					chosenCol = i;
				}
				if(ascendActivated == false){
					ascendActivated = true;
				}
				else{
					ascendActivated = false;
				}
				if(ascendActivated){
					ascendYScale = -1;
				}
				else{
					ascendYScale = 1;
				}

				var dropDownOptionList = ds_list_create();

				ds_list_copy(dropDownOptionList, global.unitImportColNameList);

				if (ds_list_size(dropDownOptionList) > 0 ) {
					var dropDownInst = instance_create_depth(colRectX1,colRectY1+tabHeight , -999, obj_dropDown);
					dropDownInst.optionList = dropDownOptionList;
					dropDownInst.optionListType = 31;
					
					//obj_control.ableToCreateDropDown = false;
					//obj_control.alarm[0] = 2;
				}
			}
			if(ascendActivated == false) {
				with(obj_dropDown) {
					instance_destroy();
					ascendYScale = 1;
					ascendActivated = false;
				}
			}
		}
		

	
	
		//user interaction for display view change
		if (point_in_circle(mouse_x, mouse_y, wordViewButtonX, wordViewButtonY, wordViewButtonSize)) {
			draw_set_color(global.colorThemeSelected2);
			draw_circle(wordViewButtonX - clipX, wordViewButtonY - clipY, wordViewButtonSize * 0.75, false);
			if (mouse_check_button_released(mb_left)) {
				obj_control.unitView = i;
			
				var toggleTranscriptionGrid = -1;
				var toggleTranscriptionCol = -1;

				toggleTranscriptionGrid = global.unitImportGrid;

				var colIndex =  ds_list_find_value(obj_control.currentDisplayUnitColsList,obj_control.unitView-1);
				toggleTranscriptionCol = colIndex;

				
				scr_toggleUnitMulti(toggleTranscriptionGrid, toggleTranscriptionCol);
			}
		}
	

		draw_set_color(global.colorThemeBorders);
		draw_circle(wordViewButtonX - clipX, wordViewButtonY - clipY, wordViewButtonSize, true);
		draw_sprite_ext(spr_dropDown, 0, mean(dropDownRectX1, dropDownRectX2) - clipX, mean(dropDownRectY1, dropDownRectY2) - clipY, 1, 1, 0, c_white, 1);
	
	


		if (obj_control.unitView == i) {
			draw_set_color(global.colorThemeBorders);
			draw_circle(wordViewButtonX - clipX, wordViewButtonY - clipY, wordViewButtonSize * 0.75, false);
			draw_set_color(global.colorThemeBG);
		}
		else {
			draw_set_color(global.colorThemeText);
		}

	
	}
	
	activeCols++;
}








// will create a focusedLine vriable in panelPane create, update it when changed, no gridValueY

// Allows use of arrow keys, pgUp/pgDwn, and ctrl+key in chain list if clicked in chainList
if (clickedIn) {    
    if ((mouse_wheel_up() or keyboard_check(vk_up)) and (holdUp < 2 or holdUp > 30)) {
            
        if (functionChainList_lineGridRowFocused > 0 and functionChainList_lineGridRowFocused < ds_grid_height(obj_control.lineGrid)) {

            //Allow for arrow keys to shift focus down the list of lines
            obj_panelPane.functionChainList_lineGridRowFocused--;
            var currentLineUnitID = ds_grid_get(obj_control.lineGrid, obj_control.lineGrid_colUnitID, obj_panelPane.functionChainList_lineGridRowFocused);
            var lineColor = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colParticipantColor, currentLineUnitID - 1);
            obj_panelPane.functionChainContents_BGColor = lineColor;
            ds_grid_set_region(obj_control.lineGrid, obj_control.lineGrid_colLineState, 0, obj_control.lineGrid_colLineState, ds_grid_height(obj_control.lineGrid), 0);
            ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colLineState, obj_panelPane.functionChainList_lineGridRowFocused, 1);
            
            
        //    ds_grid_set(grid, obj_chain.chainGrid_colChainState, focusedChainRow, obj_chain.chainStateFocus);
            if (focusedElementY <= y + textMarginTop + strHeight) {
                lineListPanelPaneInst.scrollPlusYDest += max(abs(focusedElementY - (y + textMarginTop + strHeight)) + strHeight, strHeight);
            }
        }
        else {
            lineListPanelPaneInst.scrollPlusYDest += 4;
        }
    }
        
    if ((mouse_wheel_down() || keyboard_check(vk_down)) and (obj_panelPane.holdDown < 2 || obj_panelPane.holdDown > 30)) {
            
        if (functionChainList_lineGridRowFocused < ds_grid_height(obj_control.lineGrid) - 1 and functionChainList_lineGridRowFocused >= 0) {

            //Allow for arrow keys to shift focus down the list of lines
            obj_panelPane.functionChainList_lineGridRowFocused++;
            var currentLineUnitID = ds_grid_get(obj_control.lineGrid, obj_control.lineGrid_colUnitID, obj_panelPane.functionChainList_lineGridRowFocused);
            var lineColor = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colParticipantColor, currentLineUnitID - 1);
            obj_panelPane.functionChainContents_BGColor = lineColor;
            ds_grid_set_region(obj_control.lineGrid, obj_control.lineGrid_colLineState, 0, obj_control.lineGrid_colLineState, ds_grid_height(obj_control.lineGrid), 0);
            ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colLineState, obj_panelPane.functionChainList_lineGridRowFocused, 1);
            
            //ds_grid_set(grid, obj_chain.chainGrid_colChainState, focusedChainRow, obj_chain.chainStateFocus);
            if (focusedElementY >= y + windowHeight - strHeight) {
                lineListPanelPaneInst.scrollPlusYDest -= max(abs(focusedElementY - (y + windowHeight - strHeight)) + strHeight, strHeight);
            }
        }
        else {
            lineListPanelPaneInst.scrollPlusYDest -= 4;
        }
    }
    
    // CTRL+UP and CTRL+DOWN
    if (keyboard_check(vk_control) && keyboard_check_pressed(vk_up)) {
        lineListPanelPaneInst.scrollPlusYDest = 100;
    }
    if (keyboard_check(vk_control) && keyboard_check_pressed(vk_down)) {
        lineListPanelPaneInst.scrollPlusYDest = -999999999999;
    }
    
    // PAGEUP and PAGEDOWN
    if (keyboard_check_pressed(vk_pageup)) {
        lineListPanelPaneInst.scrollPlusYDest += (windowHeight);
    }
    if (keyboard_check_pressed(vk_pagedown)) {
        lineListPanelPaneInst.scrollPlusYDest -= (windowHeight);
    }
}



/*scr_scrollBar(ds_grid_height(obj_control.lineGrid), focusedElementY, strHeight, textMarginTop,
    global.colorThemeSelected1, global.colorThemeSelected2,
    global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, windowWidth, windowHeight);*/




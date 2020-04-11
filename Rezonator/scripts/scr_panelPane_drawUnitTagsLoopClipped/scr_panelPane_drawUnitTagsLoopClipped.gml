/*
    scr_panelPane_drawUnitTagsLoopClipped();
    
    Last Updated: 2019-12-28
    
    Called from: obj_panelPane
    
    Purpose: Draw the translation of each line in the Nav window
    
    Mechanism: loop through LineGrid and translate each line
    
    Author: Georgio Klironomos
*/


// Access the lineList panelPane object to get it's scrollPlusY
var lineListPanelPaneInst = inst_PanelPane_chainList;


draw_set_font(global.fontChainList);
var strHeight = string_height("0") * 1.5;

// Set text margin area
var filterRectMargin = 8;
var filterRectSize = (strHeight / 2) + 5;
var textMarginLeft = filterRectMargin + (filterRectSize * 2);

var textMarginTop = functionChainList_tabHeight;
var textPlusY = 0;
var chainNameRectMinusY = 4;

var focusedElementY = -1;
var focusedLineNameRectY1 = -1;
var focusedLineNameRectY2 = -1;


// Set opacity, font, and alignment of text chain lists
draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_set_color(global.colorThemeText);

//scr_surfaceStart();
// Not doing a surface here so it can scroll along with the left Navwindow

for (var i = 0; i < ds_grid_height(obj_control.lineGrid); i++) {
    
    if (y + textMarginTop + inst_PanelPane_chainList.scrollPlusY + textPlusY < y - strHeight
    or y + textMarginTop + inst_PanelPane_chainList.scrollPlusY + textPlusY > y + windowHeight + strHeight) {
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
        for(var wordListLoop = 0; wordListLoop < ds_list_size(currentLineWordList); wordListLoop++) {
            var currentWordID = ds_list_find_value(currentLineWordList, wordListLoop);
            var currentWordTranscript = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordTranscript, currentWordID - 1);
            currentLineWordString += currentWordTranscript + " ";
        }
    }
    
    // Get dimensions of rectangle around line name
    var lineNameRectX1 = x;
    var lineNameRectY1 = y + textMarginTop + textPlusY + inst_PanelPane_chainList.scrollPlusY - (strHeight / 2);
    var lineNameRectX2 = x + windowWidth;
    var lineNameRectY2 = lineNameRectY1 + strHeight;
    
    //Check mouse clicks to focus a line in the list
    if (scr_pointInRectangleClippedWindow(mouse_x, mouse_y, lineNameRectX1, lineNameRectY1, lineNameRectX2, lineNameRectY2)) {
        //if (obj_control.showDevVars) {
            draw_set_color(c_red);
            draw_circle(mouse_x, mouse_y, 5, true);
        //}
        
        if (device_mouse_check_button_released(0, mb_left) and not instance_exists(obj_dialogueBox) and not instance_exists(obj_dropDown)) {
            //show_message("line");
            ds_grid_set_region(obj_control.lineGrid, obj_control.lineGrid_colLineState, 0, obj_control.lineGrid_colLineState, ds_grid_height(obj_control.lineGrid), 0);
            ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colLineState, i, 1);
            with (obj_panelPane) {
                functionChainList_lineGridRowFocused = i;
                functionChainContents_BGColor = lineColor;
            }
        }
    }
    
    
    //Color codes the line lists for User
    draw_set_color(discoColor); //soften the color
    //draw_set_color(lineColor);
    //draw_rectangle(lineNameRectX1 - clipX, lineNameRectY1 - clipY, lineNameRectX2 - clipX, lineNameRectY2 - clipY - 2, false);
    
    // Outline the rectangle in black
    if (currentLineState == 1) {
        focusedLineNameRectY1 = lineNameRectY1;
        focusedLineNameRectY2 = lineNameRectY2;
        focusedElementY = y + textMarginTop + inst_PanelPane_chainList.scrollPlusY + textPlusY;
        draw_set_font(global.fontChainListFocused);
    }
    else {
        draw_set_font(global.fontMain);
    }
    
    // Draw text of chain names
    draw_set_color(global.colorThemeText);
    draw_set_halign(fa_left);
    draw_set_valign(fa_middle);
    //draw_text(x + (textMarginLeft/2) - clipX - (string_width(currentLineUnitID)/2), y + textMarginTop + inst_PanelPane_chainList.scrollPlusY + textPlusY - clipY, string(currentLineUnitID));
    
    //Color codes the line lists for User
    draw_set_color(merge_color(lineColor, global.colorThemeBG, 0.4)); //soften the color
    //draw_set_color(lineColor);
    //draw_rectangle(x + (textMarginLeft) - clipX, lineNameRectY1 - clipY, lineNameRectX2 - clipX, lineNameRectY2 - clipY - 2, false);
    draw_set_color(global.colorThemeText);
    draw_text(x + (textMarginLeft) - clipX + 10, y + textMarginTop + inst_PanelPane_chainList.scrollPlusY + textPlusY - clipY, "Tag");
    
    //draw_set_color(merge_color(lineColor, global.colorThemeBG, 0.4)); //soften the color
    draw_set_color(global.colorThemeBG);
    //draw_rectangle(windowWidth/3 - 10, lineNameRectY1 - clipY, lineNameRectX2 - clipX, lineNameRectY2 - clipY - 2, false);
    draw_set_color(global.colorThemeBG);
    //draw_line_width(windowWidth/3 - 10, lineNameRectY1 - clipY, windowWidth/3 - 10, lineNameRectY2 - clipY - 2, 1);
    draw_set_color(global.colorThemeText);
    //draw_text(windowWidth/3, y + textMarginTop + inst_PanelPane_chainList.scrollPlusY + textPlusY - clipY, currentLineWordString);
    
    
    
    // Get height of chain name
    textPlusY += strHeight;
}
var tabHeight = functionChainList_tabHeight;

var headerListSize = 3;
if(functionChainList_currentTab == functionChainList_tabLine && obj_control.showDevVars) {
    headerListSize = lineContentsHeaderListSize;
}
/*if(obj_control.showDevVars) {
    headerListSize = 6;
}*/
// Create the column headers
for (var i = 0; i < headerListSize; i++) {
    var colRectX1 = x + (i * (windowWidth / 6));
    var colRectY1 = y;
    var colRectX2 = colRectX1 + (windowWidth / 6);
    if (i == 5) {
        var colRectX2 = colRectX1 + (windowWidth);    
    }
    var colRectY2 = colRectY1 + windowHeight;
    
    var colName = "";
    
	// Some hard coded fun!
    switch (functionChainContents_infoCol[i]) {
        case 0:
            colName = "Tag1";
            break;
        case 1:
            colName = "Tag2";
            break;
        case 2:
            colName = "Tag3";
            break;
        case 3:
            colName = obj_control.dynamicWordGrid_colTag1Label; // Will use an object variable to hold the user's custom names
            break;
        case 4:
            colName = obj_control.dynamicWordGrid_colTag2Label;
            break;
        case 5:
            colName = obj_control.dynamicWordGrid_colTag3Label;
            break;
        default:
            colName = "N/A";
            break;
    }
    
    draw_set_color(global.colorThemeBG);
    draw_rectangle(colRectX1 - clipX, colRectY1 - clipY, colRectX2 - clipX, colRectY1 + tabHeight - clipY, false);
    draw_set_color(global.colorThemeBorders);
    draw_rectangle(colRectX1 - clipX, colRectY1 - clipY, colRectX2 - clipX, colRectY2 - clipY, true);
    draw_set_color(global.colorThemeText);
    draw_set_valign(fa_top);
    draw_set_font(global.fontPanelTab);
    draw_text(colRectX1 + 4 - clipX, y - clipY, colName);
    if(obj_control.showDevVars) {
        if(i == headerListSize - 1) {
            var buttonRectSize = (tabHeight) - 8;
            var newCategoryRectX1 = colRectX2 + buttonRectSize + 2;
            var newCategoryRectY1 = colRectY1 + 4;
            var newCategoryRectX2 = newCategoryRectX1 + buttonRectSize;
            var newCategoryRectY2 = newCategoryRectY1 + buttonRectSize;
        
            draw_set_color(global.colorThemeText);
            draw_sprite_ext(spr_filterIcons, 1, mean(newCategoryRectX1 - clipX, newCategoryRectX2 - clipX), mean(newCategoryRectY1 - clipY, newCategoryRectY2 - clipY), 1, 1, 0, c_white, 1);
            
            if (point_in_rectangle(mouse_x, mouse_y, newCategoryRectX1, newCategoryRectY1, newCategoryRectX2, newCategoryRectY2)) {
                draw_set_color(global.colorThemeBorders);
                draw_rectangle(newCategoryRectX1 - clipX, newCategoryRectY1 - clipY, newCategoryRectX2 - clipX, newCategoryRectY2 - clipY, true);
                if (mouse_check_button_released(mb_left)) {
                    //show_message("YO");
                    obj_panelPane.lineContentsHeaderListSize++;
                    //show_message(obj_panelPane.lineContentsHeaderListSize);
                    if (!obj_control.dialogueBoxActive) {
                        keyboard_string = "";
                        obj_control.newTagCategory = true;
                    }

                    obj_control.dialogueBoxActive = true;

                    if (!instance_exists(obj_dialogueBox)) {
                        instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
                    }
                }
            }
        }
    
        if(i > 2) {
            var buttonRectSize = (tabHeight) - 8;
            var newCategoryRectX1 = colRectX2 - buttonRectSize*2 - 2;
            var newCategoryRectY1 = colRectY1 + 4;
            var newCategoryRectX2 = newCategoryRectX1 + buttonRectSize;
            var newCategoryRectY2 = newCategoryRectY1 + buttonRectSize;
        
            draw_set_color(global.colorThemeText);
            draw_sprite_ext(spr_filterIcons, 1, mean(newCategoryRectX1 - clipX, newCategoryRectX2 - clipX), mean(newCategoryRectY1 - clipY, newCategoryRectY2 - clipY), 1, 1, 0, c_white, 1);
            
            if (point_in_rectangle(mouse_x, mouse_y, newCategoryRectX1, newCategoryRectY1, newCategoryRectX2, newCategoryRectY2)) {
                draw_set_color(global.colorThemeBorders);
                draw_rectangle(newCategoryRectX1 - clipX, newCategoryRectY1 - clipY, newCategoryRectX2 - clipX, newCategoryRectY2 - clipY, true);
                if (mouse_check_button_released(mb_left)) {
                    show_message("Add Tag");
                    /*lineContentsHeaderListSize++;
                    if (!obj_control.dialogueBoxActive) {
                        keyboard_string = "";
                        obj_control.newTag = true;
                    }

                    obj_control.dialogueBoxActive = true;

                    if (!instance_exists(obj_dialogueBox)) {
                        instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
                    }*/
                }
            }
        
            var buttonRectSize = (tabHeight) - 8;
            var newCategoryRectX1 = colRectX2 - buttonRectSize - 2;
            var newCategoryRectY1 = colRectY1 + 4;
            var newCategoryRectX2 = newCategoryRectX1 + buttonRectSize;
            var newCategoryRectY2 = newCategoryRectY1 + buttonRectSize;
        
            draw_set_color(global.colorThemeText);
            draw_sprite_ext(spr_filterIcons, 1, mean(newCategoryRectX1 - clipX, newCategoryRectX2 - clipX), mean(newCategoryRectY1 - clipY, newCategoryRectY2 - clipY), 1, 1, 0, c_white, 1);
            
            if (point_in_rectangle(mouse_x, mouse_y, newCategoryRectX1, newCategoryRectY1, newCategoryRectX2, newCategoryRectY2)) {
                draw_set_color(global.colorThemeBorders);
                draw_rectangle(newCategoryRectX1 - clipX, newCategoryRectY1 - clipY, newCategoryRectX2 - clipX, newCategoryRectY2 - clipY, true);
                if (mouse_check_button_released(mb_left)) {
                    show_message("Remove Tag");
                    /*lineContentsHeaderListSize++;
                    if (!obj_control.dialogueBoxActive) {
                        keyboard_string = "";
                        obj_control.newTag = true;
                    }

                    obj_control.dialogueBoxActive = true;

                    if (!instance_exists(obj_dialogueBox)) {
                        instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
                    }*/
                }
            }
        }
    }
    
    /*if (functionChainContents_infoCol[i] == 3 && obj_control.showDevVars) {
        draw_set_color(global.colorThemeText);
        if (point_in_rectangle(mouse_x, mouse_y, colRectX1, colRectY1, colRectX2, colRectY1 + tabHeight)) {
            //show_message("YO");
            draw_set_color(global.colorThemeBorders);
            draw_set_alpha(0.5);
            draw_rectangle(colRectX1 - clipX, colRectY1 - clipY, colRectX2 - clipX, colRectY1 + tabHeight - clipY, false);
            if (mouse_check_button_released(mb_left)) {
                show_message("YO");
            }
        }
        draw_set_color(global.colorThemeText);
    }
    
    // draw toggleDraw button
            var buttonRectSize = (tabRectY2 - tabRectY1) - 8;
            var toggleDrawRectX1 = tabRectX2 - buttonRectSize - 4;
            var toggleDrawRectY1 = tabRectY1 + 4;
            var toggleDrawRectX2 = toggleDrawRectX1 + buttonRectSize;
            var toggleDrawRectY2 = toggleDrawRectY1 + buttonRectSize;
        
            draw_sprite_ext(spr_toggleDraw, obj_chain.toggleDrawRez, mean(toggleDrawRectX1, toggleDrawRectX2), mean(toggleDrawRectY1, toggleDrawRectY2), 1, 1, 0, c_white, 1);
            
            if (point_in_rectangle(mouse_x, mouse_y, toggleDrawRectX1, toggleDrawRectY1, toggleDrawRectX2, toggleDrawRectY2)) {
                draw_set_color(global.colorThemeBorders);
                draw_rectangle(toggleDrawRectX1, toggleDrawRectY1, toggleDrawRectX2, toggleDrawRectY2, true);
                if (mouse_check_button_released(mb_left)) {
                    show_message("YO");
                }
            }
    */
}

//var focusedChainRow = ds_grid_value_y(grid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(grid), obj_chain.chainStateFocus);

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
                inst_PanelPane_chainList.scrollPlusYDest += max(abs(focusedElementY - (y + textMarginTop + strHeight)) + strHeight, strHeight);
            }
        }
        else {
            inst_PanelPane_chainList.scrollPlusYDest += 4;
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
                inst_PanelPane_chainList.scrollPlusYDest -= max(abs(focusedElementY - (y + windowHeight - strHeight)) + strHeight, strHeight);
            }
        }
        else {
            inst_PanelPane_chainList.scrollPlusYDest -= 4;
        }
    }
    
    // CTRL+UP and CTRL+DOWN
    if (keyboard_check(vk_control) && keyboard_check_pressed(vk_up)) {
        inst_PanelPane_chainList.scrollPlusYDest = 100;
    }
    if (keyboard_check(vk_control) && keyboard_check_pressed(vk_down)) {
        inst_PanelPane_chainList.scrollPlusYDest = -999999999999;
    }
    
    // PAGEUP and PAGEDOWN
    if (keyboard_check_pressed(vk_pageup)) {
        inst_PanelPane_chainList.scrollPlusYDest += (windowHeight);
    }
    if (keyboard_check_pressed(vk_pagedown)) {
        inst_PanelPane_chainList.scrollPlusYDest -= (windowHeight);
    }
}

if (focusedLineNameRectY1 > -1 and focusedLineNameRectY2 > -1) {
    draw_set_color(global.colorThemeBorders);
    for (var j = 0; j < 3; j++) {
        draw_rectangle(x + j - clipX, focusedLineNameRectY1 + j - clipY, x + windowWidth - j - clipX, focusedLineNameRectY2 - j - clipY, true);
    }
}




/*scr_scrollBar(ds_grid_height(obj_control.lineGrid), focusedElementY, strHeight, textMarginTop,
    global.colorThemeSelected1, global.colorThemeSelected2,
    global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, windowWidth, windowHeight);*/




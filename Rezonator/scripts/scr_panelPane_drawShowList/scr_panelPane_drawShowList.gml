

function scr_panelPane_drawShowList() {
	
	var strHeight = string_height("0") * 1.5;
	var numColX = x;
	var numColWidth = windowWidth * 0.1;
	var nameColX = numColX + numColWidth;
	var nameColWidth = windowWidth * 0.7;
	var startColX = nameColX + nameColWidth;
	
	var textBuffer = 8;
	var headerHeight = functionTabs_tabHeight;
	var textPlusY = 0;
	var textAdjustY = 0;
	var drawScrollbar = true;
	
	var anyOptionMousedOver = false;
	var mouseoverScrollBar = (drawScrollbar) ? point_in_rectangle(mouse_x, mouse_y, x + windowWidth - global.scrollBarWidth, y, x + windowWidth, y + windowHeight) : false;
	
	// get the instance ID for the showContents pane so we can easily reference it
	var chainContentsPanelPaneInst = 0;
	with (obj_panelPane) {
		if (currentFunction == functionChainContents) {
			chainContentsPanelPaneInst = self.id;
		}
	}
	var relativeScrollPlusY = (drawScrollbar) ? scrollPlusY : chainContentsPanelPaneInst.scrollPlusY;
	
	// get the show list & make sure it exists
	var showList = global.nodeMap[? "showList"];
	if (!scr_isNumericAndExists(showList, ds_type_list)) {
		show_debug_message("scr_panelPane_drawShowList ... showList does not exist");
		exit;
	}
	var showListSize = ds_list_size(showList);
	
	scr_surfaceStart();
	
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_set_alpha(1);
	var setList = "";
	var setListSize = 0;
	
	// loop over shows
	for (var i = 0; i < showListSize; i++) {
		
		// get data for currentShow
		var currentShow = showList[| i];
		var currentShowSubMap = global.nodeMap[? currentShow];
		if (!scr_isNumericAndExists(currentShowSubMap, ds_type_map)) continue;
		
		if (scr_isNumericAndExists(currentShowSubMap,ds_type_map)) {
			setList = currentShowSubMap[? "setIDList"];
			if (scr_isNumericAndExists(setList, ds_type_list)) {
				setListSize = ds_list_size(setList);
			}
		}
		var currentShowName = currentShowSubMap[? "name"];
		var currentShowSetList = currentShowSubMap[? "setIDList"];
		var currentShowPlaying = (functionChainList_playShowID == currentShow);
		
		
		// Get dimensions of rectangle around show name
		var showRectX1 = x;
		var showRectY1 = y + headerHeight + relativeScrollPlusY + textPlusY - (strHeight / 2);
		var showRectX2 = x + windowWidth;
		var showRectY2 = showRectY1 + strHeight;
		var mouseoverShowRect = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, showRectX1, showRectY1, showRectX2, showRectY2) && !mouseoverScrollBar;
		var highlight = (mouseoverShowRect || functionChainContents_showID == currentShow);
		var textY = floor(mean(showRectY1, showRectY2));
		
		// click on show name
		if (mouseoverShowRect) {
			anyOptionMousedOver = true;
			if (mouse_check_button_released(mb_left) && !instance_exists(obj_dropDown)) {
				with (obj_panelPane) functionChainContents_showID = currentShow;
				obj_control.selectedChainID = functionChainContents_showID;
			}
			
			if (mouse_check_button_released(mb_right)) {
				with (obj_panelPane) functionChainContents_showID = currentShow;
				obj_control.selectedChainID = functionChainContents_showID;
				var dropDownOptionList = ds_list_create();

				ds_list_add(dropDownOptionList, "help_label_rename", "help_label_delete_plain");

				if (ds_list_size(dropDownOptionList) > 0 and obj_control.ableToCreateDropDown) {
					scr_createDropDown(mouse_x, mouse_y, dropDownOptionList, global.optionListTypeShowList);
				}
			
			}
		}

		
		// draw rect
		var rectColor = (currentShowPlaying) ? global.colorThemeSelected2 : merge_color(global.colorThemeBG, global.colorThemeSelected1, highlight ? 0.8 : 0.4);
		var textColor = (currentShowPlaying) ? global.colorThemeBG : global.colorThemeText;
		draw_set_color(rectColor);
		draw_rectangle(showRectX1 - clipX, showRectY1 - clipY, showRectX2 - clipX, showRectY2 - clipY, false);
		
		// # column
		draw_set_color(textColor);
		draw_text(floor(numColX + textBuffer) - clipX, textY - clipY, string(i + 1));
		
		// name column
		draw_set_color(textColor);
		draw_text(floor(nameColX + textBuffer) - clipX, textY - clipY, string(currentShowName));
		var startStopText = "";
		
		// start column
		if (mouseoverShowRect || currentShowPlaying) {
			
			var mouseoverStartCol = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, startColX, showRectY1, showRectX2, showRectY2) && !instance_exists(obj_dropDown) && !instance_exists(obj_dialogueBox) && ds_list_size(currentShowSetList) > 0;
			var startArrowScale = (mouseoverStartCol || currentShowPlaying) ? 1.5 : 1;
			
			if (mouseoverShowRect && setListSize > 0) {
				startStopText = "  ►  ";
			}
			
			if (currentShowPlaying) {
				startStopText =  "  ■  ";
			}
			
			draw_set_halign(fa_center);
			draw_set_valign(fa_middle);
			draw_text(mean(startColX, x + windowWidth) - clipX, mean(showRectY1, showRectY2) - clipY, startStopText);
			draw_set_halign(fa_left);
			draw_set_valign(fa_middle);
			if (mouseoverStartCol && mouse_check_button_released(mb_left)) {
				
				if (!currentShowPlaying) {
					if (scr_isNumericAndExists(setList, ds_type_list)) {
									
						with (obj_panelPane) {
							functionChainList_playShowID = currentShow;
						}
									
						scr_setValueForAllChains("stack", false, "filter", false);
						// Filter the first current stack
						var currentStackID = ds_list_find_value(setList, 0);
						if (ds_list_find_index(obj_chain.filteredStackChainList,currentStackID) == -1) {
							ds_list_add(obj_chain.filteredStackChainList,currentStackID);
							var chainSubMap = ds_map_find_value(global.nodeMap,currentStackID);
							if (scr_isNumericAndExists(chainSubMap,ds_type_map)) {
								chainSubMap[? "filter"] = true;
							}
						}
					}
					// Render the filter in the mainscreen
					with (obj_control) {
						scr_renderFilter2();
					}
				}
				else {
					
					scr_setValueForAllChains("stack", false, "filter", false);
					with (obj_panelPane) {
						functionChainList_playShowID = "";
					}				
					with (obj_control) {
						scr_renderFilter2();	
					}
				}
			}
		}

		
		// increment plusY
		textPlusY += strHeight;
		
	}
	
	
	// draw "create show" option at end of list
	var createShowRectX1 = x;
	var createShowRectY1 = y + headerHeight + relativeScrollPlusY + textPlusY - (strHeight / 2);
	var createShowRectX2 = x + windowWidth;
	var createShowRectY2 = createShowRectY1 + strHeight;
	var mouseoverCreateShowRect = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, createShowRectX1, createShowRectY1, createShowRectX2, createShowRectY2) && !mouseoverScrollBar && !instance_exists(obj_dropDown) && !instance_exists(obj_dialogueBox);
	draw_set_color(merge_color(c_green, global.colorThemeSelected1, mouseoverCreateShowRect ? 0.4 : 0.6));
	draw_rectangle(createShowRectX1 - clipX, createShowRectY1 - clipY, createShowRectX2 - clipX, createShowRectY2 - clipY, false);
	draw_set_color(global.colorThemeText);
	draw_set_halign(fa_center);
	draw_text(floor(mean(x, nameColX)) - clipX, floor(mean(createShowRectY1, createShowRectY2)) - clipY, "+");
	draw_set_halign(fa_left);
	draw_text(floor(nameColX + textBuffer) - clipX, floor(mean(createShowRectY1, createShowRectY2)) - clipY, scr_get_translation("option_create-show"));
	
	// click on "create show"
	if (mouseoverCreateShowRect && mouse_check_button_released(mb_left)) {
		scr_createShow();
	}
	
	
	
	
	
	// only show a scrollbar if we're in 1toMany
	if (drawScrollbar) {
		scr_scrollBar(showListSize + 1, -1, strHeight, headerHeight,
			global.colorThemeSelected1, global.colorThemeSelected2,
			global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, windowWidth, windowHeight);
	}

	
		
	scr_surfaceEnd();

	var mouseOverWindow = point_in_rectangle(mouse_x,mouse_y, x, y, x + windowWidth, y + windowHeight);
	if (!anyOptionMousedOver and !mouseoverCreateShowRect and mouse_check_button_released(mb_left) and mouseOverWindow) {
		with (obj_panelPane) {
			functionChainContents_showID = "";
		}
	}

	
	
	// draw column headers
	var headerPlusX = 0;
	for (var i = 0; i < 3; i++) {
		
		// get column data
		var colWidth = 0;
		var colText = "";
		if (i == 0) {
			colWidth = numColWidth;
			colText = "#";
		}
		else if (i == 1) {
			colWidth = nameColWidth;
			colText = "name";
		}
		else if (i == 2) {
			colWidth = windowWidth - startColX;
			colText = "start";
		}
		
		// get header coordinates
		var headerRectX1 = x + headerPlusX;
		var headerRectY1 = y;
		var headerRectX2 = headerRectX1 + colWidth;
		var headerRectY2 = headerRectY1 + headerHeight;
		
		// draw header rects
		draw_set_color(global.colorThemeBG);
		draw_rectangle(headerRectX1, headerRectY1, headerRectX2, headerRectY2, false);
		draw_set_color(global.colorThemeBorders);
		draw_rectangle(headerRectX1, headerRectY1, headerRectX2, headerRectY2, true);
		
		// draw header text
		var headerTextX = floor(headerRectX1 + textBuffer);
		var headerTextY = floor(mean(headerRectY1, headerRectY2));
		draw_set_halign(fa_left);
		draw_set_valign(fa_middle);
		draw_set_color(global.colorThemeText);
		draw_text(headerTextX, headerTextY, scr_get_translation(colText));
		
		// dividing lines
		if (i > 0) {
			draw_set_color(global.colorThemeBG);
			draw_line(headerRectX1, headerRectY2, headerRectX1, y + windowHeight);
		}
		
		
		headerPlusX += colWidth;
	}
	
	// draw short white line to separate from left nav
	draw_set_color(global.colorThemeBG);
	draw_line(x + windowWidth-1 , y , x + windowWidth-1, y + headerHeight);
}
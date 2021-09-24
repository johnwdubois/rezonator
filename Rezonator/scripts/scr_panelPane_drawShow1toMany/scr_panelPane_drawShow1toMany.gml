// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_panelPane_drawShow1toMany(){
	
	scr_surfaceStart();
	
	// draw BG rect
	draw_set_color(global.colorThemeBG);
	draw_rectangle(x - clipX, y - clipY, x + windowWidth - clipX, y + windowHeight - clipY, false);
	
	// Set text margins
	var numColX = x;
	var numColWidth = windowWidth * 0.1;
	var nameColX = numColX + numColWidth;
	var nameColWidth = windowWidth * 0.7;
	var seqColX = nameColX + nameColWidth;
	var seqColWidth = windowWidth * 0.1;
	var delColX = seqColX + seqColWidth;
	var delColWidth = windowWidth * 0.1;
	var textBuffer = 8;
	var textPlusY = 0;
	var headerHeight = functionTabs_tabHeight;
	var strHeight = string_height("0") * 1.5;
	
	var focusedLineY1 = 0;
	var focusedLineY2 = 0;
	
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	
	var stackChainList = global.nodeMap[? "stackList"];
	
	
	// get showID and look it up in nodeMap
	var showID = functionChainContents_showID;
	var showSubMap = global.nodeMap[? showID];
	var setList = -1;
	var setListSize = 0;
	
	if (ds_list_size(stackChainList) > 0) {
		if (scr_isNumericAndExists(showSubMap, ds_type_map)) {
				
			// get setList from show & make sure it exists
			setList = showSubMap[? "setIDList"];
			if (scr_isNumericAndExists(setList, ds_type_list)) {
					
				// loop over setList and draw a row for each chain
				setListSize = ds_list_size(setList);
				for (var i = 0; i < setListSize; i++) {
					// get currentChain & make sure it exists
					var filteredChain = obj_chain.filteredStackChainList[| 0];
					var currentChain = setList[| i];
					var currentChainSubMap = global.nodeMap[? currentChain];
					if (!scr_isNumericAndExists(currentChainSubMap, ds_type_map)) continue;
					var currentChainName = currentChainSubMap[? "name"];
					var currentChainColor = currentChainSubMap[? "chainColor"];
					var chainIsFiltered = (currentChain == filteredChain);
							
				
							
					// get coordinates of rectangle around chain name
					var chainRectX1 = x;
					var chainRectY1 = y + headerHeight + textPlusY - (strHeight / 2) + scrollPlusY;
					var chainRectX2 = x + windowWidth;
					var chainRectY2 = chainRectY1 + strHeight;
					var mouseoverChainRect = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, chainRectX1, chainRectY1, chainRectX2, chainRectY2) && !instance_exists(obj_dropDown) && !instance_exists(obj_dialogueBox);
						
							
						
					// draw chain option rect
					draw_set_color(merge_color(currentChainColor, global.colorThemeBG, 0.65));
					//draw_set_color(merge_color(global.colorThemeBG, global.colorThemeSelected1, 0.8));
					draw_rectangle(chainRectX1 - clipX, chainRectY1 - clipY, chainRectX2 - clipX, chainRectY2 - clipY, false);
							
					// draw chain #
					draw_set_color(global.colorThemeText);
					draw_text(floor(numColX + textBuffer) - clipX, floor(mean(chainRectY1, chainRectY2)) - clipY, string(i + 1));
						
					// draw chain name
					draw_set_color(global.colorThemeText);
					draw_text(floor(nameColX + textBuffer) - clipX, floor(mean(chainRectY1, chainRectY2)) - clipY, string(currentChainName));
							
							
					if(mouseoverChainRect){
							
						// sequence arrows
						var showSeqUpArrow = (i > 0);
						var showSeqDownArrow = (i < setListSize - 1);
						var seqArrowX = mean(seqColX, seqColX + seqColWidth);
						var seqUpArrowY = chainRectY1 + (strHeight * 0.3);
						var seqDownArrowY = chainRectY1 + (strHeight * 0.7);
						var mouseoverSeqUpArrow = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, seqColX, chainRectY1, seqColX + seqColWidth, mean(chainRectY1, chainRectY2)) && showSeqUpArrow && !instance_exists(obj_dropDown) && !instance_exists(obj_dialogueBox);
						var mouseoverSeqDownArrow = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, seqColX, mean(chainRectY1, chainRectY2), seqColX + seqColWidth - global.scrollBarWidth, chainRectY2) && showSeqDownArrow && !mouseoverSeqUpArrow && !instance_exists(obj_dropDown) && !instance_exists(obj_dialogueBox);
							
							
							
						var delButtonX = mean(delColX, delColX + delColWidth);
						var delButtonY = chainRectY1 + (strHeight * 0.5);
						var mouseOverDel = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, delColX, chainRectY1, delColX + delColWidth - global.scrollBarWidth, chainRectY2)  && !instance_exists(obj_dropDown) && !instance_exists(obj_dialogueBox);

						var trashAlpha = .5;
								
						if(functionChainList_playShowID != showID){
								
							// mouseover & click on sequence arrows
							if (mouseOverDel) {
								draw_set_color(global.colorThemeSelected2);
								draw_rectangle(delColX - clipX, chainRectY1 - clipY, delColX + delColWidth - clipX, chainRectY2 - clipY, false);
								if (mouse_check_button_released(mb_left)) {
									scr_deleteFromList(setList, currentChain);
								}
								scr_createTooltip(delButtonX, chainRectY2, scr_get_translation("msg_remove"), obj_tooltip.arrowFaceUp);
							}
									
								trashAlpha = 1;
						}
								
						draw_sprite_ext(spr_trash, 0, delButtonX - clipX, delButtonY - clipY, .7, .7, 0, global.colorThemeText, trashAlpha);
								
						// mouseover & click on sequence arrows
						if (mouseoverSeqUpArrow) {
							draw_set_color(global.colorThemeSelected2);
							draw_rectangle(seqColX - clipX, chainRectY1 - clipY, seqColX + seqColWidth - clipX, mean(chainRectY1, chainRectY2) - clipY, false);
							if (mouse_check_button_released(mb_left)) {
								scr_listSwap(setList, i - 1, i);
							}
						}
						else if (mouseoverSeqDownArrow) {
							draw_set_color(global.colorThemeSelected2);
							draw_rectangle(seqColX - clipX, mean(chainRectY1, chainRectY2) - clipY, seqColX + seqColWidth - clipX, chainRectY2 - clipY, false);
							if (mouse_check_button_released(mb_left)) {
								scr_listSwap(setList, i, i + 1);
							}
						}
						if (showSeqUpArrow) draw_sprite_ext(spr_ascend, 0, seqArrowX - clipX, seqUpArrowY - clipY, 1, 1, 0, global.colorThemeText, 1);
						if (showSeqDownArrow) draw_sprite_ext(spr_ascend, 0, seqArrowX - clipX, seqDownArrowY - clipY, 1, 1, 180, global.colorThemeText, 1);
							
					}
					// draw horizontal dividing line
					draw_set_color(global.colorThemeBG);
					draw_line(chainRectX1 - clipX, chainRectY2 - 1 - clipY, chainRectX2 - clipX, chainRectY2 - 1 - clipY);
						
					textPlusY += strHeight;
							
					if(chainIsFiltered){
						focusedLineY1 = chainRectY1;
						focusedLineY2 = chainRectY2;
					}
							
				}

					
				if (ds_list_size(stackChainList) > 0) {
					
					// put "Add to Show" option at bottom of list
					var addToShowRectX1 = x;
					var addToShowRectY1 = y + headerHeight + textPlusY - (strHeight / 2) + scrollPlusY;
					var addToShowRectX2 = x + windowWidth;
					var addToShowRectY2 = addToShowRectY1 + strHeight;
					var mouseoverAddToShow = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, addToShowRectX1, addToShowRectY1, addToShowRectX2, addToShowRectY2) && !instance_exists(obj_dropDown) && !instance_exists(obj_dialogueBox);
					draw_set_color(merge_color(c_green, global.colorThemeSelected1, mouseoverAddToShow ? 0.4 : 0.6));
					draw_rectangle(addToShowRectX1 - clipX, addToShowRectY1 - clipY, addToShowRectX2 - clipX, addToShowRectY2 - clipY, false);
					draw_set_color(global.colorThemeText);
					draw_text(floor(nameColX + textBuffer) - clipX, floor(mean(addToShowRectY1, addToShowRectY2)) - clipY, scr_get_translation("option_add-to-show")+"...");
							
							
					draw_set_halign(fa_right);
					draw_set_valign(fa_middle);
					draw_text(seqColX  - textBuffer - clipX, floor(mean(addToShowRectY1, addToShowRectY2)) - clipY, obj_panelPane.errorText);
					draw_set_halign(fa_left);
					draw_set_valign(fa_middle);
	
					// click "add to show" option
					if (mouseoverAddToShow && mouse_check_button_released(mb_left)) {		
						var addToShowList = ds_list_create();
						ds_list_copy(addToShowList, stackChainList);
						scr_createDropDown(nameColX, addToShowRectY2, addToShowList, global.optionListTypeAddToShow);
					}
				}
			}
		}
	}
	else {		
		// if there's no stacks, show a message to user
		draw_set_color(merge_color(global.colorThemeText, global.colorThemeBG, 0.5));
		var noStackTextY = floor(y + headerHeight + (strHeight / 2));
		draw_text(nameColX + textBuffer - clipX, noStackTextY - clipY, scr_get_translation("msg-no-stacks-to-show"));
	}
	

	
	
	
	// scrollbar
	var scrollBarListSize = 0;
	if (scr_isNumericAndExists(setList, ds_type_list)) {
		scrollBarListSize = setListSize + 1;
	}
	scr_scrollBar(scrollBarListSize, -1, strHeight, headerHeight,
		global.colorThemeSelected1, global.colorThemeSelected2,
		global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, windowWidth, windowHeight);

	
	
	if(focusedLineY1 != 0 && focusedLineY2 != 0){
		draw_set_color(global.colorThemeText);
		draw_line_width(x- clipX, focusedLineY1- clipY, x+windowWidth- clipX, focusedLineY1- clipY, 3);
		draw_line_width(x- clipX, focusedLineY2- clipY, x+windowWidth- clipX, focusedLineY2- clipY, 3);
	}

	
	// headers!!!
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	for (var i = 0; i < 3; i++) {
		
		// get coordinates for header
		var headerRectX1 = 0;
		var headerRectY1 = y;
		var headerRectX2 = 0;
		var headerRectY2 = headerRectY1 + headerHeight;
		if (i == 0) {
			headerRectX1 = numColX;
			headerRectX2 = numColX + numColWidth;
		}
		else if (i == 1) {
			headerRectX1 = nameColX;
			headerRectX2 = nameColX + nameColWidth;
		}
		else if (i == 2) {
			headerRectX1 = seqColX;
			headerRectX2 = x + windowWidth;
		}
		
		// draw header rect
		draw_set_color(global.colorThemeBG);
		draw_rectangle(headerRectX1 - clipX, headerRectY1 - clipY, headerRectX2 - clipX, headerRectY2 - clipY, false);
		
		// header text: # column
		draw_set_color(global.colorThemeText);
		draw_text(floor(numColX + textBuffer) - clipX, floor(mean(headerRectY1, headerRectY2)) - clipY, "#");
		
		// header text: name column
		draw_text(floor(nameColX + textBuffer) - clipX, floor(mean(headerRectY1, headerRectY2)) - clipY, scr_get_translation("help_label_stack"));
		
		// header text: seq column
		draw_text(floor(seqColX + textBuffer) - clipX, floor(mean(headerRectY1, headerRectY2)) - clipY, scr_get_translation("option_seq"));
		
		// dividing lines
		if (i > 1) {
			draw_set_color(global.colorThemeBorders);
			//draw_line(headerRectX1 - clipX, y - clipY, headerRectX1 - clipX, y + headerHeight - clipY);
			draw_set_color(global.colorThemeBG);
			//draw_line(headerRectX1 - clipX, y + headerHeight - clipY, headerRectX1 - clipX, y + windowHeight - clipY);
		}
		
	}
	
	// short line to divide left from right nav
	draw_set_color(global.colorThemeBorders);
	//draw_line(x - clipX, y - clipY, x - clipX, y + headerHeight - clipY);
	draw_line(x - clipX, y + headerHeight - clipY, x + windowWidth - clipX, y + headerHeight - clipY);
	
	
	
	//Show Traversal buttons
	
	//find only filtered chain
	var currentFilteredChain = obj_chain.filteredStackChainList[| 0];
	
	//find map of show that is playing
	var currentShowSubMap = global.nodeMap[? obj_panelPane.functionChainList_playShowID];
	var isSelected = (obj_panelPane.functionChainContents_showID != "");
	var setList = "";
	var currentChainIndex = -1;
	var setListSize = 0;
	var isPlaying = false;
	if (scr_isNumericAndExists(currentShowSubMap,ds_type_map)) {
		//get setlist of playing show
		setList = currentShowSubMap[? "setIDList"];	
		if (scr_isNumericAndExists(setList, ds_type_list)) {		
			//get index of filtered chain in show's setList
			currentChainIndex = ds_list_find_index(setList,currentFilteredChain);
			setListSize = ds_list_size(setList);
			isPlaying = true;
		}
	}
	
	// show buttons (next) 
	var showNextButtonText = "  >  ";
	scr_adaptFont(showNextButtonText, "M");
	var showNextButtonX2 = seqColX - 20;
	var showNextButtonY1 = y + (functionTabs_tabHeight * 0.5) - (strHeight * 0.25);
	var showNextButtonX1 = showNextButtonX2 - string_width(showNextButtonText);
	var showNextButtonY2 = showNextButtonY1 + strHeight/2;
		
				
	// show buttons (Stop) 
	var showStopButtonText = "  ►  ";
	var showStopButtonX2 = showNextButtonX1 - 20;
	var showStopButtonY1 = showNextButtonY1;
	var showStopButtonX1 = showStopButtonX2 - string_width(showStopButtonText);
	var showStopButtonY2 = showNextButtonY2;
		
		
	// show buttons (prev)
	var showPrevButtonText = "  <  ";
	var showPrevButtonX2 = showStopButtonX1 - 20;
	var showPrevButtonY1 = showNextButtonY1;
	var showPrevButtonX1 = showPrevButtonX2 - string_width(showPrevButtonText);
	var showPrevButtonY2 = showNextButtonY2;
		


		
		
		
	if (isPlaying || isSelected) {
		
		
		// show buttons (prev)
		var mouseoverShowPrevButton = point_in_rectangle(mouse_x, mouse_y, showPrevButtonX1, showPrevButtonY1, showPrevButtonX2, showPrevButtonY2);
		draw_set_color(merge_color(global.colorThemeSelected1, global.colorThemeBG, mouseoverShowPrevButton ? 0 : 0.5));
		draw_roundrect(showPrevButtonX1- clipX, showPrevButtonY1- clipY, showPrevButtonX2- clipX, showPrevButtonY2- clipY, false);
		draw_set_color(global.colorThemeText);
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		draw_text(floor(mean(showPrevButtonX1, showPrevButtonX2)- clipX), floor(mean(showPrevButtonY1, showPrevButtonY2)- clipY), showPrevButtonText);
		if (mouseoverShowPrevButton) {
			scr_createTooltip(mean(showPrevButtonX1, showPrevButtonX2), showPrevButtonY2, scr_get_translation("option_previous"), obj_tooltip.arrowFaceUp);
		}
		
		if (isPlaying) {
			if (mouse_check_button_released(mb_left) && mouseoverShowPrevButton) {
			
				if(currentChainIndex > 0){				
					scr_setValueForAllChains("stack","filter", false);
									
					// Filter the first current stack
					var currentStackID = setList[| currentChainIndex - 1];
									
					if (ds_list_find_index(obj_chain.filteredStackChainList,currentStackID) == -1) {
						ds_list_add(obj_chain.filteredStackChainList,currentStackID);
						var chainSubMap = global.nodeMap[? currentStackID];
						if (scr_isNumericAndExists(chainSubMap, ds_type_map)) {
							chainSubMap[? "filter"] = true;
						}
										
						with (obj_control) {
							scr_renderFilter2();
						}
					}
				}
				else{
					scr_setValueForAllChains("stack", "filter", false);
					with(obj_panelPane){
						functionChainList_playShowID = "";
					}				
					with (obj_control) {
						scr_disableFilter();
					}
				}
		
			}
		}
		

		// show buttons (Stop) 
		var mouseoverShowStopButton = point_in_rectangle(mouse_x, mouse_y, showStopButtonX1, showStopButtonY1, showStopButtonX2, showStopButtonY2);
		if(isPlaying){
			showStopButtonText =  "  ■  ";
			if(mouseoverShowStopButton){scr_createTooltip(mean(showStopButtonX1, showStopButtonX2),mean(showStopButtonY1, showStopButtonY2), scr_get_translation("option_stop"),obj_tooltip.arrowFaceUp);}
		}
		else{
			if(mouseoverShowStopButton){scr_createTooltip(mean(showStopButtonX1, showStopButtonX2),showStopButtonY2, scr_get_translation("help_label_play"),obj_tooltip.arrowFaceUp);}
		}
				
		draw_set_color(merge_color(global.colorThemeSelected1, global.colorThemeBG, mouseoverShowStopButton ? 0.0 : 0.5));
		draw_roundrect(showStopButtonX1- clipX, showStopButtonY1- clipY, showStopButtonX2- clipX, showStopButtonY2- clipY, false);
		draw_set_color(global.colorThemeText);
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		draw_text(floor(mean(showStopButtonX1, showStopButtonX2)- clipX), floor(mean(showStopButtonY1, showStopButtonY2)- clipY), showStopButtonText);
	
		if (mouse_check_button_released(mb_left) && mouseoverShowStopButton) {
			
			if(isPlaying){
				// stop show!
				scr_setValueForAllChains("stack","filter", false);
				with(obj_panelPane){
					functionChainList_playShowID = "";
				}
				with (obj_control) {
					scr_disableFilter();
				}
			}
			else {
						
				var currentShowSubMap = global.nodeMap[? obj_panelPane.functionChainContents_showID];
		
				if (scr_isNumericAndExists(currentShowSubMap, ds_type_map)) {
					
					//get setlist of playing show
					setList = currentShowSubMap[? "setIDList"];
					if (scr_isNumericAndExists(setList, ds_type_list)) {		
						//get size of setList to see if we can start a show
						setListSize = ds_list_size(setList);
					}
				}
					
				if(setListSize > 0){
							
					with (obj_panelPane) {
						functionChainList_playShowID = functionChainContents_showID;
					}
							
					scr_setValueForAllChains("stack","filter", false);
									
					// Filter the first current stack
					var currentStackID = setList[| 0];
					show_debug_message("currentStackID : "+ string(currentStackID));

					if(ds_list_find_index(obj_chain.filteredStackChainList,currentStackID) == -1){
						if(currentStackID != undefined){
							ds_list_add(obj_chain.filteredStackChainList,currentStackID);
							var chainSubMap = global.nodeMap[? currentStackID];
							if (scr_isNumericAndExists(chainSubMap,ds_type_map)) {
								chainSubMap[? "filter"] = true;
							}
						}
						with (obj_control) {
							scr_renderFilter2();
						}
					}
				}
			}
		}
		
		
		
		
		
		// show buttons (next)
		var mouseoverShowNextButton = point_in_rectangle(mouse_x, mouse_y, showNextButtonX1, showNextButtonY1, showNextButtonX2, showNextButtonY2);
		draw_set_color(merge_color(global.colorThemeSelected1, global.colorThemeBG, mouseoverShowNextButton ? 0 : 0.5));
		draw_roundrect(showNextButtonX1- clipX, showNextButtonY1- clipY, showNextButtonX2- clipX, showNextButtonY2- clipY, false);
		draw_set_color(global.colorThemeText);
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		draw_text(floor(mean(showNextButtonX1, showNextButtonX2)- clipX), floor(mean(showNextButtonY1, showNextButtonY2)- clipY), showNextButtonText);
	
		if(mouseoverShowNextButton){scr_createTooltip(mean(showNextButtonX1, showNextButtonX2),showNextButtonY2, scr_get_translation("help_label_next"),obj_tooltip.arrowFaceUp);}
	
		if(isPlaying){
			if (mouse_check_button_released(mb_left) && mouseoverShowNextButton) {

				if(currentChainIndex < setListSize-1 && currentChainIndex != -1){
									
					scr_setValueForAllChains("stack","filter", false);
									
					// Filter the first current stack
					var currentStackID = setList[| currentChainIndex + 1];

					if(ds_list_find_index(obj_chain.filteredStackChainList,currentStackID) == -1){
						if(currentStackID != undefined){
							ds_list_add(obj_chain.filteredStackChainList,currentStackID);
							var chainSubMap = global.nodeMap[? currentStackID];
							if (scr_isNumericAndExists(chainSubMap,ds_type_map)) {
								chainSubMap[? "filter"] = true;
							}
						}
						with (obj_control) {
							scr_renderFilter2();
						}
					}

				}
				else{
					scr_setValueForAllChains("stack","filter", false);
					with(obj_panelPane){
						functionChainList_playShowID = "";
					}
					with (obj_control) {
						scr_disableFilter();
					}
				}
				
			}
		}
		
	}	
	scr_surfaceEnd();
}
function scr_panelPane_drawTabs() {
	/*
		Purpose: draw Rez, Track, and Stack tabs on chainList panel pane
	*/
	
	
	// Set opacity, font, and alignment of text in chain tabs
	draw_set_alpha(1);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	scr_adaptFont("0", "M");
	
	var strHeight = string_height("0");
	var sprHeight = sprite_get_height(spr_filterIcons);
	var textMarginLeft = 5;
	
	// set positions for other panelPanes
	var tabsPaneInst = self.id;
	with (obj_panelPane) {
		functionTabs_tabHeight = (strHeight * 1.5) + textMarginLeft;
		if (currentFunction == functionChainList || currentFunction == functionChainContents || currentFunction == functionFilter) {
			y = tabsPaneInst.y + tabsPaneInst.windowHeight;
		}
	}



	var tabAmount = 5;

	x = 0;
	if (obj_panelPane.showNav) {
		y = obj_menuBar.menuHeight;
	}
	var edgeBufferY = 0;
	var edgeBufferX = 3;
	var tabRectY1 = y+edgeBufferY;
	var tabRectY2 = tabRectY1 + functionTabs_tabHeight-edgeBufferY;
	draw_set_color(make_color_rgb(125, 125, 128));
	draw_rectangle(x, y, x + windowWidth, tabRectY2, false);

	// loop over tabs
	for (var i = 0; i < tabAmount; i++) {

		// set dimensions for tabs
		var tabRectX1 = x + (i * (windowWidth / (tabAmount+2)));
		var tabRectX2 = tabRectX1 + (windowWidth / (tabAmount+2));
		var mouseoverTab = point_in_rectangle(mouse_x, mouse_y, tabRectX1, tabRectY1, tabRectX2, tabRectY2) && !instance_exists(obj_dropDown) && !instance_exists(obj_dialogueBox);

		var buttonSize = sprite_get_width(spr_filterIcons) * 1.25;
	
		if (i != functionChainList_currentTab) {
			edgeBufferY = functionTabs_tabHeight * 0.3;
		}
		else{
			edgeBufferY = functionTabs_tabHeight * 0.2;
		}
		
		draw_set_color(global.colorThemeSelected1);
		if(mouseoverTab){
			draw_set_color(merge_color(global.colorThemeSelected1, global.colorThemeBG, 0.5));
		}
		draw_roundrect(tabRectX1+edgeBufferX , tabRectY1+edgeBufferY, tabRectX2-edgeBufferX, tabRectY2+edgeBufferY, false);
		draw_set_color(global.colorThemeBorders);
		draw_roundrect(tabRectX1+edgeBufferX, tabRectY1+edgeBufferY, tabRectX2-edgeBufferX, tabRectY2+edgeBufferY, true);
		
		
		
		// highlight current tab
		if (i == functionChainList_currentTab) {
			draw_set_color(global.colorThemeBG);
			draw_roundrect(tabRectX1+edgeBufferX, tabRectY1+edgeBufferY, tabRectX2-edgeBufferX, tabRectY2 +edgeBufferY, false);
		}


		draw_set_color(global.colorThemeBG);
		draw_rectangle(tabRectX1+edgeBufferX, tabRectY2, tabRectX2-edgeBufferX+1, y+ windowHeight, false);
		if (i != functionChainList_currentTab) {
			draw_set_color(global.colorThemeBorders)
			draw_line(tabRectX1-edgeBufferX,tabRectY2,tabRectX2+edgeBufferX*2,tabRectY2)
		}
		// determine tabChainType & selectedNodeList for this tab
		var chainTab = (functionChainList_currentTab == functionChainList_tabRezBrush || functionChainList_currentTab == functionChainList_tabTrackBrush || functionChainList_currentTab == functionChainList_tabStackBrush);
		var tabChainType = "";
		var selectedNodeList = -1;
		var filterList = scr_getFilterList();
		var tabFilterActive = false;
		if (functionChainList_currentTab == functionChainList_tabRezBrush) {
			tabChainType = "rezChain";
			selectedNodeList = obj_control.selectedRezChainList;
			tabFilterActive = obj_control.filterActiveRez;
		}
		else if (functionChainList_currentTab == functionChainList_tabTrackBrush) {
			tabChainType = "trackChain";
			selectedNodeList = obj_control.selectedTrackChainList;
			tabFilterActive = obj_control.filterActiveTrack;
		}
		else if (functionChainList_currentTab == functionChainList_tabStackBrush) {
			tabChainType = "stackChain";
			selectedNodeList = obj_control.selectedStackChainList;
			tabFilterActive = obj_control.filterActiveStack;
		}

		
		// draw filter/visible buttons if there is anything selected
		if (i == functionChainList_currentTab) {
			if (chainTab) {
				var itemsInFilter = (ds_list_size(filterList) > 0);
				var buttonAlpha = itemsInFilter ? 1 : 0.4;
				
				// filter button
				/*
				var filterRectX1 = x + (buttonSize / 2);
				var filterRectY1 = y + functionTabs_tabHeight + (functionTabs_tabHeight / 2) - (buttonSize / 2);
				var filterRectX2 = filterRectX1 + buttonSize;
				var filterRectY2 = filterRectY1 + buttonSize;
				var mouseoverFilter = point_in_rectangle(mouse_x, mouse_y, filterRectX1, filterRectY1, filterRectX2, filterRectY2);
				draw_set_alpha(buttonAlpha);
				draw_set_color(obj_control.filterGridActive ? global.colorThemeText : global.colorThemeSelected1);
				draw_roundrect(filterRectX1, filterRectY1, filterRectX2, filterRectY2, false);
				if (mouseoverFilter) {
					scr_createTooltip(mean(filterRectX1, filterRectX2), floor(filterRectY2), "Filter", obj_tooltip.arrowFaceUp);
						
					if (itemsInFilter) {
						draw_set_color(global.colorThemeText);
						draw_roundrect(filterRectX1, filterRectY1, filterRectX2, filterRectY2, true);
							
						// click filter button
						if (mouse_check_button_released(mb_left)) {
							
							// toggle filter depending on tab
							if (functionChainList_currentTab == functionChainList_tabRezBrush) {
								obj_control.filterActiveRez = !obj_control.filterActiveRez;
								show_debug_message("filterActiveRez: " + string(filterActiveRez));
							}
							else if (functionChainList_currentTab == functionChainList_tabTrackBrush) {
								obj_control.filterActiveTrack = !obj_control.filterActiveTrack;
								show_debug_message("filterActiveTrack: " + string(filterActiveTrack));
							}
							else if (functionChainList_currentTab == functionChainList_tabStackBrush) {
								obj_control.filterActiveStack = !obj_control.filterActiveStack;
								show_debug_message("filterActiveStack: " + string(filterActiveStack));
							}
							
							// determine if filter should be activated or disabled
							obj_control.filterGridActive = (functionChainList_currentTab == functionChainList_tabRezBrush && obj_control.filterActiveRez)
															|| (functionChainList_currentTab == functionChainList_tabTrackBrush && obj_control.filterActiveTrack)
															|| (functionChainList_currentTab == functionChainList_tabStackBrush && obj_control.filterActiveStack);
							
							if (obj_control.filterGridActive) {
								scr_renderFilter();
							}
							else {
								scr_disableFilter();
							}

						}
					}
				}
				draw_sprite_ext(spr_filterIcons, 0, floor(mean(filterRectX1, filterRectX2)), floor(mean(filterRectY1, filterRectY2)), 1, 1, 0, obj_control.filterGridActive ? global.colorThemeBG : global.colorThemeText, buttonAlpha);
				*/

			}
		}
		
		draw_set_alpha(1);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
	
		// check for mouse clicks to switch the selected tab
		if (mouseoverTab && !instance_exists(obj_dropDown) && !chainListPane.scrollBarClickLock && i != functionChainList_currentTab) {
			if (device_mouse_check_button_released(0, mb_left)) {
				
				show_debug_message("scr_panelPane_drawTabs() ... switch to tab " + string(i));
				
				// switch tab
				with (obj_panelPane) {
					functionChainList_currentTab = i;
					functionChainList_playShowID = "";
				}
				
				// re-determine tab data (now that we've switched tabs)
				if (functionChainList_currentTab == functionChainList_tabRezBrush) {
					tabChainType = "rezChain";
					selectedNodeList = obj_control.selectedRezChainList;
					tabFilterActive = obj_control.filterActiveRez;
				}
				else if (functionChainList_currentTab == functionChainList_tabTrackBrush) {
					tabChainType = "trackChain";
					selectedNodeList = obj_control.selectedTrackChainList;
					tabFilterActive = obj_control.filterActiveTrack;
				}
				else if (functionChainList_currentTab == functionChainList_tabStackBrush) {
					tabChainType = "stackChain";
					selectedNodeList = obj_control.selectedStackChainList;
					tabFilterActive = obj_control.filterActiveStack;
				}
				else if (functionChainList_currentTab == functionChainList_tabShow) {
					with (obj_panelPane) {
						chainViewOneToMany = true;
					}
				}
				
				filterList = scr_getFilterList();
				chainTab = (functionChainList_currentTab == functionChainList_tabRezBrush || functionChainList_currentTab == functionChainList_tabTrackBrush || functionChainList_currentTab == functionChainList_tabStackBrush);
				
				if (chainTab) {
					if (tabFilterActive) {
						scr_renderFilter();
					}
					else if (obj_control.filterGridActive) {
						scr_disableFilter();
					}
				}
				else if (obj_control.filterGridActive) {
					obj_control.filterGridActive = false;
					scr_disableFilter();
				}
			
				// unfocus chains of all type
				scr_unFocusAllChains();
			
				/*
				if (i == 1) {
					obj_toolPane.currentMode = obj_toolPane.modeTrack;
					if(obj_control.searchGridActive) {
						obj_toolPane.setModeSearch = obj_toolPane.modeTrack;
					}
					else {
						obj_toolPane.setModeMain = obj_toolPane.modeTrack;
					}
				}
				if (i == 2) {
					obj_toolPane.currentMode = obj_toolPane.modeRez;
					if(obj_control.searchGridActive) {
						obj_toolPane.setModeSearch = obj_toolPane.modeRez;
					}
					else {
						obj_toolPane.setModeMain = obj_toolPane.modeRez;
					}
				}
				if (i == 3) {
					if(obj_toolPane.currentMode = obj_toolPane.modeRead) {
						obj_toolPane.currentMode = obj_toolPane.modeTrack;
						if (obj_control.searchGridActive) {
							obj_toolPane.setModeSearch = obj_toolPane.modeTrack;
						}
						else {
							obj_toolPane.setModeMain = obj_toolPane.modeTrack;
						}
					}
				}
				*/
				
				
				
				
			}
		}
	
		// keeps drawing the name of the tabs
		//draw_set_color(global.colorThemeBorders);
		//draw_rectangle(tabRectX1, tabRectY1, tabRectX2, tabRectY2, true);
		draw_set_color(global.colorThemeText);
		scr_adaptFont(scr_get_translation(functionChainList_tabName[i]), "M");
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		draw_text(floor(mean(tabRectX2, tabRectX1)),floor(mean(tabRectY2, tabRectY1+edgeBufferY)), scr_get_translation(functionChainList_tabName[i]));

	}
	
	if(functionChainList_currentTab != functionChainList_tabShow){
	
	
		// 1to1 vs 1toMany button
		var oneToOneButtonX = floor(x + windowWidth - buttonSize);
		var oneToOneButtonY = floor(y + functionTabs_tabHeight * 1.5);
		var oneToOneButtonX1 = oneToOneButtonX - (buttonSize / 2);
		var oneToOneButtonY1 = oneToOneButtonY - (buttonSize / 2);
		var oneToOneButtonX2 = oneToOneButtonX1 + buttonSize;
		var oneToOneButtonY2 = oneToOneButtonY1 + buttonSize;
		var mouseoverOneToOneButton = point_in_rectangle(mouse_x, mouse_y, oneToOneButtonX1, oneToOneButtonY1, oneToOneButtonX2, oneToOneButtonY2);
	
		// determine whether we are in 1to1 or 1toMany
		var oneToOneView = false;
		if (functionChainList_currentTab == functionChainList_tabLine && obj_control.showUnitTags) oneToOneView = true;
		else if (!chainViewOneToMany) oneToOneView = true;
	
		if (mouseoverOneToOneButton) {
			scr_createTooltip(mean(oneToOneButtonX1, oneToOneButtonX2), floor(oneToOneButtonY2), (oneToOneView) ? "One to one" : "One to many", obj_tooltip.arrowFaceUp);
		
			draw_set_color(global.colorThemeSelected1);
			draw_roundrect(oneToOneButtonX1 - (buttonSize * 0.15), oneToOneButtonY1 - (buttonSize * 0.15), oneToOneButtonX2  + (buttonSize * 0.15), oneToOneButtonY2 + (buttonSize * 0.15), false);
		
			if (mouse_check_button_released(mb_left)) {
				scr_toggle1to1();
			}
		}
	
		draw_sprite_ext(spr_oneToOne, oneToOneView, oneToOneButtonX, oneToOneButtonY, 1, 1, 0, c_white, 1);
	

	}

	else{
		//find only filtered chain
		var currentFilteredChain = ds_list_find_value(obj_chain.filteredStackChainList, 0);
		//find map of show that is playing
		var currentShowSubMap = ds_map_find_value(global.nodeMap, obj_panelPane.functionChainList_playShowID);
		var isSelected = ("" != obj_panelPane.functionChainContents_showID);
		var setList = "";
		var currentChainIndex = -1;
		var setListSize = 0;
		var isPlaying = false;
		if(is_numeric(currentShowSubMap)){
			if(ds_exists(currentShowSubMap,ds_type_map)){
				//get setlist of playing show
				setList = ds_map_find_value(currentShowSubMap, "setIDList");	
				if (is_numeric(setList)) {
					if (ds_exists(setList, ds_type_list)) {		
						//get index of filtered chain in show's setList
						currentChainIndex = ds_list_find_index(setList,currentFilteredChain);
						setListSize = ds_list_size(setList);
						isPlaying = true;
					}
				}
			}
		}

		
		
		// show buttons (prev)

		var showPrevButtonText = "  <  ";
		scr_adaptFont(showPrevButtonText, "M");
		var showPrevButtonX1 = x + (windowWidth * 0.5);
		var showPrevButtonY1 = y + (functionTabs_tabHeight * 1.5) - (strHeight * 0.5);
		var showPrevButtonX2 = showPrevButtonX1 + string_width(showPrevButtonText);
		var showPrevButtonY2 = showPrevButtonY1 + strHeight;
		
		
		// show buttons (Stop) 
		var showStopButtonText = "  ►  ";
		var showStopButtonX1 = showPrevButtonX2 + 20;
		var showStopButtonY1 = showPrevButtonY1;
		var showStopButtonX2 = showStopButtonX1 + string_width(showStopButtonText);
		var showStopButtonY2 = showPrevButtonY2;
		
		// show buttons (next) 
		var showNextButtonText = "  >  ";
		var showNextButtonX1 = showStopButtonX2 + 20;
		var showNextButtonY1 = showPrevButtonY1;
		var showNextButtonX2 = showNextButtonX1 + string_width(showNextButtonText);
		var showNextButtonY2 = showPrevButtonY2;
		
		
		
		if(isPlaying || isSelected){
		
		
			// show buttons (prev)
			var mouseoverShowPrevButton = point_in_rectangle(mouse_x, mouse_y, showPrevButtonX1, showPrevButtonY1, showPrevButtonX2, showPrevButtonY2);
			draw_set_color(merge_color(global.colorThemeSelected1, global.colorThemeBG, mouseoverShowPrevButton ? 0 : 0.5));
			draw_roundrect(showPrevButtonX1, showPrevButtonY1, showPrevButtonX2, showPrevButtonY2, false);
			draw_set_color(global.colorThemeText);
			draw_set_halign(fa_center);
			draw_set_valign(fa_middle);
			draw_text(floor(mean(showPrevButtonX1, showPrevButtonX2)), floor(mean(showPrevButtonY1, showPrevButtonY2)), showPrevButtonText);
		
			if(isPlaying){
				if (mouse_check_button_released(mb_left) && mouseoverShowPrevButton) {
			
					if(currentChainIndex > 0){				
						scr_setValueForAllChains("stackChain","filter", false);
									
						// Filter the first current stack
						var currentStackID = ds_list_find_value(setList, currentChainIndex-1);
									
						if(ds_list_find_index(obj_chain.filteredStackChainList,currentStackID) == -1){
							ds_list_add(obj_chain.filteredStackChainList,currentStackID);
							var chainSubMap = ds_map_find_value(global.nodeMap,currentStackID);
							if(is_numeric(chainSubMap)){
								if(ds_exists(chainSubMap,ds_type_map)){
									ds_map_replace(chainSubMap, "filter", true);

								}
							}
										
							with (obj_control) {
								scr_renderFilter();
							}
						}

					}
					else{
						scr_setValueForAllChains("stackChain","filter", false);
						with(obj_panelPane){
							functionChainList_playShowID = "";
						}				
						with (obj_control) {
							scr_renderFilter();	
						}
					}
		
				}
			}
		
			// show buttons (Stop) 
			if(isPlaying){
				showStopButtonText =  "  ■  ";
			}
			var mouseoverShowStopButton = point_in_rectangle(mouse_x, mouse_y, showStopButtonX1, showStopButtonY1, showStopButtonX2, showStopButtonY2);
			draw_set_color(merge_color(global.colorThemeSelected1, global.colorThemeBG, mouseoverShowStopButton ? 0 : 0.5));
			draw_roundrect(showStopButtonX1, showStopButtonY1, showStopButtonX2, showStopButtonY2, false);
			draw_set_color(global.colorThemeText);
			draw_set_halign(fa_center);
			draw_set_valign(fa_middle);
			draw_text(floor(mean(showStopButtonX1, showStopButtonX2)), floor(mean(showStopButtonY1, showStopButtonY2)), showStopButtonText);
	
		
			if (mouse_check_button_released(mb_left) && mouseoverShowStopButton ) {
					if(isPlaying){
						scr_setValueForAllChains("stackChain","filter", false);
						with(obj_panelPane){
							functionChainList_playShowID = "";
						}
						show_debug_message("functionChainList_playShowID:" + string(obj_panelPane.functionChainList_playShowID));
						with (obj_control) {
							scr_renderFilter();	
						}
					}
					else {
						
						var currentShowSubMap = ds_map_find_value(global.nodeMap, obj_panelPane.functionChainContents_showID);
		
						if(is_numeric(currentShowSubMap)){
							if(ds_exists(currentShowSubMap,ds_type_map)){
								//get setlist of playing show
								setList = ds_map_find_value(currentShowSubMap, "setIDList");	
								if (is_numeric(setList)) {
									if (ds_exists(setList, ds_type_list)) {		
										//get size of setList to see if we can start a show
										setListSize = ds_list_size(setList);

									}
								}
							}
						}
					
						if(setListSize > 0){
							
							with (obj_panelPane) {
								functionChainList_playShowID = functionChainContents_showID;
							}
							
							scr_setValueForAllChains("stackChain","filter", false);
									
							// Filter the first current stack
							var currentStackID = ds_list_find_value(setList, 0);
							show_debug_message("currentStackID : "+ string(currentStackID));

							if(ds_list_find_index(obj_chain.filteredStackChainList,currentStackID) == -1){
								if(currentStackID != undefined){
									ds_list_add(obj_chain.filteredStackChainList,currentStackID);
									var chainSubMap = ds_map_find_value(global.nodeMap,currentStackID);
									if(is_numeric(chainSubMap)){
										if(ds_exists(chainSubMap,ds_type_map)){
											ds_map_replace(chainSubMap, "filter", true);

										}
									}
								}
								with (obj_control) {
									scr_renderFilter();
								}
							}
						}
					
					}
				
			}
		
		
			// show buttons (next)
			var mouseoverShowNextButton = point_in_rectangle(mouse_x, mouse_y, showNextButtonX1, showNextButtonY1, showNextButtonX2, showNextButtonY2);
			draw_set_color(merge_color(global.colorThemeSelected1, global.colorThemeBG, mouseoverShowNextButton ? 0 : 0.5));
			draw_roundrect(showNextButtonX1, showNextButtonY1, showNextButtonX2, showNextButtonY2, false);
			draw_set_color(global.colorThemeText);
			draw_set_halign(fa_center);
			draw_set_valign(fa_middle);
			draw_text(floor(mean(showNextButtonX1, showNextButtonX2)), floor(mean(showNextButtonY1, showNextButtonY2)), showNextButtonText);
	
	
			if(isPlaying){
				if (mouse_check_button_released(mb_left) && mouseoverShowNextButton) {

					if(currentChainIndex < setListSize-1 && currentChainIndex != -1){
									
						scr_setValueForAllChains("stackChain","filter", false);
									
						// Filter the first current stack
						var currentStackID = ds_list_find_value(setList, currentChainIndex+1);

						if(ds_list_find_index(obj_chain.filteredStackChainList,currentStackID) == -1){
							if(currentStackID != undefined){
								ds_list_add(obj_chain.filteredStackChainList,currentStackID);
								var chainSubMap = ds_map_find_value(global.nodeMap,currentStackID);
								if(is_numeric(chainSubMap)){
									if(ds_exists(chainSubMap,ds_type_map)){
										ds_map_replace(chainSubMap, "filter", true);

									}
								}
							}
							with (obj_control) {
								scr_renderFilter();
							}
						}

					}
					else{
						scr_setValueForAllChains("stackChain","filter", false);
						with(obj_panelPane){
							functionChainList_playShowID = "";
						}
						show_debug_message("functionChainList_playShowID:" + string(obj_panelPane.functionChainList_playShowID));
						with (obj_control) {
							scr_renderFilter();	
						}
					}

				}
			}
		}
	}


}

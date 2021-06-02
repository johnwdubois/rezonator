function scr_panelPane_drawTabs() {


	
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
		if (currentFunction == functionChainList || currentFunction == functionChainContents) {
			y = tabsPaneInst.y + tabsPaneInst.windowHeight;
		}
	}

	var buttonScale = (1+global.fontSize/10);

	var translationListSize = ds_list_size(global.translationList);
	var hasTranslation = (translationListSize > 0);
	
	var tabList = obj_control.panelPaneTabList;
	var tabAmount = ds_list_size(tabList);
	

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
		
		var currentTab = tabList[| i];

		// set dimensions for tabs
		var tabRectX1 = x + (i * (windowWidth / (tabAmount+2)));
		var tabRectX2 = tabRectX1 + (windowWidth / (tabAmount+2));
		var mouseoverTab = point_in_rectangle(mouse_x, mouse_y, tabRectX1, tabRectY1, tabRectX2, tabRectY2) && !instance_exists(obj_dropDown) && !instance_exists(obj_dialogueBox);

		var buttonSize = sprite_get_width(spr_oneToOne) * buttonScale;
	
		if (currentTab != functionChainList_currentTab) {
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
		if (currentTab == functionChainList_currentTab) {
			draw_set_color(global.colorThemeBG);
			draw_roundrect(tabRectX1+edgeBufferX, tabRectY1+edgeBufferY, tabRectX2-edgeBufferX, tabRectY2 +edgeBufferY, false);
		}


		draw_set_color(global.colorThemeBG);
		draw_rectangle(tabRectX1+edgeBufferX, tabRectY2, tabRectX2-edgeBufferX+1, y+ windowHeight, false);
		
		
		if (currentTab != functionChainList_currentTab) {
			draw_set_color(global.colorThemeBorders)
			draw_line(tabRectX1-edgeBufferX,tabRectY2,tabRectX2+edgeBufferX*2,tabRectY2)
		}
		
		// determine tabChainType for this tab
		var chainTab = (functionChainList_currentTab == functionChainList_tabRezBrush || functionChainList_currentTab == functionChainList_tabTrackBrush || functionChainList_currentTab == functionChainList_tabStackBrush);
		var tabChainType = "";
		var filterList = scr_getFilterList();
		var tabFilterActive = false;
		if (functionChainList_currentTab == functionChainList_tabRezBrush) {
			tabChainType = "rezChain";
			tabFilterActive = obj_control.filterActiveRez;
		}
		else if (functionChainList_currentTab == functionChainList_tabTrackBrush) {
			tabChainType = "trackChain";
			tabFilterActive = obj_control.filterActiveTrack;
		}
		else if (functionChainList_currentTab == functionChainList_tabStackBrush) {
			tabChainType = "stackChain";
			tabFilterActive = obj_control.filterActiveStack;
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
					functionChainList_currentTab = currentTab;
				}
				
				// re-determine tab data (now that we've switched tabs)
				if (functionChainList_currentTab == functionChainList_tabRezBrush) {
					tabChainType = "rezChain";
					tabFilterActive = obj_control.filterActiveRez;
				}
				else if (functionChainList_currentTab == functionChainList_tabTrackBrush) {
					tabChainType = "trackChain";
					tabFilterActive = obj_control.filterActiveTrack;
				}
				else if (functionChainList_currentTab == functionChainList_tabStackBrush) {
					tabChainType = "stackChain";
					tabFilterActive = obj_control.filterActiveStack;
				}
				else if (functionChainList_currentTab == functionChainList_tabShow) {
					with (obj_panelPane) {
						chainViewOneToMany = true;
					}
				}
				
				
				if (functionChainList_currentTab != functionChainList_tabShow) {
					if(functionChainList_playShowID != ""){
						scr_setValueForAllChains("stackChain", "filter", false);
						with(obj_panelPane){
							functionChainList_playShowID = "";
						}
						scr_disableFilter();
					}
				}
				
				filterList = scr_getFilterList();
				chainTab = (functionChainList_currentTab == functionChainList_tabRezBrush || functionChainList_currentTab == functionChainList_tabTrackBrush || functionChainList_currentTab == functionChainList_tabStackBrush);
				
				if (chainTab) {
					if (tabFilterActive) {
						scr_renderFilter2();
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
			

			}
		}
	
		// keeps drawing the name of the tabs
		//draw_set_color(global.colorThemeBorders);
		//draw_rectangle(tabRectX1, tabRectY1, tabRectX2, tabRectY2, true);
		draw_set_color(global.colorThemeText);
		scr_adaptFont(scr_get_translation(currentTab), "M");
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		draw_text(floor(mean(tabRectX2, tabRectX1)),floor(mean(tabRectY2, tabRectY1+edgeBufferY)), scr_get_translation(currentTab));

	}
	
	
	draw_set_color(global.colorThemeBorders);
	draw_line_width(x, y + windowHeight, x + windowWidth, y + windowHeight, 3);



}

function scr_panelPaneDrawBranch() {
	
	var camWidth = camera_get_view_width(camera_get_active());
	obj_control.mouseoverTagCell = false;
	
	switch (currentFunction) {
		
		// LEFT NAV WINDOW
		case functionChainList:
			with (obj_panelPaneL) {
				if (showNavLeft) {
				
					x = 0;
					windowWidth = camWidth * 0.5;
				
					scr_dropShadow(x, y, x + windowWidth, y + windowHeight);
					draw_set_alpha(1);
					draw_set_color(global.colorThemePaneBG);
					draw_rectangle(x, y, x + windowWidth, y + windowHeight, false);
					draw_set_color(global.colorThemeBorders);
					draw_rectangle(x, y, x + windowWidth, y + windowHeight, true);

					// all the possible left panes
					if (functionChainList_currentTab == NAVTAB_UNIT) {
						scr_panelPane_drawUnitsList();
					}
					else if (functionChainList_currentTab == NAVTAB_SHOW) {
						scr_panelPane_drawShowList();
					}
					else if (functionChainList_currentTab == NAVTAB_TRANSLATION) {
						scr_panelPane_drawUnitsList();
					}
					else if (functionChainList_currentTab == NAVTAB_TAG) {
						scr_panelPane_drawFieldList();
					}
					else if (functionChainList_currentTab == NAVTAB_SEARCH) {
						scr_panelPane_drawSearchList();
					}			
					else if (functionChainList_currentTab == NAVTAB_CHUNK) {
						scr_panelPane_drawChunkList();
					}
					else if (functionChainList_currentTab == NAVTAB_CLIQUE) {
						scr_panelPane_drawCliqueList();
					}
					else if (functionChainList_currentTab == NAVTAB_TREE) {
						scr_panelPane_drawTreeList();
					}
					else {
						scr_panelPane_drawChainsList();
					}
			
					clickedIn = point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + windowHeight);
				}
				if (!obj_control.scrollBarHolding and !chainListPane.scrollBarHolding) {
					alarm[6] = 1;	
				}
				else {
					scrollBarClickLock = true;	
				}
			}
			break;
			
			
			
		// RIGHT NAV WINDOW
		case functionChainContents:
			with (obj_panelPaneR) {
				x = floor(camWidth * 0.5) ;
				windowWidth = camWidth - x;
		
				if (showNavRight) {
					scr_dropShadow(x, y, x + windowWidth, y + windowHeight);
					draw_set_alpha(1);
					draw_set_color(global.colorThemeBG);
					draw_rectangle(x, y, x + windowWidth, y + windowHeight, false);
					draw_set_color(global.colorThemeBorders);
					draw_rectangle(x, y, x + windowWidth, y + windowHeight, true);
					if (is_numeric(functionChainContents_BGColor)) {
						// if we are on the line tab, set the BG color to be regular
						if (functionChainList_currentTab != NAVTAB_RESONANCE && functionChainList_currentTab != NAVTAB_TRACK && functionChainList_currentTab != NAVTAB_STACK) {
							functionChainContents_BGColor = global.colorThemeBG;
						}
						// if the BG color is not regular, draw a rectangle with the color of the corresponding chain
						if (functionChainContents_BGColor != global.colorThemeBG) {
							draw_set_alpha(1);
							draw_set_color(merge_color(functionChainContents_BGColor, global.colorThemeBG, 0.9));
							draw_rectangle(x, y, x + windowWidth, y + windowHeight, false);
						}
					}
					else {
						functionChainContents_BGColor = global.colorThemeBG;
					}
		
					if (chainViewOneToMany) {
						// one to many
						if (functionChainList_currentTab == NAVTAB_UNIT) {
								if (BUILDTYPE == "Web") scr_surfaceStart();
								scr_panelPane_drawUnits1toMany();
								scr_panelPane_drawUnits1ToManyHeaders();
								if (BUILDTYPE == "Web") scr_surfaceEnd();
						}
						else if (functionChainList_currentTab == NAVTAB_SHOW) {
							scr_panelPane_drawShow1toMany();
						}
						else if (functionChainList_currentTab == NAVTAB_TRANSLATION) {
							scr_panelPane_drawLineTranslationLoopClipped();
						}
						else if (functionChainList_currentTab == NAVTAB_TAG) {
							scr_panelPane_drawFieldTags();
						}
						else if (functionChainList_currentTab == NAVTAB_SEARCH) {
							scr_panelPane_drawSearch1ToMany();
						}
						else if (functionChainList_currentTab == NAVTAB_CHUNK) {
							if (BUILDTYPE == "Web") scr_surfaceStart();
							scr_panelPane_drawUnits1toMany();
							scr_panelPane_drawUnits1ToManyHeaders();
							if (BUILDTYPE == "Web") scr_surfaceEnd();
						}
						else if (functionChainList_currentTab == NAVTAB_CLIQUE) {
							scr_panelPane_drawCliques1ToMany();
						}
						else if (functionChainList_currentTab == NAVTAB_TREE) {
							scr_panelPane_drawTree1ToMany();
						}
						else {
							if (BUILDTYPE == "Web") scr_surfaceStart();
							scr_panelPane_drawChains1ToMany();
							scr_panelPane_drawChains1ToManyHeaders();
							if (BUILDTYPE == "Web") scr_surfaceEnd();
						}
					}
					else {
						// one to one
						if (functionChainList_currentTab == NAVTAB_UNIT) {
							if (BUILDTYPE == "Web") scr_surfaceStart();
							scr_panelPane_drawUnits1to1();
							if (BUILDTYPE == "Web") scr_surfaceEnd();
						}
						else if (functionChainList_currentTab == NAVTAB_SHOW) {
							scr_panelPane_drawShow1toMany();
						}
						else if (functionChainList_currentTab == NAVTAB_TAG) {
								scr_panelPane_drawFieldTags();
						}
						else if (functionChainList_currentTab == NAVTAB_TRANSLATION) {
							scr_panelPane_drawLineTranslationLoopClipped();
						}
						else if (functionChainList_currentTab == NAVTAB_SEARCH) {
							scr_panelPane_drawSearch1ToMany();
						}
						else if (functionChainList_currentTab == NAVTAB_CHUNK) {
							if (BUILDTYPE == "Web") scr_surfaceStart();
							scr_panelPane_drawChunks1To1();
							if (BUILDTYPE == "Web") scr_surfaceEnd();
						}
						else if (functionChainList_currentTab == NAVTAB_CLIQUE) {
							scr_panelPane_drawCliques1ToMany();
						}
						else if (functionChainList_currentTab == NAVTAB_TREE) {
							scr_panelPane_drawTree1ToMany();
						}
						else {
							if (BUILDTYPE == "Web") scr_surfaceStart()
							scr_panelPane_drawChains1To1();
							if (BUILDTYPE == "Web") scr_surfaceEnd();
						}
					}
				

			
					clickedIn = point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + windowHeight);
				}
		
				if (not obj_control.scrollBarHolding and not scrollBarHolding) {
					alarm[6] = 1;	
				}
				else {
					scrollBarClickLock = true;	
				}
			}
			break;
			
			
		case functionHelp:
			if (obj_toolPane.showTool) {
				if (!obj_panelPane.functionHelp_collapsed) {
					scr_panelPane_drawHelp();
				}
			}
			if (not obj_control.scrollBarHolding and not scrollBarHolding) {
				alarm[6] = 1;	
			}
			else {
				scrollBarClickLock = true;	
			}
			break;
			
			
		
		
			
			
		case functionTabs:

			if (obj_panelPane.showNav) {
				draw_set_color(global.colorThemeBG);
				draw_rectangle(x, y, x + windowWidth, y + windowHeight, false);
		
				windowWidth = camera_get_view_width(camera_get_active());
				windowHeight = functionTabs_tabHeight;
				scr_panelPane_drawTabs();
			}
			break;
			
			
		default:
			break;
	}
	

}
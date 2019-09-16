/*
	scr_panelPane_drawChainTabs();
	
	Last Updated: 2019-01-29
	
	Called from: obj_panelPane
	
	Purpose: draw Rez, Track, and Stack tabs on chainList panel pane
	
	Mechanism: loop 3 times and create a rectangle button tab for each type of chain
	
	Author: Terry DuBois, Georgio Klironomos
*/

// Set opacity, font, and alignment of text in chain tabs
draw_set_alpha(1);
draw_set_font(global.fontPanelTab);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

var textMarginLeft = 5;
with (obj_panelPane) {
	functionChainList_tabHeight = string_height("0") + 8;
}

var tabAmount = 4;

if (obj_panelPane.showNav) {
	y = obj_menuBar.menuHeight;
}

var tabRectY1 = y;
var tabRectY2 = tabRectY1 + functionChainList_tabHeight;
draw_set_color(global.colorThemeBG);
draw_rectangle(x, tabRectY1, x + windowWidth, tabRectY2, false);


for (var i = 0; i < tabAmount; i++) {// main mechanism
	
	// set dimensions for tabs
	var tabRectX1 = x + (i * (windowWidth / tabAmount));
	var tabRectX2 = tabRectX1 + (windowWidth / tabAmount);
	
	// highlight current tab
	if (i == functionChainList_currentTab) {
		draw_set_color(global.colorThemeSelected1);
		draw_rectangle(tabRectX1, tabRectY1, tabRectX2, tabRectY2, false);
	}
	
	// set XY for toggleDraw button
	var toggleDrawRectSize = (tabRectY2 - tabRectY1) - 8;
	var toggleDrawRectX1 = tabRectX2 - toggleDrawRectSize - 4;
	var toggleDrawRectY1 = tabRectY1 + 4;
	var toggleDrawRectX2 = toggleDrawRectX1 + toggleDrawRectSize;
	var toggleDrawRectY2 = toggleDrawRectY1 + toggleDrawRectSize;
	if (i == 0) {
		draw_sprite_ext(spr_toggleDraw, obj_chain.toggleDrawRez, mean(toggleDrawRectX1, toggleDrawRectX2), mean(toggleDrawRectY1, toggleDrawRectY2), 1, 1, 0, c_white, 1);
	}
	else if (i == 1) {
		draw_sprite_ext(spr_toggleDraw, obj_chain.toggleDrawTrack, mean(toggleDrawRectX1, toggleDrawRectX2), mean(toggleDrawRectY1, toggleDrawRectY2), 1, 1, 0, c_white, 1);
	}
	else if (i == 2) {
		draw_sprite_ext(spr_toggleDraw, obj_chain.toggleDrawStack, mean(toggleDrawRectX1, toggleDrawRectX2), mean(toggleDrawRectY1, toggleDrawRectY2), 1, 1, 0, c_white, 1);
	}
	if (point_in_rectangle(mouse_x, mouse_y, toggleDrawRectX1, toggleDrawRectY1, toggleDrawRectX2, toggleDrawRectY2)) {
		draw_set_color(global.colorThemeBorders);
		draw_rectangle(toggleDrawRectX1, toggleDrawRectY1, toggleDrawRectX2, toggleDrawRectY2, true);
		if (mouse_check_button_released(mb_left)) {
			if (i == 0) {
				obj_chain.toggleDrawRez = !obj_chain.toggleDrawRez;
			}
			else if (i == 1) {
				obj_chain.toggleDrawTrack = !obj_chain.toggleDrawTrack;
			}
			else if (i == 2) {
				obj_chain.toggleDrawStack = !obj_chain.toggleDrawStack;
			}
		}
	}
	
	// check for mouse clicks to change the selected tab
	if (point_in_rectangle(mouse_x, mouse_y, tabRectX1, tabRectY1, tabRectX2, tabRectY2)) {
		if (device_mouse_check_button_released(0, mb_left)) {
			functionChainList_currentTab = i;
			
			// unfocus chains of all type
			scr_unFocusAllChains();
			
			//refocus chains related to currently selected tab
			
			if (functionChainList_currentTab >= 0) {
				scr_reFocusOldChains();
			}
		}
	}
	
	// keeps drawing the name of the tabs
	draw_set_color(global.colorThemeBorders);
	draw_rectangle(tabRectX1, tabRectY1, tabRectX2, tabRectY2, true);
	draw_set_color(global.colorThemeText);
	draw_text(tabRectX1 + textMarginLeft, tabRectY1, functionChainList_tabName[i]);

}
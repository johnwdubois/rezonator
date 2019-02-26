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
draw_set_valign(fa_middle);

var textMarginLeft = 5;
var tabHeight = 16;

var tabAmount = 4;

for (var i = 0; i < tabAmount; i++)// main mechanism
{
	// set dimensions for tabs
	var tabRectX1 = x + (i * (windowWidth / tabAmount));
	var tabRectY1 = y;
	var tabRectX2 = tabRectX1 + (windowWidth / tabAmount);
	var tabRectY2 = tabRectY1 + tabHeight;
	
	// highlight current tab
	if (i == functionChainList_currentTab)
	{
		draw_set_color(global.colorThemeSelected1);
		draw_rectangle(tabRectX1, tabRectY1, tabRectX2, tabRectY2, false);
	}
	
	// check for mouse clicks to change the selected tab
	if (point_in_rectangle(mouse_x, mouse_y, tabRectX1, tabRectY1, tabRectX2, tabRectY2))
	{
		if (mouse_check_button_pressed(mb_left))
		{
			functionChainList_currentTab = i;
			
			// unfocus chains of all type
			scr_unFocusAllChains();
			
			//refocus chains related to currently selected tab
			
			if(functionChainList_currentTab >= 0) {
				scr_reFocusOldChains();
			}
			
		}
	}
	
	// keeps drawing the name of the tabs
	draw_set_color(global.colorThemeBorders);
	draw_rectangle(tabRectX1, tabRectY1, tabRectX2, tabRectY2, true);
	draw_set_color(global.colorThemeText);
	draw_text(tabRectX1 + textMarginLeft, mean(tabRectY1, tabRectY2), functionChainList_tabName[i]);

}
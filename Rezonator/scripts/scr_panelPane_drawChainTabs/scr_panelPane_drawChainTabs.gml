/*
	scr_panelPane_drawChainTabs();
	
	Last Updated: 2018-07-12
	
	Called from: obj_panelPane
	
	Purpose: draw Rez, Track, and Stack tabs on chainList panel pane
	
	Mechanism: loop 3 times and create a rectangle button tab for each type of chain
*/

draw_set_alpha(1);
draw_set_font(fnt_panelTab);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);

var textMarginLeft = 5;
var tabHeight = 16;

var tabAmount = 4;

for (var i = 0; i < tabAmount; i++)
{
	
	var tabRectX1 = x + (i * (windowWidth / tabAmount));
	var tabRectY1 = y;
	var tabRectX2 = tabRectX1 + (windowWidth / tabAmount);
	var tabRectY2 = tabRectY1 + tabHeight;
	
	if (i == functionChainList_currentTab)
	{
		draw_set_color(c_ltgray);
		draw_rectangle(tabRectX1, tabRectY1, tabRectX2, tabRectY2, false);
	}
	
	if (point_in_rectangle(mouse_x, mouse_y, tabRectX1, tabRectY1, tabRectX2, tabRectY2))
	{//tab focus might be solved here
		if (mouse_check_button_pressed(mb_left))
		{
			functionChainList_currentTab = i;
			
			scr_unFocusAllChains();
			
			//call reFocus function
			if(functionChainList_currentTab >= 0) {
				scr_reFocusOldChains();
			}
		}
	}
	
	draw_set_color(c_black);
	draw_rectangle(tabRectX1, tabRectY1, tabRectX2, tabRectY2, true);
	draw_text(tabRectX1 + textMarginLeft, mean(tabRectY1, tabRectY2), functionChainList_tabName[i]);
	

}
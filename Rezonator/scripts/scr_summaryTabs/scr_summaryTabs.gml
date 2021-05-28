function scr_summaryTabs(){


	var tabAmount = ds_list_size(tabList);
	var tabWidth = string_width("  Exceptions  ");
	var strHeight = string_height("0");

	var plusX = 0;

	for (var i = 0; i < tabAmount; i++) {
		
		var tabText = tabList[| i];
		var tabSelected = (selectedTab == tabText);
		
		// tab coordinates
		var tabX1 = x + plusX;
		var tabY1 = y - (strHeight * 1.5);
		var tabX2 = tabX1 + tabWidth;
		var tabY2 = y + 5;
		var tabTextX = floor(mean(tabX1, tabX2));
		var tabTextY = floor(mean(tabY1, tabY2));
		
		// tab rect
		draw_set_color(tabSelected ? global.colorThemeBG : global.colorThemeSelected1);
		draw_roundrect(tabX1, tabY1, tabX2, tabY2, false);


		// tab text
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		scr_adaptFont(scr_get_translation(tabText), "M");
		draw_set_color(tabSelected ? global.colorThemeRezPurple : global.colorThemeText);
		draw_text(tabTextX, tabTextY, scr_get_translation(tabText));
		
		// purple underline if this tab is selected
		if (tabSelected) {
			var spaceWidth = string_width("  ");
			draw_line_width(tabX1 + spaceWidth, tabTextY + (strHeight * 0.6), tabX2 - spaceWidth, tabTextY + (strHeight * 0.6), 3);
		}
		
	
		// mouseover & click on tab
		var mouseOverTab = point_in_rectangle(mouse_x,mouse_y, tabX1, tabY1, tabX2, tabY2);
		if (mouseOverTab) {
			if (device_mouse_check_button_released(0, mb_left)) {
				selectedTab = tabText;
			}
		}
	

	
		plusX += tabWidth+ 5;
		
	}
}
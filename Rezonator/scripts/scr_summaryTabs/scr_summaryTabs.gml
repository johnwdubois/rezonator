// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_summaryTabs(){

	var tabAmount = ds_list_size(tabList);
	var tabWidth = string_width("  Exceptions  ");

	var plusX = 0;

	for(var i =0; i < tabAmount ; i++){
	
		var tabRectX1 = x + plusX;
		var tabRectY1 = y - string_height("0")*1.5;
		var tabRectX2 = tabRectX1 + tabWidth;
		var tabRectY2 = y+5;
	

	
		var tabTextX = floor(mean(tabRectX1, tabRectX2));
		var tabTextY = floor(mean(tabRectY1, tabRectY2));
	
		if(selectedTab == i){
			draw_set_color(global.colorThemeBG);
		}
		else{
			draw_set_color(global.colorThemeSelected1);
		}
		draw_roundrect(tabRectX1, tabRectY1, tabRectX2, tabRectY2, false);


		draw_set_color(global.colorThemeText);
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		var tabText = tabList[|i];
	
		scr_adaptFont(scr_get_translation(tabText), "M");
		draw_text(tabTextX, tabTextY, scr_get_translation(tabText));
	
	
		var mouseOverTab =point_in_rectangle(mouse_x,mouse_y,tabRectX1, tabRectY1, tabRectX2, tabRectY2);
		
		if(mouseOverTab){
			if(device_mouse_check_button_released(0, mb_left)){
				selectedTab = i;
			}
		}
	
	
	
	
		plusX += tabWidth+ 5;
		
		
	}
}
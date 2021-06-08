// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_panelPane_drawChains1To1Headers(chain1to1ColFieldList, chainType){
	
	var tabHeight = functionTabs_tabHeight;
	var textMarginLeft = 8;
	var chain1to1ColFieldListSize = ds_list_size(chain1to1ColFieldList);
	var lineStateLTR = (obj_control.drawLineState == obj_control.lineState_ltr);

	// Create the column headers
	for (var i = 0; i < chain1to1ColFieldListSize; i++) {
		
		// header coordinates
		var headerRectX1 = x + (i * (windowWidth / chain1to1ColFieldListSize));
		var headerRectY1 = y;
		var headerRectX2 = headerRectX1 + (windowWidth / chain1to1ColFieldListSize);
		var headerRectY2 = headerRectY1 + tabHeight;
		var mouseoverColHeader = point_in_rectangle(mouse_x, mouse_y, headerRectX1, headerRectY1, headerRectX2, headerRectY2) && !instance_exists(obj_dropDown) && !instance_exists(obj_dialogueBox);
		
		// get header column name
		var currentField = string(chain1to1ColFieldList[| i]);
		
		// BG & outline rects
		draw_set_color(global.colorThemeBG);
		draw_rectangle(headerRectX1, headerRectY1, headerRectX2, headerRectY1 + tabHeight, false);
		draw_set_color(global.colorThemeBorders);
		draw_rectangle(headerRectX1, headerRectY1, headerRectX2, headerRectY1 + tabHeight, true);
		
		// draw line to separate column headers from data
		draw_set_color(global.colorThemeBorders);
		draw_rectangle(x, headerRectY1, x + windowWidth, headerRectY1 + tabHeight, true);
		
		
		// draw header name
		draw_set_valign(fa_middle);
		scr_adaptFont(currentField, "M");
		
		// get header text coordinates
		draw_set_halign(fa_left);
		var headerTextX = floor(headerRectX1 + (textMarginLeft));
		if (!lineStateLTR) {
			draw_set_halign(fa_right);
			headerTextX = floor(headerRectX2 - (textMarginLeft * 2));
		}
		var headerTextY = floor(y + (tabHeight / 2));
		
		draw_set_color(global.colorThemeText);
		draw_text(headerTextX, headerTextY, currentField);
		
		// draw lines for dividing columns
		if(lineStateLTR){	
			if(i > 0){
				draw_set_color(global.colorThemeBorders);
				draw_line_width(headerRectX1, y, headerRectX1, y + windowHeight, 1);
			}
		}
		else{
			if(i > 0 && i < chain1to1ColFieldListSize){
				draw_set_color(global.colorThemeBorders);
				draw_line_width(headerRectX1 + 1, y, headerRectX1 + 1, y + windowHeight, 1);
			}
		}
		

		if (mouseoverColHeader) {
			
			scr_createTooltip(mean(headerRectX1, headerRectX2), headerRectY2, "Change field", obj_tooltip.arrowFaceUp);
			
			// draw underline
			var underlineX1 = headerTextX;
			var underlineX2 = headerTextX + string_width(currentField);
			var underlineY = headerTextY + (tabHeight * 0.25);
			draw_set_color(global.colorThemeBorders);
			draw_line_width(underlineX1, underlineY, underlineX2, underlineY, 2);

			if (mouse_check_button_released(mb_left)) {
				obj_control.chain1To1ColFieldToChange = i;
				scr_createDropDown(headerRectX1, headerRectY1 + tabHeight, scr_getChainFieldList(chainType), global.optionListTypeChain1To1Field);
			}
		}
		
		
		// right-click on header
		if (mouseoverColHeader && mouse_check_button_released(mb_right) && !instance_exists(obj_dropDown) && !instance_exists(obj_dialogueBox)) {
			obj_control.chain1To1ColFieldToChange = i;
			var headerRightClickList = ds_list_create();
			ds_list_add(headerRightClickList, "Create Field");
			scr_createDropDown(headerRectX1, headerRectY1 + tabHeight, headerRightClickList, global.optionListTypeChain1To1HeaderRightClick);
		}
	}

}
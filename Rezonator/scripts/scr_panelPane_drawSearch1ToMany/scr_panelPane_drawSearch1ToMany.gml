// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_panelPane_drawSearch1ToMany(){

	
	
	var lineStateLTR = (obj_control.drawLineState == obj_control.lineState_ltr);
	var textMarginLeft = 8;
	var dropDownButtonSize = sprite_get_width(spr_dropDown);
	
	var tabHeight = functionTabs_tabHeight;
	
	var contextColWidth = windowWidth * 0.4;
	var hitColWidth = windowWidth * 0.2;

	var headerPlusX = 0;
	var colAmount = 3;
	for (var i = 0; i < 3; i++) {
		var colWidth = 0;
		// get coordinates for header rect
		if(i == 0  or i == 2){
			colWidth = contextColWidth;
		}
		else{
			colWidth = hitColWidth;
		}
		var headerRectX1 =  x + headerPlusX;
		var headerRectY1 = y;
		var headerRectX2 = headerRectX1 + colWidth;
		var headerRectY2 = headerRectY1 + tabHeight;
		var mouseoverColHeader = point_in_rectangle(mouse_x, mouse_y, headerRectX1, headerRectY1, headerRectX2, headerRectY2) && !instance_exists(obj_dropDown) && !instance_exists(obj_dialogueBox);
			
		// get coordinates for header text
		var headerTextX = 0;
		if(i == 0 ){
					draw_set_halign(fa_right);
			var headerTextX = floor(headerRectX2 - textMarginLeft);
		}
		
		else if(i == 1 ){
					draw_set_halign(fa_center);
			var headerTextX = floor(mean(headerRectX2 , headerRectX1));
		}
		
		else if(i == 2 ){
					draw_set_halign(fa_left);
			var headerTextX = floor(headerRectX1 + textMarginLeft);
		}
		

		var headerTextY = floor(y + (tabHeight / 2));
	
		// get header string for static columns
		var colName = "";
		switch (i) {
			case 0:
				colName = "before";
				break;
			case 1:
				colName = "hit"; // stacks
				break;
			case 2:
				colName = "after"; // stacks
				break;
			default:
				colName = "N/A";
				break;
		}

		// make headers not overlap with each other
		draw_set_color(global.colorThemeBG);
		draw_rectangle(headerRectX1, headerRectY1, headerRectX2, headerRectY1 + tabHeight, false);
		
		
		// draw header name
		draw_set_color(global.colorThemeText);
		draw_set_valign(fa_middle);


		scr_adaptFont(colName, "M");
			

			
		draw_text(headerTextX, headerTextY, colName);
		
	


		draw_set_color(global.colorThemeBorders);
		draw_line_width(headerRectX1, y, headerRectX1, y + windowHeight, 1);


		
		headerPlusX += colWidth;
	}


	// draw horizontal line between headers and contents
	draw_line(x , y + tabHeight , x + windowWidth , y + tabHeight);


}
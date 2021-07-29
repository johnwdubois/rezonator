/// @description Insert description here
// You can write your code in this editor
if ((obj_control.hoverTokenID != "" or obj_control.hoverUnitID != "") and wordTipDisplay == true) {

	if(obj_control.hoverUnitID != ""){
		currentID = obj_control.hoverUnitID;
	}
	else{
		// Make the box display the word at the mouse cursor
		currentID = obj_control.hoverTokenID;
	}
	x = floor(mouse_x + mouseCursorWidth);
	y = floor(mouse_y + mouseCursorHeight);

	var IDSubMap = global.nodeMap[?currentID];
	var IDType = IDSubMap[?"type"];
	var tagMap = IDSubMap[?"tagMap"];
	var plusY = 0;

	var maxPlusX = 0;
	var colX2Max = string_width("Attribute   ");

	/* --- determine size of box by field names and values to display --- */
	var sizeOfFieldList = 0;
	var fieldList = obj_control.tokenFieldList;
	if(IDType == "unit"){
		fieldList = obj_control.unitFieldList;
	}

	sizeOfFieldList = ds_list_size(fieldList);

	var spaceGap = string_width("   ");
	// For each attribute, get its value (from the tokenImportGrid) and put it in the 2nd column; if it does not exist, then remove the row from the attribute grid
	for (var i = 0; i < sizeOfFieldList; i++)
	{
		var fieldName = fieldList[|i];
		var fieldNameWidth = string_width(string(fieldName));
		var fieldValue = tagMap[?fieldName];
		var fieldValueWidth = string_width(string(fieldValue));
		plusY += string_height(string("0")) + 5;
		var lineWidth = fieldNameWidth + fieldValueWidth + spaceGap;
	
		colX2Max = max(fieldNameWidth + spaceGap,colX2Max);
		maxPlusX = max(colX2Max + fieldValueWidth + spaceGap,maxPlusX);


	}
	var lineHeight = string_height(string("0")) + 5;

	

	boxWidth = maxPlusX;	// Box width fits the whole row
	boxHeight = plusY;	// Box width fits the whole row

	/* --- Draw the WordTip box and its attribute grid --- */

	var boxX1 = x;
	var boxY1 = y;
	var boxX2 = (obj_control.drawLineState == obj_control.lineState_rtl) ? x - boxWidth : x + boxWidth;
	var boxY2 = y + boxHeight;
	
	


	// Handle the case where the box clips off the bottom of the screen
	var fullWindowHeight = camera_get_view_height(camera_get_active());
	if (boxY2 >= fullWindowHeight)
	{
		var overflowHeight = boxY2 - fullWindowHeight;
		boxY1 -= overflowHeight;
		boxY2 -= overflowHeight;
	}

	// Draw the box's outline
	draw_set_color(c_black);
	draw_rectangle(boxX1, boxY1, boxX2, boxY2, true);

	// Draw the box's fill color
	draw_set_color(make_color_rgb(245, 245, 245) );
	draw_rectangle(boxX1, boxY1, boxX2, boxY2, false);

/*
	// Draw the header's fill color
	draw_set_color(make_color_rgb(220, 220, 220) );
	draw_rectangle(boxX1, boxY1 + lineHeight, boxX2, boxY2, false);

	// Draw the header and column separator lines
	draw_set_color(c_grey);
	draw_line(boxX1, boxY1 + lineHeight, boxX2, boxY1 + lineHeight);	// Header line
*/

	// Set params for drawing text
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_set_color(global.colorThemeText);
	draw_set_alpha(1);

	var col1X = boxX1 + 5
	var col2X = boxX1 + colX2Max; 
	var valueY = boxY1 + string_height(string("0"))/2;
	if(obj_control.drawLineState == obj_control.lineState_rtl){
		col1X -= boxWidth;
		col2X -= boxWidth;
	}
	// Draw the attribute grid
	for(var i = 0; i < sizeOfFieldList; i++)
	{		
		/*
		if(i == 0){
			// Draw the headers
			var headerTextY = mean(boxY1 + lineHeight, boxY1);
			draw_text(col1X,floor(headerTextY), "Attribute");
			draw_text(col2X,floor(headerTextY), "Value");
		}
		else{
		*/
		var fieldName = fieldList[|i];
		var fieldValue = tagMap[?fieldName];
		
		// draw highlight if field is selected
		if ((IDType == "token" && fieldName == obj_panelPane.functionField_tokenFieldSelected)
		|| (IDType == "unit" && fieldName == obj_panelPane.functionField_unitFieldSelected)) {
			var rectY1 = valueY - (lineHeight * 0.5);
			var rectY2 = rectY1 + lineHeight;
			draw_set_color(merge_color(c_yellow, global.colorThemeBG, 0.4));
			draw_rectangle(boxX1, rectY1, boxX2, rectY2, false);
		}
		

		scr_adaptFont(fieldName, "M");
	
		// Draw the attribute name
		draw_set_color(global.colorThemeText);
		draw_text(col1X, floor(valueY), fieldName);
	
		scr_adaptFont(fieldValue, "M");
	
		// Draw the attribute value to the right
		if(!scr_isStrRTL(string(fieldValue)))
			draw_text(col2X, floor(valueY), fieldValue);
		else
			draw_text(col2X, floor(valueY), scr_stringReverse(fieldValue));
			
		if(i < sizeOfFieldList){
			valueY += lineHeight;
		}
	
		
	}
}
else{
	exit;
}

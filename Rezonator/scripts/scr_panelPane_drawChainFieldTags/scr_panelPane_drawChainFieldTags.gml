// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_panelPane_drawChainFieldTags(){


	draw_set_alpha(1);
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	
	var strHeight = string_height("0") * 1.5;
	var spaceWidth = string_width(" ");
	var headerHeight = functionTabs_tabHeight;
	var checkboxColX = x;
	var checkboxColWidth = strHeight * 1.2;
	var checkboxSize = checkboxColWidth * 0.35;
	var checkBoxScale = (checkboxColWidth* 0.5)/checkboxColWidth;
	var numColX = checkboxColX + checkboxColWidth;
	var numColWidth = windowWidth * 0.1;
	var tagNameColX = numColX + numColWidth;
	var tagNameColWidth = windowWidth * 0.7;
	var deleteColX = tagNameColX + tagNameColWidth;
	var deleteColWidth = windowWidth - (deleteColX - x);
	var mouseoverWindow = point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + windowHeight);
	var mouseoverHeader = point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + headerHeight);
	var checkboxX1 = mean(checkboxColX, checkboxColX + checkboxColWidth) - (checkboxSize * 0.5);
	var checkboxX2 = checkboxX1 + checkboxSize;
	var tagSelectedColor = merge_color(c_yellow, global.colorThemeBG, 0.4);


	
	scr_surfaceStart();
	
	

	if(chainViewOneToMany){
		var fieldSubMap = global.entryFieldMap[? functionField_entryFieldSelected];
	}
	else{
		var fieldSubMap = global.chainFieldMap[? functionField_chainFieldSelected];
	}

	if (scr_isNumericAndExists(fieldSubMap, ds_type_map)){
	
	
		var tagList = fieldSubMap[? "tagSet"];
		if (scr_isNumericAndExists(tagList, ds_type_list)){
		var tagListSize = ds_list_size(tagList);
	
	
			
			var plusY = strHeight;
			for (var i = 0; i < tagListSize+1; i++) {
		

				var currentRowY1 = y + plusY + scrollPlusY - 16;
				var currentRowY2 = currentRowY1 + strHeight;
				var mouseoverRow = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, x, currentRowY1, x + windowWidth, currentRowY2) && !instance_exists(obj_dropDown) && !mouseoverHeader;

						
				if(i < tagListSize){
				
				
				
					// mouseover & click
					if (mouseoverRow) {
						draw_set_color(merge_color(global.colorThemeSelected1, global.colorThemeBG, 0.5));
						draw_rectangle(x - clipX, currentRowY1 - clipY, x + windowWidth - clipX, currentRowY2 - clipY, false);
						if (mouse_check_button_released(mb_left)) {
							if(chainViewOneToMany){
								with(obj_panelPane){
									functionField_entryTagSelected = tagList[| i];
								}
							}
							else{
								with(obj_panelPane){
									functionField_chainTagSelected = tagList[| i];
								}
							}
						}
					}
		
					//check if this row/field has been selected
					var tagSelected = false;
					if(chainViewOneToMany){
						if (functionField_entryTagSelected == tagList[| i]) {
							tagSelected = true;
							draw_set_color(tagSelectedColor);
							draw_rectangle(x - clipX, currentRowY1 - clipY, x + windowWidth - clipX, currentRowY2 - clipY, false);
						}
					}
					else{
						if (functionField_chainTagSelected == tagList[| i]) {
							tagSelected = true;
							draw_set_color(tagSelectedColor);
							draw_rectangle(x - clipX, currentRowY1 - clipY, x + windowWidth - clipX, currentRowY2 - clipY, false);
						}
					}
				
				
					// draw checkbox
					var checkboxY1 = mean(currentRowY1, currentRowY2) - (checkboxSize * 0.5);
					var checkboxY2 = checkboxY1 + checkboxSize;
					if (tagSelected) {
						draw_set_color(global.colorThemeBG);
						draw_rectangle(checkboxX1 - clipX, checkboxY1 - clipY, checkboxX2 - clipX, checkboxY2 - clipY, false);
						draw_sprite_ext(spr_checkmark, 0, mean(checkboxX1, checkboxX2) - clipX, mean(checkboxY1, checkboxY2) - clipY, checkBoxScale, checkBoxScale, 0, global.colorThemeText, 1);
					}
					draw_set_color(global.colorThemeBorders);
					scr_drawRectWidth(checkboxX1 - clipX, checkboxY1 - clipY, checkboxX2 - clipX, checkboxY2 - clipY, 2, false);
				
		
		
		
					var delButtonX = mean(deleteColX, deleteColX + deleteColWidth);
					var delButtonY = currentRowY1 + (strHeight * 0.5);
					var mouseOverDel = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, deleteColX, currentRowY1, deleteColX + deleteColWidth - global.scrollBarWidth, currentRowY2)  && !instance_exists(obj_dropDown) && !instance_exists(obj_dialogueBox);
					var trashAlpha = .5;

								
					// mouseover & click on sequence arrows
					if (mouseOverDel) {
						draw_set_color(global.colorThemeSelected2);
						draw_rectangle(deleteColX - clipX, currentRowY1 - clipY, deleteColX + deleteColWidth - clipX, currentRowY2 - clipY, false);
						if (mouse_check_button_released(mb_left)) {
							scr_deleteFromList(tagList, tagList[| i]);
							if(chainViewOneToMany){
								with (obj_panelPane) functionField_entryTagSelected = "";
							}
							else{
								with (obj_panelPane) functionField_chainTagSelected = "";
							}
						}
						scr_createTooltip(delButtonX, currentRowY2, "Remove", obj_tooltip.arrowFaceUp);
					}
									
						trashAlpha = 1;

								
					draw_sprite_ext(spr_trash, 0, delButtonX - clipX, delButtonY - clipY, .7, .7, 0, global.colorThemeText, trashAlpha);
			
		
		
					// draw #
					draw_set_color(global.colorThemeText);
					draw_text(floor(numColX + spaceWidth) - clipX, floor(mean(currentRowY1, currentRowY2)) - clipY, string(i + 1));
		
					// draw field name
					draw_text(floor(tagNameColX + spaceWidth) - clipX, floor(mean(currentRowY1, currentRowY2)) - clipY, string(tagList[| i]));
				}
				else{
					
					// new tag row
					draw_set_color(merge_color(c_green, global.colorThemeBG, mouseoverRow ? 0.25 : 0.5));
					draw_rectangle(x - clipX, currentRowY1 - clipY, x + windowWidth - clipX, currentRowY2 - clipY, false);
					
					// mouseover & click
					if (mouseoverRow) {
						if (mouse_check_button_released(mb_left)) {
							if(chainViewOneToMany){
								obj_control.newCustomTagEntry = true;
								obj_control.dialogueBoxActive = true;
								obj_control.chain1toManyFieldToChange = functionField_entryFieldSelected;

								if (!instance_exists(obj_dialogueBox)) {
									instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
								}
							}
							else{
								obj_control.newCustomTagChain = true;
								obj_control.dialogueBoxActive = true;
								obj_control.chain1to1FieldToChange = functionField_chainFieldSelected;
								
								if (!instance_exists(obj_dialogueBox)) {
									instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
								}
							}
						}
					}
					// add new tag
					// draw #
					draw_set_color(global.colorThemeText);
					draw_text(floor(numColX + spaceWidth) - clipX, floor(mean(currentRowY1, currentRowY2)) - clipY,"+");
					
					draw_text(floor(tagNameColX + spaceWidth) - clipX, floor(mean(currentRowY1, currentRowY2)) - clipY, "New Tag");
				}
	
				plusY += strHeight;
			}

	
	
			scr_scrollBar(tagListSize+1, -1, strHeight, headerHeight,
					global.colorThemeSelected1, global.colorThemeSelected2,
					global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, windowWidth, windowHeight);
		}
	}
	
	scr_surfaceEnd();
	

	
	
	
	var headerTextY = floor(mean(y, y + headerHeight));
	
	// checkbox header
	draw_set_halign(fa_left);
	draw_set_color(global.colorThemeBG);
	draw_rectangle(checkboxColX, y, checkboxColX + checkboxColWidth, y + headerHeight, false);
	draw_set_color(global.colorThemeBorders);
	draw_rectangle(checkboxColX, y, checkboxColX + checkboxColWidth, y + headerHeight, true);
	draw_set_color(global.colorThemeText);
	
	// num header
	draw_set_color(global.colorThemeBG);
	draw_rectangle(numColX, y, numColX + numColWidth, y + headerHeight, false);
	draw_set_color(global.colorThemeBorders);
	draw_rectangle(numColX, y, numColX + numColWidth, y + headerHeight, true);
	draw_set_color(global.colorThemeText);
	draw_text(floor(numColX + spaceWidth), headerTextY, "#");
	
	// field name header
	draw_set_color(global.colorThemeBG);
	draw_rectangle(tagNameColX, y, x + windowWidth, y + headerHeight, false);
	draw_set_color(global.colorThemeBorders);
	draw_rectangle(tagNameColX, y, x + windowWidth, y + headerHeight, true);
	draw_set_color(global.colorThemeText);
	draw_text(floor(tagNameColX + spaceWidth), headerTextY, "Tag name");
	
	
	
	
		//json tag saving button
	var spriteScale = 0.4;
	var spriteSize = sprite_get_width(spr_oneToOneTool)* spriteScale;
	var oneToOneRectX2 = x + windowWidth - spaceWidth*3;
	var oneToOneRectX1 = oneToOneRectX2 - spriteSize;
	var oneToOneRectY1 =  mean(y ,y + headerHeight) - spriteSize/2;
	var oneToOneRectY2 = oneToOneRectY1 + spriteSize;
	
	var oneToOneSpriteX = floor(mean(oneToOneRectX1,oneToOneRectX2));
	var oneToOneSpriteY = floor(mean(oneToOneRectY1,oneToOneRectY2)+1);
	
	var oneToOneImageIndex = !obj_control.showUnitTags;
	
	var mouseOveroneToOne = point_in_rectangle(mouse_x,mouse_y,oneToOneRectX1,oneToOneRectY1,oneToOneRectX2,oneToOneRectY2)
	
	if(mouseOveroneToOne){
		draw_rectangle(oneToOneRectX1,oneToOneRectY1,oneToOneRectX2,oneToOneRectY2, true);
		if(device_mouse_check_button_released(0,mb_left)){
			if(obj_panelPane.chainViewOneToMany == true){
				scr_1to1Options("One to one");
			}
			else{
				scr_1to1Options("One to many");
			}

		}
			if(obj_panelPane.chainViewOneToMany == true){
				scr_createTooltip(oneToOneSpriteX, oneToOneRectY2,"Entry Fields", obj_tooltip.arrowFaceUp);
			}
			else{
				scr_createTooltip(oneToOneSpriteX, oneToOneRectY2,"Chain Fields", obj_tooltip.arrowFaceUp);
			}
		
	}
	draw_sprite_ext(spr_oneToOneTool,oneToOneImageIndex,oneToOneSpriteX,oneToOneSpriteY,spriteScale,spriteScale,0,global.colorThemeText, 1);
	
	
	
	
	
	//json tag saving button
	var spriteSize = sprite_get_width(spr_saveIcon);
	var saveRectX2 = oneToOneRectX1 - spaceWidth*3;
	var saveRectX1 = saveRectX2 - spriteSize;
	var saveRectY1 =  mean(y ,y + headerHeight) - spriteSize/2;
	var saveRectY2 = saveRectY1 + spriteSize;
	
	var saveSpriteX = floor(mean(saveRectX1,saveRectX2));
	var saveSpriteY = floor(mean(saveRectY1,saveRectY2)+1);
	
	var mouseOverSave = point_in_rectangle(mouse_x,mouse_y,saveRectX1,saveRectY1,saveRectX2,saveRectY2)
	
	if(mouseOverSave){
		draw_rectangle(saveRectX1,saveRectY1,saveRectX2,saveRectY2, true);
		if(device_mouse_check_button_released(0,mb_left)){
			scr_saveTagJson();
		}
		scr_createTooltip(saveSpriteX, saveRectY2,"Save Tag JSON", obj_tooltip.arrowFaceUp);
	}
	draw_sprite_ext(spr_saveIcon,0,saveSpriteX,saveSpriteY,1,1,0,global.colorThemeText, 1);
	
	// json tag loading button
	var spriteSize = sprite_get_width(spr_loadingIcon);
	var loadRectX2 = saveRectX1 - spaceWidth*3;
	var loadRectX1 = loadRectX2 - spriteSize;
	var loadRectY1 =  mean(y ,y + headerHeight) - spriteSize/2;
	var loadRectY2 = loadRectY1 + spriteSize;
	
	var loadSpriteX = floor(mean(loadRectX1,loadRectX2));
	var loadSpriteY = floor(mean(loadRectY1,loadRectY2)+1);
	
	var mouseOverload = point_in_rectangle(mouse_x,mouse_y,loadRectX1,loadRectY1,loadRectX2,loadRectY2)
	
	if(mouseOverload){
		draw_rectangle(loadRectX1,loadRectY1,loadRectX2,loadRectY2, true);
		if(device_mouse_check_button_released(0,mb_left)){
			scr_loadTagJson();
		}
		scr_createTooltip(loadSpriteX, loadRectY2,"Load Tag JSON", obj_tooltip.arrowFaceUp);
	}
	draw_sprite_ext(spr_loadingIcon,0,loadSpriteX,loadSpriteY,1,1,0,global.colorThemeText, 1);
	
	
	// toggle Discourse / Chains Button
	
	var switchPaneRButtonSizeX = string_width("Discourse") + spaceWidth*4;
	var switchPaneRButtonSizeY = string_height("Discourse");
	var switchPaneRRectX2 = loadRectX1 - spaceWidth*3;
	var switchPaneRRectX1 = switchPaneRRectX2 - switchPaneRButtonSizeX;
	var switchPaneRRectY1 =  mean(y ,y + headerHeight) - switchPaneRButtonSizeY/2;
	var switchPaneRRectY2 = switchPaneRRectY1 + switchPaneRButtonSizeY;
	
	var mouseOverswitchPaneR = point_in_rectangle(mouse_x,mouse_y,switchPaneRRectX1,switchPaneRRectY1,switchPaneRRectX2,switchPaneRRectY2)
	
	draw_set_color(global.colorThemeRezPurple);
	draw_rectangle(switchPaneRRectX1,switchPaneRRectY1,switchPaneRRectX2,switchPaneRRectY2, true);
	draw_rectangle(switchPaneRRectX1,switchPaneRRectY1,switchPaneRRectX2,switchPaneRRectY2, fieldPaneSwitchButton != "Discourse");
	if(mouseOverswitchPaneR){
		if (device_mouse_check_button_released(0,mb_left) && fieldPaneSwitchButton != "Discourse") {
			with (obj_panelPane) fieldPaneSwitchButton = "Discourse";
		}
	}
	
	var switchPaneRTextX = floor(mean(switchPaneRRectX1,switchPaneRRectX2));
	var switchPaneRTextY = floor(mean(switchPaneRRectY1,switchPaneRRectY2)+1);
	
	draw_set_halign(fa_center);
	draw_set_color((fieldPaneSwitchButton == "Discourse") ? global.colorThemeBG : global.colorThemeText);
	draw_text(switchPaneRTextX,switchPaneRTextY,"Discourse");
	
	
	// toggle Discourse / Chains Button
	
	var switchPaneLButtonSizeX = string_width("Discourse")+ spaceWidth*4;
	var switchPaneLButtonSizeY = string_height("Discourse");
	var switchPaneLRectX2 = switchPaneRRectX1-2;
	var switchPaneLRectX1 = switchPaneLRectX2 - switchPaneLButtonSizeX;
	var switchPaneLRectY1 =  mean(y ,y + headerHeight) - switchPaneLButtonSizeY/2;
	var switchPaneLRectY2 = switchPaneLRectY1 + switchPaneLButtonSizeY;
	
	var mouseOverswitchPaneL = point_in_rectangle(mouse_x,mouse_y,switchPaneLRectX1,switchPaneLRectY1,switchPaneLRectX2,switchPaneLRectY2)
	
	draw_set_color(global.colorThemeRezPurple);
	draw_rectangle(switchPaneLRectX1,switchPaneLRectY1,switchPaneLRectX2,switchPaneLRectY2, true);
	draw_rectangle(switchPaneLRectX1,switchPaneLRectY1,switchPaneLRectX2,switchPaneLRectY2, fieldPaneSwitchButton != "Chain");
	if(mouseOverswitchPaneL){
		if (device_mouse_check_button_released(0,mb_left) && fieldPaneSwitchButton != "Chain") {
			with (obj_panelPane) fieldPaneSwitchButton = "Chain";
		}
	}
	
	var switchPaneLTextX = floor(mean(switchPaneLRectX1,switchPaneLRectX2));
	var switchPaneLTextY = floor(mean(switchPaneLRectY1,switchPaneLRectY2)+1);
	
	draw_set_halign(fa_center);
	draw_set_color((fieldPaneSwitchButton == "Chain") ? global.colorThemeBG : global.colorThemeText);
	draw_text(switchPaneLTextX,switchPaneLTextY,"Chain");
	
	
	
	
	if (mouseoverWindow && mouse_wheel_down()) {
		scrollPlusYDest -= 16;
	}
	if (mouseoverWindow && mouse_wheel_up()) {
		scrollPlusYDest += 16;
	}
	
	
}
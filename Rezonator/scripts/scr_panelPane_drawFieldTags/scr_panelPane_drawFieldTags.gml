// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_panelPane_drawFieldTags(){


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
	var deleteColWidth = clamp(windowWidth * 0.15, sprite_get_width(spr_trash), sprite_get_width(spr_trash) * 2);
	var deleteColX = x + windowWidth - deleteColWidth - global.scrollBarWidth;
	var mouseoverWindow = point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + windowHeight);
	var mouseoverHeader = point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + headerHeight);
	var checkboxX1 = mean(checkboxColX, checkboxColX + checkboxColWidth) - (checkboxSize * 0.5);
	var checkboxX2 = checkboxX1 + checkboxSize;
	var valid = true;


	scr_surfaceStart();
	
	var fieldSubMap = -1;
	if(fieldPaneSwitchButton == fieldPaneChainMode){
		// get submap for selected field
		if (chainViewOneToMany) fieldSubMap = global.entryFieldMap[? functionField_entryFieldSelected];
		else fieldSubMap = global.chainFieldMap[? functionField_chainFieldSelected];
		if (!scr_isNumericAndExists(fieldSubMap, ds_type_map)){valid = false;}
	}
	
	else if(fieldPaneSwitchButton == fieldPaneDocMode){
		if(chainViewOneToMany){
			var tokenTagMap = global.nodeMap[? "tokenTagMap"];
			if (scr_isNumericAndExists(tokenTagMap, ds_type_map)){
				fieldSubMap = tokenTagMap[? functionField_tokenFieldSelected];
			}
			else{
				valid = false;
			}
		}
		else{
			var unitTagMap = global.nodeMap[? "unitTagMap"];
			if (scr_isNumericAndExists(unitTagMap, ds_type_map)){
				fieldSubMap = unitTagMap[? functionField_unitFieldSelected];
			}
			else{
				valid = false;
			}
		}
	}
	
	else if(fieldPaneSwitchButton == fieldPaneChunkMode){
			var tokenTagMap = global.nodeMap[? "tokenTagMap"];
			if (scr_isNumericAndExists(tokenTagMap, ds_type_map)){
				fieldSubMap = tokenTagMap[? functionField_chunkFieldSelected];
			}
			else{
				valid = false;
			}
	}

	else if(fieldPaneSwitchButton == fieldPaneLinkMode){
			var linkTagMap = global.nodeMap[? "linkTagMap"];
			if (scr_isNumericAndExists(linkTagMap, ds_type_map)){
				fieldSubMap = linkTagMap[? functionField_linkFieldSelected];
			}
			else{
				valid = false;
			}
	}
	
	if(valid){
		if (scr_isNumericAndExists(fieldSubMap, ds_type_map)){
	
	
			var tagList = fieldSubMap[? "tagSet"];
			if (scr_isNumericAndExists(tagList, ds_type_list)){
			var tagListSize = ds_list_size(tagList);
	
	
			
				var plusY = strHeight;
				for (var i = 0; i < tagListSize+1; i++) {
		

					var currentRowY1 = y + plusY + scrollPlusY - 16;
					var currentRowY2 = currentRowY1 + strHeight;
					var mouseoverRow = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, x, currentRowY1, x + windowWidth, currentRowY2) && !instance_exists(obj_dropDown) && !instance_exists(obj_dialogueBox) && !mouseoverHeader && !mouseoverScrollBar && !scrollBarHolding;

						
					if(i < tagListSize){
				
				
				
						// mouseover & click
						if (mouseoverRow) {
							draw_set_color(merge_color(global.colorThemeSelected1, global.colorThemeBG, 0.5));
							draw_rectangle(x - clipX, currentRowY1 - clipY, x + windowWidth - clipX, currentRowY2 - clipY, false);
							if (mouse_check_button_released(mb_left)) {
								if(fieldPaneSwitchButton == fieldPaneDocMode){
									if(chainViewOneToMany){
										with(obj_panelPane){
											functionField_tokenTagSelected = tagList[| i];
										}
									}
									else{
										with(obj_panelPane){
											functionField_unitTagSelected = tagList[| i];
										}
									}
								}
								else if(fieldPaneSwitchButton == fieldPaneChainMode){
									if (chainViewOneToMany) {
										with(obj_panelPane) functionField_entryTagSelected = tagList[| i];
									}
									else{
										with(obj_panelPane)	functionField_chainTagSelected = tagList[| i];
									}
								}
								else if(fieldPaneSwitchButton == fieldPaneChunkMode){
									with(obj_panelPane)	functionField_chunkTagSelected = tagList[| i];
								}
								else if(fieldPaneSwitchButton == fieldPaneLinkMode){
									with(obj_panelPane)	functionField_linkTagSelected = tagList[| i];
								}
							}
						}
		
						//check if this row/field has been selected
						var tagSelected = false;
					
						if(fieldPaneSwitchButton == fieldPaneDocMode){
						
							if(chainViewOneToMany){
								if (functionField_tokenTagSelected == tagList[| i]) {
									tagSelected = true;
									draw_set_color(global.colorThemeSelected2);
									draw_rectangle(x - clipX, currentRowY1 - clipY, x + windowWidth - clipX, currentRowY2 - clipY, false);
								}
							}
							else{
								if (functionField_unitTagSelected == tagList[| i]) {
									tagSelected = true;
									draw_set_color(global.colorThemeSelected2);
									draw_rectangle(x - clipX, currentRowY1 - clipY, x + windowWidth - clipX, currentRowY2 - clipY, false);
								}
							}
						}
					
						else if(fieldPaneSwitchButton == fieldPaneChainMode){
							if(chainViewOneToMany){
								if (functionField_entryTagSelected == tagList[| i]) {
									tagSelected = true;
									draw_set_color(global.colorThemeSelected2);
									draw_rectangle(x - clipX, currentRowY1 - clipY, x + windowWidth - clipX, currentRowY2 - clipY, false);
								}
							}
							else {
								if (functionField_chainTagSelected == tagList[| i]) {
									tagSelected = true;
									draw_set_color(global.colorThemeSelected2);
									draw_rectangle(x - clipX, currentRowY1 - clipY, x + windowWidth - clipX, currentRowY2 - clipY, false);
								}
							}
						}
					
						else if(fieldPaneSwitchButton == fieldPaneChunkMode){
							if (functionField_chunkTagSelected == tagList[| i]) {
								tagSelected = true;
								draw_set_color(global.colorThemeSelected2);
								draw_rectangle(x - clipX, currentRowY1 - clipY, x + windowWidth - clipX, currentRowY2 - clipY, false);
							}
						}
					
						else if(fieldPaneSwitchButton == fieldPaneLinkMode){
							if (functionField_linkTagSelected == tagList[| i]) {
								tagSelected = true;
								draw_set_color(global.colorThemeSelected2);
								draw_rectangle(x - clipX, currentRowY1 - clipY, x + windowWidth - clipX, currentRowY2 - clipY, false);
							}
						}
					
						var textColor = tagSelected ? global.colorThemeBG : global.colorThemeText;
				
				
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
						var mouseOverDel = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, deleteColX, currentRowY1, deleteColX + deleteColWidth, currentRowY2) && mouseoverRow;
						var trashAlpha = .5;

								
						// mouseover & click on sequence arrows
						if (mouseOverDel) {
							draw_set_color(global.colorThemeSelected1);
							draw_rectangle(deleteColX - clipX, currentRowY1 - clipY, deleteColX + deleteColWidth - clipX, currentRowY2 - clipY, false);
							if (mouse_check_button_released(mb_left)) {
								if(fieldPaneSwitchButton == fieldPaneDocMode){
									if (chainViewOneToMany) {
										obj_control.tokenFieldToChange = functionField_tokenFieldSelected;
									}
									else {
										obj_control.unitFieldToChange = functionField_unitFieldSelected;
									}
									scr_removeFieldTagQuestionPrompt("tag", "unit", chainViewOneToMany ? "1toMany" : "1to1", tagList[| i]);
								}
								else if(fieldPaneSwitchButton == fieldPaneChainMode){
									if (chainViewOneToMany) {
										obj_control.chain1toManyFieldToChange = functionField_entryFieldSelected;
									}
									else {
										obj_control.chain1to1FieldToChange = functionField_chainFieldSelected;
									}
									scr_removeFieldTagQuestionPrompt("tag", "chain", chainViewOneToMany ? "1toMany" : "1to1", tagList[| i]);
								}

								else if(fieldPaneSwitchButton == fieldPaneChunkMode){

									obj_control.tokenFieldToChange = functionField_chunkFieldSelected;

									scr_removeFieldTagQuestionPrompt("tag", "chunk", chainViewOneToMany ? "1toMany" : "1to1", tagList[| i]);
								}
							
								else if(fieldPaneSwitchButton == fieldPaneLinkMode){

									obj_control.tokenFieldToChange = functionField_linkFieldSelected;

									scr_removeFieldTagQuestionPrompt("tag", "link", chainViewOneToMany ? "1toMany" : "1to1", tagList[| i]);
								}

							}
							scr_createTooltip(delButtonX, currentRowY2, "Remove", obj_tooltip.arrowFaceUp);
						}
									
						trashAlpha = 1;

								
						draw_sprite_ext(spr_trash, 0, delButtonX - clipX, delButtonY - clipY, .7, .7, 0, global.colorThemeText, trashAlpha);
			
		
		
						// draw #
						draw_set_color(textColor);
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
								if(fieldPaneSwitchButton == fieldPaneDocMode){
									if(chainViewOneToMany){
										obj_control.newCustomTagToken = true;
										obj_control.dialogueBoxActive = true;
										obj_control.tokenFieldToChange = functionField_tokenFieldSelected;

										if (!instance_exists(obj_dialogueBox)) {
											instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
										}
										obj_dialogueBox.inputWindowActive = true;
									}
									else{
										obj_control.newCustomTagUnit = true;
										obj_control.dialogueBoxActive = true;
										obj_control.unitFieldToChange = functionField_unitFieldSelected;
								
										if (!instance_exists(obj_dialogueBox)) {
											instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
										}
										obj_dialogueBox.inputWindowActive = true;
									}
								}
								else if(fieldPaneSwitchButton == fieldPaneChainMode){
								
									if(chainViewOneToMany){
										obj_control.newCustomTagEntry = true;
										obj_control.dialogueBoxActive = true;
										obj_control.chain1toManyFieldToChange = functionField_entryFieldSelected;

										if (!instance_exists(obj_dialogueBox)) {
											instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
										}
										obj_dialogueBox.inputWindowActive = true;
									}
									else{
										obj_control.newCustomTagChain = true;
										obj_control.dialogueBoxActive = true;
										obj_control.chain1to1FieldToChange = functionField_chainFieldSelected;
								
										if (!instance_exists(obj_dialogueBox)) {
											instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
										}
										obj_dialogueBox.inputWindowActive = true;
									}
								}
								else if(fieldPaneSwitchButton == fieldPaneChunkMode){
								
									obj_control.newCustomTagChunk = true;
									obj_control.dialogueBoxActive = true;
									obj_control.tokenFieldToChange = functionField_chunkFieldSelected;
								
									if (!instance_exists(obj_dialogueBox)) {
										instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
									}
									obj_dialogueBox.inputWindowActive = true;
								
								}
								else if(fieldPaneSwitchButton == fieldPaneLinkMode){
								
									obj_control.newCustomTagLink = true;
									obj_control.dialogueBoxActive = true;
									obj_control.tokenFieldToChange = functionField_linkFieldSelected;
								
									if (!instance_exists(obj_dialogueBox)) {
										instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
									}
									obj_dialogueBox.inputWindowActive = true;
								
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
	
	var oneToOneImageIndex = chainViewOneToMany;
	
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
		if(fieldPaneSwitchButton == fieldPaneDocMode){
			if(obj_panelPane.chainViewOneToMany == true){
				scr_createTooltip(oneToOneSpriteX, oneToOneRectY2,"Token Fields", obj_tooltip.arrowFaceUp);
			}
			else{
				scr_createTooltip(oneToOneSpriteX, oneToOneRectY2,"Unit Fields", obj_tooltip.arrowFaceUp);
			}
		}
		else if(fieldPaneSwitchButton == fieldPaneChainMode){
			if(obj_panelPane.chainViewOneToMany == true){
				
				scr_createTooltip(oneToOneSpriteX, oneToOneRectY2,"Entry Fields", obj_tooltip.arrowFaceUp);
			}
			else{
				
				scr_createTooltip(oneToOneSpriteX, oneToOneRectY2,"Chain Fields", obj_tooltip.arrowFaceUp);
			}
		}
		else if(fieldPaneSwitchButton == fieldPaneChunkMode){
			scr_createTooltip(oneToOneSpriteX, oneToOneRectY2,"Chunk Fields", obj_tooltip.arrowFaceUp);
		}
		else if(fieldPaneSwitchButton == fieldPaneLinkMode){
			scr_createTooltip(oneToOneSpriteX, oneToOneRectY2,"Link Fields", obj_tooltip.arrowFaceUp);
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
	
	
	// toggle DOC / Chains / chunk / link Button
	
	var switchPaneDocButtonSizeX = string_width("Doc") + spaceWidth*4;
	var switchPaneDocButtonSizeY = string_height("Doc");
	var switchPaneDocRectX2 = loadRectX1 - spaceWidth*3;
	var switchPaneDocRectX1 = switchPaneDocRectX2 - switchPaneDocButtonSizeX;
	var switchPaneDocRectY1 =  mean(y ,y + headerHeight) - switchPaneDocButtonSizeY/2;
	var switchPaneDocRectY2 = switchPaneDocRectY1 + switchPaneDocButtonSizeY;
	
	var mouseOverswitchPaneDoc = point_in_rectangle(mouse_x,mouse_y,switchPaneDocRectX1,switchPaneDocRectY1,switchPaneDocRectX2,switchPaneDocRectY2)
	
	draw_set_color(global.colorThemeRezPurple);
	draw_rectangle(switchPaneDocRectX1,switchPaneDocRectY1,switchPaneDocRectX2,switchPaneDocRectY2, true);
	draw_rectangle(switchPaneDocRectX1,switchPaneDocRectY1,switchPaneDocRectX2,switchPaneDocRectY2, fieldPaneSwitchButton != fieldPaneDocMode);
	if(mouseOverswitchPaneDoc){
		if (device_mouse_check_button_released(0,mb_left) && fieldPaneSwitchButton != fieldPaneDocMode) {
			with (obj_panelPane) fieldPaneSwitchButton = fieldPaneDocMode;
		}
	}
	
	var switchPaneDocTextX = floor(mean(switchPaneDocRectX1,switchPaneDocRectX2));
	var switchPaneDocTextY = floor(mean(switchPaneDocRectY1,switchPaneDocRectY2)+1);
	
	draw_set_halign(fa_center);
	draw_set_color((fieldPaneSwitchButton == fieldPaneDocMode) ? global.colorThemeBG : global.colorThemeText);
	draw_text(switchPaneDocTextX,switchPaneDocTextY,"Doc");
	
	
	// toggle Doc / CHAINS / chunk / link Button
	
	var switchPaneChainButtonSizeX = string_width("Chain")+ spaceWidth*4;
	var switchPaneChainButtonSizeY = string_height("Doc");
	var switchPaneChainRectX2 = switchPaneDocRectX1-2;
	var switchPaneChainRectX1 = switchPaneChainRectX2 - switchPaneChainButtonSizeX;
	var switchPaneChainRectY1 =  mean(y ,y + headerHeight) - switchPaneChainButtonSizeY/2;
	var switchPaneChainRectY2 = switchPaneChainRectY1 + switchPaneChainButtonSizeY;
	
	var mouseOverswitchPaneChain = point_in_rectangle(mouse_x,mouse_y,switchPaneChainRectX1,switchPaneChainRectY1,switchPaneChainRectX2,switchPaneChainRectY2)
	
	draw_set_color(global.colorThemeRezPurple);
	draw_rectangle(switchPaneChainRectX1,switchPaneChainRectY1,switchPaneChainRectX2,switchPaneChainRectY2, true);
	draw_rectangle(switchPaneChainRectX1,switchPaneChainRectY1,switchPaneChainRectX2,switchPaneChainRectY2, fieldPaneSwitchButton != fieldPaneChainMode);
	if(mouseOverswitchPaneChain){
		if (device_mouse_check_button_released(0,mb_left) && fieldPaneSwitchButton != fieldPaneChainMode) {
			with (obj_panelPane) fieldPaneSwitchButton = fieldPaneChainMode;
		}
	}
	
	var switchPaneChainTextX = floor(mean(switchPaneChainRectX1,switchPaneChainRectX2));
	var switchPaneChainTextY = floor(mean(switchPaneChainRectY1,switchPaneChainRectY2)+1);
	
	draw_set_halign(fa_center);
	draw_set_color((fieldPaneSwitchButton == fieldPaneChainMode) ? global.colorThemeBG : global.colorThemeText);
	draw_text(switchPaneChainTextX,switchPaneChainTextY,"Chain");
	
	
	// toggle Doc / Chains / CHUNK / link Button
	
	var switchPaneChunkButtonSizeX = string_width("Chunk")+ spaceWidth*4;
	var switchPaneChunkButtonSizeY = string_height("Doc");
	var switchPaneChunkRectX2 = switchPaneChainRectX1-2;
	var switchPaneChunkRectX1 = switchPaneChunkRectX2 - switchPaneChunkButtonSizeX;
	var switchPaneChunkRectY1 =  mean(y ,y + headerHeight) - switchPaneChunkButtonSizeY/2;
	var switchPaneChunkRectY2 = switchPaneChunkRectY1 + switchPaneChunkButtonSizeY;
	
	var mouseOverswitchPaneChunk = point_in_rectangle(mouse_x,mouse_y,switchPaneChunkRectX1,switchPaneChunkRectY1,switchPaneChunkRectX2,switchPaneChunkRectY2)
	
	draw_set_color(global.colorThemeRezPurple);
	draw_rectangle(switchPaneChunkRectX1,switchPaneChunkRectY1,switchPaneChunkRectX2,switchPaneChunkRectY2, true);
	draw_rectangle(switchPaneChunkRectX1,switchPaneChunkRectY1,switchPaneChunkRectX2,switchPaneChunkRectY2, fieldPaneSwitchButton != fieldPaneChunkMode);
	if(mouseOverswitchPaneChunk){
		if (device_mouse_check_button_released(0,mb_left) && fieldPaneSwitchButton != fieldPaneChunkMode) {
			with (obj_panelPane) fieldPaneSwitchButton = fieldPaneChunkMode;
		}
	}
	
	var switchPaneChunkTextX = floor(mean(switchPaneChunkRectX1,switchPaneChunkRectX2));
	var switchPaneChunkTextY = floor(mean(switchPaneChunkRectY1,switchPaneChunkRectY2)+1);
	
	draw_set_halign(fa_center);
	draw_set_color((fieldPaneSwitchButton == fieldPaneChunkMode) ? global.colorThemeBG : global.colorThemeText);
	draw_text(switchPaneChunkTextX,switchPaneChunkTextY,"Chunk");
	
	
	// toggle Doc / Chains / Chunk / LINK Button
	
	var switchPaneLinkButtonSizeX = string_width("Link")+ spaceWidth*4;
	var switchPaneLinkButtonSizeY = string_height("Doc");
	var switchPaneLinkRectX2 = switchPaneChunkRectX1-2;
	var switchPaneLinkRectX1 = switchPaneLinkRectX2 - switchPaneLinkButtonSizeX;
	var switchPaneLinkRectY1 =  mean(y ,y + headerHeight) - switchPaneLinkButtonSizeY/2;
	var switchPaneLinkRectY2 = switchPaneLinkRectY1 + switchPaneLinkButtonSizeY;
	
	var mouseOverswitchPaneLink = point_in_rectangle(mouse_x,mouse_y,switchPaneLinkRectX1,switchPaneLinkRectY1,switchPaneLinkRectX2,switchPaneLinkRectY2)
	
	draw_set_color(global.colorThemeRezPurple);
	draw_rectangle(switchPaneLinkRectX1,switchPaneLinkRectY1,switchPaneLinkRectX2,switchPaneLinkRectY2, true);
	draw_rectangle(switchPaneLinkRectX1,switchPaneLinkRectY1,switchPaneLinkRectX2,switchPaneLinkRectY2, fieldPaneSwitchButton != fieldPaneLinkMode);
	if(mouseOverswitchPaneLink){
		if (device_mouse_check_button_released(0,mb_left) && fieldPaneSwitchButton != fieldPaneLinkMode) {
			with (obj_panelPane) fieldPaneSwitchButton = fieldPaneLinkMode;
		}
	}
	
	var switchPaneLinkTextX = floor(mean(switchPaneLinkRectX1,switchPaneLinkRectX2));
	var switchPaneLinkTextY = floor(mean(switchPaneLinkRectY1,switchPaneLinkRectY2)+1);
	
	draw_set_halign(fa_center);
	draw_set_color((fieldPaneSwitchButton == fieldPaneLinkMode) ? global.colorThemeBG : global.colorThemeText);
	draw_text(switchPaneLinkTextX,switchPaneLinkTextY,"Link");
	
	
	
	if (mouseoverWindow && mouse_wheel_down()) {
		scrollPlusYDest -= 16;
	}
	if (mouseoverWindow && mouse_wheel_up()) {
		scrollPlusYDest += 16;
	}
	
	
}
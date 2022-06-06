if(global.newProject)exit;
// setup coordinates for field summary window
recentFilesWindowX1 = camera_get_view_width(camera_get_active()) * 0.1;
recentFilesWindowY1 = camera_get_view_height(camera_get_active()) * 0.7;
recentFilesWindowX2 = camera_get_view_width(camera_get_active()) * 0.75;
recentFilesWindowY2 = camera_get_view_height(camera_get_active()) * 0.95;
x = recentFilesWindowX1;
y = recentFilesWindowY1;
windowWidth = recentFilesWindowX2 - recentFilesWindowX1;
windowHeight = recentFilesWindowY2 - recentFilesWindowY1;
var textXBuffer = 10;
var stringHeight = string_height("0");
// draw field summary window BG

draw_set_color(global.colorThemeText);
draw_set_halign(fa_left);

scr_adaptFont(scr_get_translation("Recent Files"), "L");
draw_text(recentFilesWindowX1, recentFilesWindowY1 - stringHeight, "Recent Files")

//draw_line_width(recentFilesWindowX1,recentFilesWindowY1 - stringHeight/3,recentFilesWindowX1+ string_width("Recent Files"),recentFilesWindowY1 - stringHeight/3, 3);


var mouseoverCancel = instance_exists(obj_dialogueBox) || instance_exists(obj_dropDown);
var mouseOverWindow = point_in_rectangle(mouse_x, mouse_y, recentFilesWindowX1,recentFilesWindowY1,recentFilesWindowX2,recentFilesWindowY2) && !mouseoverCancel;

scr_surfaceStart();


// calculate x & y values for text
var rowHeight = stringHeight*3;

var iconX = recentFilesWindowX1+ sprite_get_width(spr_toolsNew);
var fileTextX = iconX + rowHeight;
var plusY = recentFilesWindowY1+stringHeight;
var spaceWidth = string_width("   ");

var fileKeyListSize = ds_list_size(global.recentFilesList);
var scale = .7;
var textY = floor(plusY + scrollPlusY);
for (var i = 0; i < fileKeyListSize; i++) {
	
	
	
	
	textY = floor(plusY + scrollPlusY);
			
	
	var lineX1 = recentFilesWindowX1;
	var lineY1 = textY - rowHeight/2;
	var lineX2 = recentFilesWindowX2 - global.scrollBarWidth;
	var lineY2 = textY + rowHeight/2;
	
	
	
			
	var removeScale = 0.8;
	var removeButtonWidth = sprite_get_width(spr_xButton)*removeScale; 
	var removeButtonX2 = lineX2 - removeButtonWidth/2; 
	var removeButtonX1 = removeButtonX2 - removeButtonWidth; 
	var removeButtonY1 = lineY1 + removeButtonWidth/2; 
	var removeButtonY2 = removeButtonY1 + removeButtonWidth; 

	var mouseOverRemove = point_in_rectangle(mouse_x, mouse_y, removeButtonX1, removeButtonY1, removeButtonX2, removeButtonY2) && mouseOverWindow;
	
	
	
	
	
		
	draw_set_color(global.colorThemeText);
	// draw text for this cell
	var fileKey = string(global.recentFilesList[|i]);
	var fileMap = global.recentFilesMap[?fileKey];
	var filePath = "";
	var fileName = "";
	var fileDate = "";
	var color = c_black;
	if(scr_isNumericAndExists(fileMap, ds_type_map)){
		filePath = fileMap[?"FilePath"];
		fileName = fileMap[?"FileName"];
		fileDate = fileMap[?"Date"];
		color = fileMap[?"Color"];
	}
	
	if(!file_exists(filePath)){
		ds_map_delete(global.recentFilesMap,global.recentFilesList[|i]);
		ds_list_delete(global.recentFilesList,i);			
	}
	
	var mouseOverRow = point_in_rectangle(mouse_x, mouse_y, lineX1,lineY1,lineX2,lineY2) && mouseOverWindow;
	if(mouseOverRow){
		draw_set_color(c_white);
		draw_roundrect(lineX1 - clipX,lineY1 - clipY,lineX2 - clipX,lineY2 - clipY, false);
		
		if(mouseOverRemove){
			draw_set_color(global.colorThemeSelected1);
			draw_roundrect(removeButtonX1- clipX, removeButtonY1- clipY, removeButtonX2- clipX, removeButtonY2- clipY, false);
		
			if(mouse_check_button_released(mb_left)){
			
				scr_deleteFromList(global.recentFilesList, fileKey);
				scr_saveINI();
		
			}
		}
		
		if (mouse_check_button_released(mb_left) && (inputDelay == 0) && !mouseOverRemove) {
			global.selectedFile = filePath;
			global.openProject = true
			global.userName = obj_openingScreen.inputText;
		}
	}
	
	draw_set_color(global.colorThemeText);
	draw_set_halign(fa_left);
	
	if(mouseOverRow)draw_sprite_ext(spr_xButton,0,mean(removeButtonX1, removeButtonX2)- clipX,mean(removeButtonY1, removeButtonY2)- clipY,removeScale,removeScale,0,global.colorThemeText,1);

	scr_adaptFont(scr_get_translation(fileName), "L");
	draw_text(fileTextX - clipX, floor(textY- stringHeight/2 - clipY), scr_get_translation(string(fileName)));
	scr_adaptFont(scr_get_translation(fileName), "S");
	draw_text(fileTextX + string_width(scr_get_translation(string(fileName)+".rez"))+ spaceWidth- clipX, floor(textY- stringHeight/2 - clipY), "-  "+scr_get_translation(string(fileDate)));
	draw_set_alpha(0.75);
	scr_adaptFont(scr_get_translation(fileName), "S");
	draw_text(fileTextX - clipX, floor(textY+ stringHeight/1.5 - clipY), scr_get_translation(string(filePath)));
	draw_set_alpha(1);
	//draw_set_halign(fa_center);
	draw_text(recentFilesWindowX1 + spaceWidth - clipX, floor(textY - clipY), string(i+1));
	
	draw_sprite_ext(spr_toolsNew,1,iconX - clipX,textY - clipY,-scale,scale,0,color,1);
		
		

	plusY += rowHeight;
}

if(fileKeyListSize == 0 ){
	draw_text(recentFilesWindowX1 + spaceWidth - clipX, floor(textY - clipY), "No recent files");
}
	
// draw scrollbar only if we're not looking at field summary window
scr_scrollBar(fileKeyListSize, -1, rowHeight, 0,
	global.colorThemeSelected2, global.colorThemeSelected2,
	global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, windowWidth, windowHeight);

	// scroll mouse wheel
	if (mouse_wheel_up()) {
		scrollPlusYDest += stringHeight;
	}
	if (mouse_wheel_down()) {
		scrollPlusYDest -= stringHeight;
	}



scr_surfaceEnd();
draw_set_color(global.colorThemeRezPurple);
draw_set_alpha(0.5);
scr_drawRectWidth(recentFilesWindowX1, recentFilesWindowY1, recentFilesWindowX2, recentFilesWindowY2,1, true);
draw_set_alpha(1);
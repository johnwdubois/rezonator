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

var quickAccessTitle = scr_get_translation("menu_quick-access");
scr_adaptFont(quickAccessTitle, "L");
draw_text(recentFilesWindowX1, recentFilesWindowY1 - stringHeight, quickAccessTitle)



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
	
	var mouseOverRow = point_in_rectangle(mouse_x, mouse_y, lineX1, lineY1, lineX2, lineY2) && mouseOverWindow;
	if (mouseOverRow) {
		draw_set_color(c_white);
		draw_roundrect(lineX1 - clipX,lineY1 - clipY,lineX2 - clipX,lineY2 - clipY, false);
		
		// remove from recent files button
		var removeScale = 0.8;
		var removeButtonWidth = sprite_get_width(spr_xButton)*removeScale; 
		var removeButtonX2 = lineX2 - removeButtonWidth/2; 
		var removeButtonX1 = removeButtonX2 - removeButtonWidth; 
		var removeButtonY1 = lineY1 + removeButtonWidth/2; 
		var removeButtonY2 = removeButtonY1 + removeButtonWidth;
		var mouseOverRemove = point_in_rectangle(mouse_x, mouse_y, removeButtonX1, removeButtonY1, removeButtonX2, removeButtonY2) && mouseOverWindow;
		if (mouseOverRemove) {
			draw_set_color(global.colorThemeSelected1);
			draw_roundrect(removeButtonX1 - clipX, removeButtonY1 - clipY, removeButtonX2 - clipX, removeButtonY2 - clipY, false);
			scr_createTooltip(floor(mean(removeButtonX1, removeButtonX2)), removeButtonY2, scr_get_translation("menu_remove-quick-access"), obj_tooltip.arrowFaceUp);
			if (mouse_check_button_released(mb_left)) {
				scr_deleteFromList(global.recentFilesList, fileKey);
				scr_saveINI();
			}
		}	
		
		// copy filepath button
		var copyButtonX2 = removeButtonX1 - (removeButtonWidth / 2);
		var copyButtonY1 = removeButtonY1;
		var copyButtonX1 = copyButtonX2 - removeButtonWidth;
		var copyButtonY2 = removeButtonY2;
		var mouseOverCopyFilePath = point_in_rectangle(mouse_x, mouse_y, copyButtonX1, copyButtonY1, copyButtonX2, copyButtonY2) && mouseOverWindow;
		if (mouseOverCopyFilePath) {
			draw_set_color(global.colorThemeSelected1);
			draw_roundrect(copyButtonX1 - clipX, copyButtonY1 - clipY, copyButtonX2 - clipX, copyButtonY2 - clipY, false);
			scr_createTooltip(floor(mean(copyButtonX1, copyButtonX2)), copyButtonY2, scr_get_translation("menu_copy-filepath"), obj_tooltip.arrowFaceUp);
			if (mouse_check_button_released(mb_left)) {
				clipboard_set_text(filePath);
			}
		}
		draw_sprite_ext(spr_copyButton, 0, floor(mean(copyButtonX1, copyButtonX2)) - clipX, floor(mean(copyButtonY1, copyButtonY2)) - clipY, 1, 1, 0, global.colorThemeText, 1);
		
		// show file button
		var showFileButtonX2 = copyButtonX1 - (removeButtonWidth / 2);
		var showFileButtonY1 = removeButtonY1;
		var showFileButtonX1 = showFileButtonX2 - removeButtonWidth;
		var showFileButtonY2 = removeButtonY2;
		var mouseOverShowFilePath = point_in_rectangle(mouse_x, mouse_y, showFileButtonX1, showFileButtonY1, showFileButtonX2, showFileButtonY2) && mouseOverWindow;
		if (mouseOverShowFilePath) {
			draw_set_color(global.colorThemeSelected1);
			draw_roundrect(showFileButtonX1 - clipX, showFileButtonY1 - clipY, showFileButtonX2 - clipX, showFileButtonY2 - clipY, false);
			scr_createTooltip(floor(mean(showFileButtonX1, showFileButtonX2)), showFileButtonY2, os_type == os_windows ? scr_get_translation("menu_show-file-windows") : scr_get_translation("menu_show-file-macos"), obj_tooltip.arrowFaceUp);
			if (mouse_check_button_released(mb_left)) {
				var fileDir = string_replace_all(filePath, fileName, "");
				scr_openDirectory(fileDir);
			}
		}
		draw_sprite_ext(spr_openButton, 0, floor(mean(showFileButtonX1, showFileButtonX2)) - clipX, floor(mean(showFileButtonY1, showFileButtonY2)) - clipY, 1, 1, 0, global.colorThemeText, 1);
		
		
		// click on row to open up file
		if (mouse_check_button_released(mb_left) && (inputDelay == 0) && !mouseOverRemove && !mouseOverCopyFilePath && !mouseOverShowFilePath) {
			global.selectedFile = filePath;
			global.openProject = true
			global.userName = obj_openingScreen.inputText;
		}
		
	}
	
	
	
	draw_set_color(global.colorThemeText);
	draw_set_halign(fa_left);
	
	if (mouseOverRow) draw_sprite_ext(spr_xButton, 0, mean(removeButtonX1, removeButtonX2) - clipX, mean(removeButtonY1, removeButtonY2) - clipY, removeScale, removeScale, 0, global.colorThemeText, 1);
	
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
	draw_text(recentFilesWindowX1 + spaceWidth - clipX, floor(textY - clipY), scr_get_translation("menu_no-recent"));
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


// draw open directory button
var openDirTextKey = os_type == os_windows ? "menu_open-rez-folder-windows" : "menu_open-rez-folder-macos";
var openDirText = scr_get_translation(openDirTextKey)
var openDirButtonX1 = recentFilesWindowX1;
var openDirButtonY1 = recentFilesWindowY2 + string_height("A") * 0.5;
var openDirButtonX2 = openDirButtonX1 + string_width("  " + openDirText);
var openDirButtonY2 = openDirButtonY1 + string_height("A");
var mouseoverOpenDirButton = point_in_rectangle(mouse_x, mouse_y, openDirButtonX1, openDirButtonY1, openDirButtonX2, openDirButtonY2) && !mouseoverCancel;
draw_set_color(mouseoverOpenDirButton ? c_white : c_ltgray);
draw_roundrect(openDirButtonX1, openDirButtonY1, openDirButtonX2, openDirButtonY2, false);
draw_set_color(c_gray);
draw_roundrect(openDirButtonX1, openDirButtonY1, openDirButtonX2, openDirButtonY2, true);
draw_set_color(c_black);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(floor(mean(openDirButtonX1, openDirButtonX2)), floor(mean(openDirButtonY1, openDirButtonY2)), openDirText);
if (mouseoverOpenDirButton) {
	if (mouse_check_button_released(mb_left)) {
		if (directory_exists(global.rezonatorREZFileDir)) {
			show_debug_message("attempting to open folder: " + string(global.rezonatorREZFileDir));
			scr_openDirectory(global.rezonatorREZFileDir);
		}
		else {
			show_message("This directory does not exist");
		}
	}
}
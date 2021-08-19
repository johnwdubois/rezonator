/// @description Insert description here
// You can write your code in this editor

// cam vars
camWidth = camera_get_view_width(camera_get_active());
camHeight = camera_get_view_height(camera_get_active());
camMidX = camWidth / 2;
camMidY = camHeight / 2;

// box vars
boxHeight = max((!inputWindowActive) ? 270 : 400, camHeight / 4); 
boxWidth = max(640, camWidth / 3);
boxRectX1 = camMidX - boxWidth/2;
boxRectY1 = camMidY - boxHeight/2;
boxRectX2 = camMidX + boxWidth/2;
boxRectY2 = camMidY + boxHeight/2;
	
// draw box base
scr_dropShadow(boxRectX1, boxRectY1, boxRectX2, boxRectY2);
draw_set_alpha(1);
draw_set_color(global.colorThemeBG);
draw_roundrect(boxRectX1, boxRectY1, boxRectX2, boxRectY2, false);
draw_set_color(global.colorThemeBorders);
scr_drawRectWidth(boxRectX1, boxRectY1, boxRectX2, boxRectY2, 2, true);


	
scr_setDialogueText();

var titleTextX = floor(camMidX);
var titleTextY = floor(boxRectY1 + (boxHeight * ((!inputWindowActive) ? 0.2: 0.1)));
var descriptionTextY = floor(boxRectY1 + (boxHeight * ((!inputWindowActive) ? 0.35 : 0.22)));
draw_set_color(global.colorThemeText);
draw_set_alpha(1);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
scr_adaptFont(titleText, "L",false);
draw_text(titleTextX, titleTextY, titleText);
if(!inputWindowActive) {	
	scr_adaptFont(titleText, "M", );
	draw_text_ext(titleTextX, descriptionTextY, descriptionText, string_height(descriptionText), boxWidth * 0.8);
}
	
if(!promptWindowActive) {	
	// cancel button
	var buttonXBuffer = boxWidth * 0.05;
	var buttonYBuffer = boxHeight * 0.07;
	var buttonWidth = boxWidth * 0.3;
	var buttonHeight = boxHeight * 0.15;
	var buttonY2 = boxRectY2 - buttonYBuffer;
	var buttonY1 = buttonY2 - buttonHeight;
	var cancelRectX2 = camMidX - buttonXBuffer;
	var cancelRectX1 = cancelRectX2 - buttonWidth;
	mouseoverCancel = point_in_rectangle(mouse_x, mouse_y, cancelRectX1, buttonY1, cancelRectX2, buttonY2) && !instance_exists(obj_dropDown);
	draw_set_color(mouseoverCancel ? global.colorThemeSelected1 : global.colorThemeBG);
	draw_roundrect(cancelRectX1, buttonY1, cancelRectX2, buttonY2, false);
	draw_set_color(global.colorThemeRezPink);
	draw_roundrect(cancelRectX1, buttonY1, cancelRectX2, buttonY2, true);
	draw_set_color(global.colorThemeText);
	scr_adaptFont("Cancel", "M", false);
	draw_text(floor(mean(cancelRectX1, cancelRectX2)), floor(mean(buttonY1, buttonY2)), "Cancel");
}
// ok button
var buttonXBuffer = boxWidth * 0.1;
var buttonYBuffer = boxHeight * 0.07;
var buttonY2 = boxRectY2 - buttonYBuffer;
var buttonY1 = buttonY2 - buttonHeight;
var okRectX1 = camMidX + buttonXBuffer;
var okRectX2 = okRectX1 + buttonWidth;
mouseoverOk = point_in_rectangle(mouse_x, mouse_y, okRectX1, buttonY1, okRectX2, buttonY2) && !instance_exists(obj_dropDown);
draw_set_color(merge_color(global.colorThemeRezPink, global.colorThemeBG, mouseoverOk ? 0.2 : 0));
draw_roundrect(okRectX1, buttonY1, okRectX2, buttonY2, false);
draw_set_color(global.colorThemeBG);
draw_text(floor(mean(okRectX1, okRectX2)), floor(mean(buttonY1, buttonY2)), "OK");




if (inputWindowActive) {
	scr_drawDialogueBox_input();
}

else if(questionWindowActive) {
	scr_drawDialogueBox_question();
}

else if(promptWindowActive) {
	scr_drawDialogueBox_question();
}

//selection paths
var clickOk = mouseoverOk && mouse_check_button_released(mb_left);

// ok button check
if (clickOk || keyboard_check_pressed(vk_enter)) {
	scr_dialogueConfirm();
}
	
var clickCancel = mouseoverCancel && mouse_check_button_released(mb_left);

// cancel button check
if (clickCancel || keyboard_check_pressed(vk_escape)) {
	obj_control.alarm[11] = 60;
			
	scr_closeDialogueBoxVariables();
	instance_destroy();
}
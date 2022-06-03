// cam vars
camWidth = camera_get_view_width(camera_get_active());
camHeight = camera_get_view_height(camera_get_active());
camMidX = camWidth / 2;
camMidY = camHeight / 2;

// box vars
var boxHeightMax1 = inputWindowActive ? 400 : 270
var boxHeightMax2 = inputWindowActive ? (camHeight / 3) : (camHeight / 4);
boxHeight = max(boxHeightMax1, boxHeightMax2); 
boxWidth = max(640, camWidth / 3);
boxRectX1 = camMidX - boxWidth/2;
boxRectY1 = camMidY - boxHeight/2;
boxRectX2 = camMidX + boxWidth/2;
boxRectY2 = camMidY + boxHeight/2;
var mouseoverDialogueBox = point_in_rectangle(mouse_x, mouse_y, boxRectX1, boxRectY1, boxRectX2, boxRectY2);

if (blink || blinkAlpha > 0) {
	blinkAlpha += 0.1;
}
if (blinkAlpha > 1) {
	blinkAlpha = 0;
}
	
// draw box base
draw_set_alpha(0.1);
draw_set_color(global.colorThemeText);
draw_rectangle(0, 0, camWidth, camHeight, false);
scr_dropShadow(boxRectX1, boxRectY1, boxRectX2, boxRectY2);
draw_set_alpha(1);
draw_set_color(global.colorThemeBG);
draw_roundrect(boxRectX1, boxRectY1, boxRectX2, boxRectY2, false);
draw_set_color(merge_color(global.colorThemeBorders, c_white, blinkAlpha));
scr_drawRectWidth(boxRectX1, boxRectY1, boxRectX2, boxRectY2, 2, true);


	
// draw title text & description text
scr_setDialogueText();
var titleTextX = floor(camMidX);
var titleTextY = floor(boxRectY1 + (boxHeight * ((!inputWindowActive) ? 0.2: 0.1)));
var descriptionTextY = floor(boxRectY1 + (boxHeight * ((!inputWindowActive) ? 0.35 : 0.22)));
draw_set_color(global.colorThemeText);
draw_set_alpha(1);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
scr_adaptFont(titleText, "L",false);
draw_text(titleTextX, titleTextY, titleText);
var drawDesc = true;
if (instance_exists(obj_control)) {
	if (obj_control.fPressed) {
		drawDesc = false;
	}
}
if (drawDesc) {
	scr_adaptFont(descriptionText, "M");
	draw_text_ext(titleTextX, descriptionTextY, descriptionText, string_height("A"), boxWidth * 0.8);
}
draw_set_valign(fa_middle);

// determine button sizes
var buttonWidth = noButtonActive ? boxWidth * 0.25 : boxWidth * 0.3;
var buttonHeight = boxHeight * 0.15;
var buttonXBuffer = 0;
if (alertWindowActive) buttonXBuffer = -(buttonWidth / 2);
else if (noButtonActive) buttonXBuffer = boxWidth * 0.2
else buttonXBuffer = boxWidth * 0.07;
var buttonYBuffer = boxHeight * 0.07;
var buttonY2 = boxRectY2 - buttonYBuffer;
var buttonY1 = buttonY2 - buttonHeight;

if (!alertWindowActive) {
	// cancel button
	var cancelRectX2 = camMidX - buttonXBuffer;
	var cancelRectX1 = cancelRectX2 - buttonWidth;
	mouseoverCancel = point_in_rectangle(mouse_x, mouse_y, cancelRectX1, buttonY1, cancelRectX2, buttonY2) && !instance_exists(obj_dropDown);
	draw_set_color(mouseoverCancel ? global.colorThemeSelected1 : global.colorThemeBG);
	draw_roundrect(cancelRectX1, buttonY1, cancelRectX2, buttonY2, false);
	draw_set_color(merge_color(global.colorThemeRezPink, c_white, blinkAlpha / 2));
	draw_roundrect(cancelRectX1, buttonY1, cancelRectX2, buttonY2, true);
	draw_set_color(global.colorThemeText);
	var cancelText = (room == rm_openingScreen) ? "msg_continue" : "msg_cancel";
	cancelText = scr_get_translation(cancelText);
	scr_adaptFont(cancelText, "M", false);
	draw_text(floor(mean(cancelRectX1, cancelRectX2)), floor(mean(buttonY1, buttonY2)), cancelText);
}

// ok button
var okRectX1 = camMidX + buttonXBuffer;
var okRectX2 = okRectX1 + buttonWidth;
mouseoverOk = point_in_rectangle(mouse_x, mouse_y, okRectX1, buttonY1, okRectX2, buttonY2) && !instance_exists(obj_dropDown);

var notMouseoverColor = merge_color(global.colorThemeRezPink, merge_color(global.colorThemeSelected1, global.colorThemeRezPink, 50), blinkAlpha);

draw_set_color(mouseoverOk ? merge_color(global.colorThemeSelected1, global.colorThemeRezPink, 50) : notMouseoverColor);
draw_roundrect(okRectX1, buttonY1, okRectX2, buttonY2, false);
draw_set_color(global.colorThemeBG);
var okText = scr_get_translation("msg_okay");
if (instance_exists(obj_openingScreen)) {
	if (obj_openingScreen.downloadDialogue) {
		okText = "help_label_download";
	}
}
else if (noButtonActive) okText = "msg_yes";
okText = scr_get_translation(okText);
draw_text(floor(mean(okRectX1, okRectX2)), floor(mean(buttonY1, buttonY2)), okText);

if (noButtonActive) {
	var noRectX1 = camMidX - (buttonWidth * 0.5);
	var noRectX2 = noRectX1 + buttonWidth;
	mouseoverNo = point_in_rectangle(mouse_x, mouse_y, noRectX1, buttonY1, noRectX2, buttonY2) && !instance_exists(obj_dropDown);
	
	draw_set_color(mouseoverNo ? global.colorThemeSelected1 : global.colorThemeBG);
	draw_roundrect(noRectX1, buttonY1, noRectX2, buttonY2, false);
	draw_set_color(global.colorThemeRezPink);
	draw_roundrect(noRectX1, buttonY1, noRectX2, buttonY2, true);
	draw_set_color(global.colorThemeText);
	var noText = "msg_no";
	noText = scr_get_translation(noText);
	scr_adaptFont(noText, "M", false);
	draw_text(floor(mean(noRectX1, noRectX2)), floor(mean(buttonY1, buttonY2)), noText);
}



if (inputWindowActive) {
	scr_drawDialogueBox_input();
}



// selection paths
var clickOk = mouseoverOk && mouse_check_button_released(mb_left);
var clickNo = mouseoverNo && mouse_check_button_released(mb_left);
var clickCancel = mouseoverCancel && mouse_check_button_released(mb_left);


// ok button check
if (clickOk || keyboard_check_pressed(vk_enter)) {
	scr_dialogueConfirm();
}
else if (clickNo) {
	scr_dialogueNo();
}
else if (clickCancel || keyboard_check_pressed(vk_escape)) {
	// cancel button check
	show_debug_message("closing dialogue box...");
	with (obj_control) alarm[11] = 60;
			
	scr_closeDialogueBoxVariables();
	instance_destroy();
}

// if user clicks outside of dialogue box
if (!mouseoverDialogueBox && mouse_check_button_pressed(mb_left)) {
	blink = true;
	alarm[1] = 20;
}
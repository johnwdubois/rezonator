scr_colorThemeControl();
scr_ctrlHold();
scr_windowCameraAdjust();
scr_windowExit();

// draw rect to hide scrolled text
scr_adaptFont("A", "M");
var camWidth = camera_get_view_width(view_camera[0]);
var camHeight = camera_get_view_height(view_camera[0]);
draw_set_color(global.colorThemeSelected1);
draw_rectangle(0, instInputBox_Prompt.textBoxY - (string_height("A") * 0.5), camWidth, camHeight, false);

var textBoxWidth = camWidth * 0.65;
var textBoxHeight = instInputBox_Prompt.windowHeight;

// position API key input box
with (instInputBox_ApiKey) {
	windowWidth = textBoxWidth;
	textBoxX = (camWidth / 2) - (windowWidth / 2);
	textBoxY = camHeight - (textBoxHeight * 2);
}

// position AI prompt input box
var _instInputBox_ApiKey = instInputBox_ApiKey;
with (instInputBox_Prompt) {
	windowWidth = textBoxWidth;
	textBoxX = (camWidth / 2) - (windowWidth / 2);
	textBoxY = _instInputBox_ApiKey.textBoxY - (textBoxHeight * 2);
}

// back button
draw_set_alpha(1);
draw_set_color(c_black);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
scr_adaptFont("A", "M");
var backButtonWidth = instInputBox_ApiKey.textBoxX * 0.75;
var backButtonHeight = textBoxHeight * 2;
var backButtonX1 = (instInputBox_ApiKey.textBoxX / 2) - (backButtonWidth / 2);
var backButtonY2 = instInputBox_ApiKey.textBoxY;
var backButtonX2 = backButtonX1 + backButtonWidth;
var backButtonY1 = backButtonY2 - textBoxHeight;
var mouseoverBackButton = point_in_rectangle(mouse_x, mouse_y, backButtonX1, backButtonY1, backButtonX2, backButtonY2);
draw_set_color(mouseoverBackButton ? global.colorThemeSelected1 : global.colorThemeBG);
draw_roundrect(backButtonX1, backButtonY1, backButtonX2, backButtonY2, false);
draw_set_color(global.colorThemeRezPink);
draw_roundrect(backButtonX1, backButtonY1, backButtonX2, backButtonY2, true);
draw_set_color(global.colorThemeText);
draw_text(floor(mean(backButtonX1, backButtonX2)), floor(mean(backButtonY1, backButtonY2)), scr_get_translation("label_back"));
if (mouseoverBackButton) {
	if (mouse_check_button_released(mb_left)) {
		room_goto(rm_openingScreen);
	}
}

// import button
var importButtonX1 = mean((instInputBox_ApiKey.textBoxX + instInputBox_ApiKey.windowWidth), camWidth) - (backButtonWidth / 2);
var importButtonY1 = backButtonY1;
var importButtonX2 = importButtonX1 + backButtonWidth;
var importButtonY2 = backButtonY2;
var mouseoverImportButton = point_in_rectangle(mouse_x, mouse_y, importButtonX1, importButtonY1, importButtonX2, importButtonY2);
draw_set_color(mouseoverImportButton ? global.colorThemeSelected1 : global.colorThemeBG);
draw_roundrect(importButtonX1, importButtonY1, importButtonX2, importButtonY2, false);
draw_set_color(global.colorThemeRezPink);
draw_roundrect(importButtonX1, importButtonY1, importButtonX2, importButtonY2, true);
draw_set_color(global.colorThemeText);
draw_text(floor(mean(importButtonX1, importButtonX2)), floor(mean(importButtonY1, importButtonY2)), scr_get_translation("menu_import"));
if (mouseoverImportButton) {
	if (mouse_check_button_released(mb_left)) {
		scr_importAIChat();
	}
}
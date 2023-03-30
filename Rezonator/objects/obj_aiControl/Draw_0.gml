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

// awaiting response
if (showAwaitingResponse) {
	draw_set_alpha(0.65);
	draw_set_color(c_black);
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	var awaitingResponseSecs = (current_time - awaitingResponseTime) / 1000;
	draw_text(instInputBox_Prompt.textBoxX, mean(instInputBox_Prompt.textBoxY + instInputBox_Prompt.windowHeight, instInputBox_ApiKey.textBoxY), "Awaiting response... " + string(awaitingResponseSecs));
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

// check how many messages are selected
var aiMessages = 0;
var messagesSelected = 0;
var msgListSize = ds_list_size(global.aiChatMsgList);
for (var i = 0; i < msgListSize; i++) {
	var currentMessageMap = global.aiChatMsgList[| i];
	var currentMessageSelected = currentMessageMap[? "selected"];
	var currentMessageAuthor = currentMessageMap[? "author"];
	if (currentMessageSelected) messagesSelected++;
	if (currentMessageAuthor == "ChatGPT") aiMessages++;
}

// check if we can import
var canImportAi = ds_list_size(global.aiChatMsgList) >= 1;
if (aiImportType == "selected" && messagesSelected < 1) canImportAi = false;
if (aiMessages < 1) canImportAi = false;

// import button
var importButtonX1 = mean((instInputBox_ApiKey.textBoxX + instInputBox_ApiKey.windowWidth), camWidth) - (backButtonWidth / 2);
var importButtonY1 = instInputBox_Prompt.textBoxY;
var importButtonX2 = importButtonX1 + backButtonWidth;
var importButtonY2 = importButtonY1 + (backButtonY2 - backButtonY1);
var mouseoverImportButton = point_in_rectangle(mouse_x, mouse_y, importButtonX1, importButtonY1, importButtonX2, importButtonY2) && canImportAi;
if (canImportAi) draw_set_color(mouseoverImportButton ? global.colorThemeSelected1 : global.colorThemeBG);
else draw_set_color(global.colorThemeSelected2);
draw_roundrect(importButtonX1, importButtonY1, importButtonX2, importButtonY2, false);
draw_set_color(canImportAi ? global.colorThemeRezPink : global.colorThemeSelected2);
draw_roundrect(importButtonX1, importButtonY1, importButtonX2, importButtonY2, true);
draw_set_color(global.colorThemeText);
draw_text(floor(mean(importButtonX1, importButtonX2)), floor(mean(importButtonY1, importButtonY2)), scr_get_translation("menu_import"));
if (mouseoverImportButton) {
	if (mouse_check_button_released(mb_left)) {
		global.importFrom = "ai";
		scr_importTXT("");
	}
}

// import radio buttons
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_set_color(global.colorThemeText);
var aiImportTypeRad = string_height("0") * 0.5;
var aiImportTypeX = importButtonX1 + aiImportTypeRad;
var plusY = aiImportTypeRad * 0.5;
var aiImportTypeListSize = ds_list_size(aiImportTypeList);
for (var i = 0; i < aiImportTypeListSize; i++) {
	
	var _aiImportType = aiImportTypeList[| i];
	var mouseoverAiImportType = point_in_circle(mouse_x, mouse_y, aiImportTypeX, importButtonY2 + aiImportTypeRad + plusY, aiImportTypeRad);
	if (mouseoverAiImportType) {
		if (mouse_check_button_released(mb_left)) aiImportType = _aiImportType;
	}
	
	draw_circle(aiImportTypeX, importButtonY2 + aiImportTypeRad + plusY, aiImportTypeRad, true);
	if (aiImportType == _aiImportType) draw_circle(aiImportTypeX, importButtonY2 + aiImportTypeRad + plusY, aiImportTypeRad * 0.8, false);
	draw_text(aiImportTypeX + (aiImportTypeRad * 2), importButtonY2 + aiImportTypeRad + plusY, _aiImportType);
	
	plusY += aiImportTypeRad * 2.5;
}
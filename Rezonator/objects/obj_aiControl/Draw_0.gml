scr_colorThemeControl();
scr_ctrlHold();
scr_windowCameraAdjust();
scr_windowExit();

var mouseoverCancel = instance_exists(obj_dropDown) || instance_exists(obj_dialogueBox);

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

// prompt send button
var promptSendWidth = instInputBox_Prompt.windowHeight;
var promptSendX2 = instInputBox_ApiKey.textBoxX + instInputBox_ApiKey.windowWidth;
var promptSendY1 = instInputBox_Prompt.textBoxY;
var promptSendX1 = promptSendX2 - promptSendWidth;
var promptSendY2 = promptSendY1 + promptSendWidth;
var promptSendPadding = 3;
var promptSendHolding = false;
var mouseoverPromptSend = point_in_rectangle(mouse_x, mouse_y, promptSendX1, promptSendY1, promptSendX2, promptSendY2) && !mouseoverCancel;
if (mouseoverPromptSend) {
	scr_createTooltip(floor(mean(promptSendX1, promptSendX2)), promptSendY2, scr_get_translation("option_submit-prompt"), TOOLTIP_DIR_UP);
	if (mouse_check_button_pressed(mb_left)) {
		mousePressedButton = "send";
	}
	if (mouse_check_button(mb_left) && mousePressedButton == "send") promptSendHolding = true;
	if (mouse_check_button_released(mb_left) && mousePressedButton == "send") {
		if (is_string(instInputBox_Prompt.str) && instInputBox_Prompt.str != "") {
			sendPrompt = true;
		}
	}
}
if (keyboard_check(vk_enter) && is_string(instInputBox_Prompt.str) && instInputBox_Prompt.str != "") promptSendHolding = true;
draw_set_alpha(mouseoverPromptSend || promptSendHolding ? 1 : 0.5);
draw_set_color(global.colorThemeBG);
draw_roundrect(promptSendX1 + (promptSendPadding * 2), promptSendY1 + promptSendPadding, promptSendX2, promptSendY2 - promptSendPadding, false);
draw_set_alpha(1);
if (promptSendHolding) {
	draw_set_color(global.colorThemeText);
	draw_roundrect(promptSendX1 + (promptSendPadding * 2), promptSendY1 + promptSendPadding, promptSendX2, promptSendY2 - promptSendPadding, true);
}
draw_sprite_ext(spr_send, 0, floor(mean(promptSendX1, promptSendX2)), floor(mean(promptSendY1, promptSendY2)), 1, 1, 0, global.colorThemeSelected2, 1);



// position AI prompt input box
var _instInputBox_ApiKey = instInputBox_ApiKey;
with (instInputBox_Prompt) {
	windowWidth = textBoxWidth - promptSendWidth;
	textBoxX = _instInputBox_ApiKey.textBoxX;
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

// show api key
draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
var checkboxHeight = string_height("A") * 0.75;
var checkboxX1 = instInputBox_ApiKey.textBoxX;
var checkboxY1 = floor(mean(instInputBox_ApiKey.textBoxY + instInputBox_ApiKey.windowHeight, camHeight) - (checkboxHeight / 2));
var checkboxX2 = checkboxX1 + checkboxHeight;
var checkboxY2 = checkboxY1 + checkboxHeight;
var mouseoverCheckbox = point_in_rectangle(mouse_x, mouse_y, checkboxX1, checkboxY1, checkboxX2, checkboxY2) && !mouseoverCancel;
if (showApiKey) {
	draw_set_color(c_white);
	draw_rectangle(checkboxX1, checkboxY1, checkboxX2, checkboxY2, false);
	draw_sprite_ext(spr_checkmark, 0, floor(mean(checkboxX1, checkboxX2)), floor(mean(checkboxY1, checkboxY2)), 1, 1, 0, c_black, 1);
}
draw_set_color(c_black);
scr_drawRectWidth(checkboxX1, checkboxY1, checkboxX2, checkboxY2, 2, false);
draw_text(floor(checkboxX2 + string_width("  ")), floor(mean(checkboxY1, checkboxY2)), "Show API key");
if (mouseoverCheckbox) {
	if (mouse_check_button_released(mb_left)) {
		showApiKey = !showApiKey;
	}
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
var mouseoverBackButton = point_in_rectangle(mouse_x, mouse_y, backButtonX1, backButtonY1, backButtonX2, backButtonY2) && !mouseoverCancel;
draw_set_color(mouseoverBackButton ? global.colorThemeSelected1 : global.colorThemeBG);
draw_roundrect(backButtonX1, backButtonY1, backButtonX2, backButtonY2, false);
draw_set_color(global.colorThemeRezPink);
draw_roundrect(backButtonX1, backButtonY1, backButtonX2, backButtonY2, true);
draw_set_color(global.colorThemeText);
draw_text(floor(mean(backButtonX1, backButtonX2)), floor(mean(backButtonY1, backButtonY2)), scr_get_translation("label_back"));
if (mouseoverBackButton) {
	if (mouse_check_button_pressed(mb_left)) {
		mousePressedButton = "back";
	}
	if (mouse_check_button_released(mb_left) && mousePressedButton == "back") {
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
	if (mouse_check_button_pressed(mb_left)) {
		mousePressedButton = "import";
	}
	if (mouse_check_button_released(mb_left) && mousePressedButton == "import") {
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

if (!mouse_check_button(mb_left)) {
	mousePressedButton = "";
}
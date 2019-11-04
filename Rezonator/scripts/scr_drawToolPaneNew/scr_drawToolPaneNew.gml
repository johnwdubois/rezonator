if (not obj_panelPane.showNav) {
	y = -(windowHeight * 2);
	exit;
}
y = obj_menuBar.menuHeight;

var toolSprScale = 1;//clamp(windowHeight / 210, 0.5, 1);
var toolButtonBuffer = 10;

for (var i = 0; i < 3; i++) {
	
	var toolButtonX = x + ((i + 1) * (global.toolPaneWidth / 4));
	if (i == 0) {
		toolButtonX -= 15;
	}
	else if (i == 2) {
		toolButtonX += 15;
	}
	var toolButtonY = y + (windowHeight / 2);
	//y + toolButtonBuffer + ((sprite_get_height(spr_toolsNew) * toolSprScale) * 0.5);
	
	/*
	if (i == 0) {
		var toolButtonY = y + toolButtonBuffer + ((sprite_get_height(spr_toolsNew) * toolSprScale) * 0.5);
	}
	else {
		var toolButtonY = y + (toolButtonBuffer * 2) + ((sprite_get_height(spr_toolsNew) * toolSprScale) * 1.5);
	}
	*/
	
	var mouseover = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, toolButtonX - (sprite_get_width(spr_toolsNew) / 2), toolButtonY - (sprite_get_height(spr_toolsNew) / 2), toolButtonX + (sprite_get_width(spr_toolsNew) / 2), toolButtonY + (sprite_get_height(spr_toolsNew) / 2));
	if (mouseover) {
		if (mouse_check_button_released(mb_left)) {
			if (i == 0) {
				currentMode = modeRead;
			}
			else if (i == 1) {
				currentMode = modeTrack;
			}
			else if (i == 2) {
				currentMode = modeRez;
			}
		}
	}
	
	var toolImageIndex = 0;
	if (i == 0) {
		toolImageIndex = (currentMode == modeRead) ? 2 : 0;
		if (currentMode != modeRead and mouseover) {
			toolImageIndex = 1;
		}
	}
	else if (i == 1) {
		toolImageIndex = (currentMode == modeTrack) ? 8 : 6;
		if (currentMode != modeTrack and mouseover) {
			toolImageIndex = 7;
		}
	}
	else {
		toolImageIndex = (currentMode == modeRez) ? 5 : 3;
		if (currentMode != modeRez and mouseover) {
			toolImageIndex = 4;
		}
	}
	
	draw_sprite_ext(spr_toolsNew, toolImageIndex, toolButtonX, toolButtonY, toolSprScale, toolSprScale, 0, c_white, 1);
}

// Prevent typing in text from changing the tool mode
if (!obj_control.gridView and !obj_control.dialogueBoxActive) {
	if (keyboard_check_pressed(ord("R"))) {
		currentMode = modeRez;
	}
	if (keyboard_check_pressed(ord("T"))) {
		currentMode = modeTrack;
	}
}

if (global.wheresElmo) {
	currentMode = modeTrack;
}
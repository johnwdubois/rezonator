// Adjust the font size

if(os_type == os_macosx){
		// Adjust the font size
	if (keyboard_check(vk_control) and keyboard_check_pressed(vk_subtract)
	or (keyboard_check(vk_control) and keyboard_check_direct(109)) and canPressPlus) {
		if (keyboard_check(vk_shift)) {
			if (global.fontSize > 0) {
				global.fontSize--;
				scr_setSpeakerLabelColWidth();
			}
			global.navTextBig = false;
		}
		else {
			if (!gridView) {
				gridSpaceHorizontal -= 20;
			}
		}
		canPressPlus = false;
		alarm[3] = 15;
	}
	if (keyboard_check(vk_control) and keyboard_check_pressed(vk_add)
	or (keyboard_check(vk_control) and keyboard_check(24)) and canPressMinus) {
		if (keyboard_check(vk_shift)) {
			if (global.fontSize < 5) {
				global.fontSize++;
				scr_setSpeakerLabelColWidth();
			}
			global.navTextBig = true;
		}
		else {
			if (!gridView) {
				gridSpaceHorizontal += 20;
			}
		}
		canPressMinus = false;
		alarm[4] = 15;
	}
	if (keyboard_check(vk_control) and keyboard_check_pressed(vk_numpad0)
	or keyboard_check(vk_control) and keyboard_check_pressed(ord("0"))) {
		if (!gridView) {
			gridSpaceHorizontal = 100;
		}
	}
	
}
else{
	if (keyboard_check(vk_control) and keyboard_check_pressed(vk_subtract)
	or (keyboard_check(vk_control) and keyboard_check(189)) and canPressPlus) {
		if (keyboard_check(vk_shift)) {
			if (global.fontSize > 0) {
				global.fontSize--;
				scr_setSpeakerLabelColWidth();
			}
			global.navTextBig = false;
		}
		else {
			if (!gridView) {
				gridSpaceHorizontal -= 20;
			}
		}
		canPressPlus = false;
		alarm[3] = 15;
	}
	else if (keyboard_check(vk_control) and keyboard_check_pressed(vk_add)
	or (keyboard_check(vk_control) and keyboard_check_direct(187)) and canPressMinus) {
		if (keyboard_check(vk_shift)) {
			if (global.fontSize < 5) {
				global.fontSize++;
				scr_setSpeakerLabelColWidth();
			}
			global.navTextBig = true;
		}
		else {
			if (!gridView) {
				gridSpaceHorizontal += 20;
			}
		}
		canPressMinus = false;
		alarm[4] = 15;
	}
	else if (keyboard_check(vk_control) and keyboard_check_pressed(vk_numpad0)
	or keyboard_check(vk_control) and keyboard_check_pressed(ord("0"))) {
		if (!gridView) {
			gridSpaceHorizontal = 100;
		}
	}
	
}

scr_fontGlobalUpdate();

if(global.navTextBig){
//		global.fontChainContents = fnt_chainContentsLarge1;	
//		global.fontPanelTab = fnt_panelTabLarge1;
//		global.fontSortPane = fnt_sortPaneLarge1;
}
else{
//		global.fontChainContents = fnt_chainContents;
//		global.fontPanelTab = fnt_panelTab;
//		global.fontSortPane = fnt_sortPane;
}
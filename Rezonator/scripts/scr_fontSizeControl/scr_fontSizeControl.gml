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

// Set and adjust the font size
global.fontSize = clamp(global.fontSize, 0, 5);

switch (global.fontSize) {
	case 0:
		global.fontMain = fnt_main;
		global.fontMainBold = fnt_mainBold;
//		global.fontChainContents = fnt_chainContents;
		global.fontChainList = fnt_chainList;
		global.fontChainListFocused = fnt_chainListFocused;
//		global.fontPanelTab = fnt_panelTab;
//		global.fontSortPane = fnt_sortPane;
		global.fontGridView = fnt_gridView;
		//global.fontGridView = fnt_gridViewLarge2;
		break;
	case 1:
		global.fontMain = fnt_mainLarge1;
		global.fontMainBold = fnt_mainBoldLarge1;
//		global.fontChainContents = fnt_chainContentsLarge1;
		global.fontChainList = fnt_chainListLarge1;
		global.fontChainListFocused = fnt_chainListFocusedLarge1;
//		global.fontPanelTab = fnt_panelTabLarge1;
//		global.fontSortPane = fnt_sortPaneLarge1;
		global.fontGridView = fnt_gridViewLarge1;
		//global.fontGridView = fnt_gridViewLarge2;
		break;
	case 2:
		global.fontMain = fnt_mainLarge2;
		global.fontMainBold = fnt_mainBoldLarge2;
//		global.fontChainContents = fnt_chainContentsLarge2;
		global.fontChainList = fnt_chainListLarge2;
		global.fontChainListFocused = fnt_chainListFocusedLarge2;
//		global.fontPanelTab = fnt_panelTabLarge1;
//		global.fontSortPane = fnt_sortPaneLarge1;
		global.fontGridView = fnt_gridViewLarge2;
		break;
	case 3:
		global.fontMain = fnt_mainLarge3;
		global.fontMainBold = fnt_mainBoldLarge3;
//		global.fontChainContents = fnt_chainContentsLarge3;
		global.fontChainList = fnt_chainListLarge3;
		global.fontChainListFocused = fnt_chainListFocusedLarge3;
//		global.fontPanelTab = fnt_panelTabLarge1;
//		global.fontSortPane = fnt_sortPaneLarge1;
		global.fontGridView = fnt_gridViewLarge3;
		break;
	case 4:
		global.fontMain = fnt_mainLarge4;
		global.fontMainBold = fnt_mainBoldLarge4;
//		global.fontChainContents = fnt_chainContentsLarge4;
		global.fontChainList = fnt_chainListLarge4;
		global.fontChainListFocused = fnt_chainListFocusedLarge4;
//		global.fontPanelTab = fnt_panelTabLarge1;
//		global.fontSortPane = fnt_sortPaneLarge1;
		global.fontGridView = fnt_gridViewLarge4;
		break;
	case 5:
		global.fontMain = fnt_mainLarge5;
		global.fontMainBold = fnt_mainBoldLarge5;
//		global.fontChainContents = fnt_chainContentsLarge5;
		global.fontChainList = fnt_chainListLarge5;
		global.fontChainListFocused = fnt_chainListFocusedLarge5;
//		global.fontPanelTab = fnt_panelTabLarge1;
//		global.fontSortPane = fnt_sortPaneLarge1;
		global.fontGridView = fnt_gridViewLarge5;
		break;
	default:
		global.fontMain = fnt_main;
		global.fontMainBold = fnt_mainBold;
		global.fontChainContents = fnt_chainContents;
		global.fontChainList = fnt_chainList;
		global.fontChainListFocused = fnt_chainListFocused;
		global.fontPanelTab = fnt_panelTab;
		global.fontSortPane = fnt_sortPane;
		global.fontGridView = fnt_gridView;
		break;
}
if(global.navTextBig){
		global.fontChainContents = fnt_chainContentsLarge1;	
		global.fontPanelTab = fnt_panelTabLarge1;
		global.fontSortPane = fnt_sortPaneLarge1;
}
else{
		global.fontChainContents = fnt_chainContents;
		global.fontPanelTab = fnt_panelTab;
		global.fontSortPane = fnt_sortPane;
}
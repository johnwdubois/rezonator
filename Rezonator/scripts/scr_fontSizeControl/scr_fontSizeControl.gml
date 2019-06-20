// Adjust the font size
if (keyboard_check(vk_control) and keyboard_check_pressed(vk_subtract)
or (keyboard_check(vk_control) and keyboard_check_direct(189)) and canPressPlus) {
	if (keyboard_check(vk_shift)) {
		if (global.fontSize > 0) {
			global.fontSize--;
			scr_setSpeakerLabelColWidth();
		}
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
	
	

// Set and adjust the font size
global.fontSize = clamp(global.fontSize, 0, 5);

switch (global.fontSize) {
	case 0:
		global.fontMain = fnt_main;
		global.fontMainBold = fnt_mainBold;
		global.fontChainContents = fnt_chainContents;
		global.fontChainList = fnt_chainList;
		global.fontPanelTab = fnt_panelTab;
		global.fontSortPane = fnt_sortPane;
		global.fontGridView = fnt_gridView;
		break;
	case 1:
		global.fontMain = fnt_mainLarge1;
		global.fontMainBold = fnt_mainBoldLarge1;
		global.fontChainContents = fnt_chainContentsLarge1;
		global.fontChainList = fnt_chainListLarge1;
		global.fontPanelTab = fnt_panelTabLarge1;
		global.fontSortPane = fnt_sortPaneLarge1;
		global.fontGridView = fnt_gridViewLarge1;
		break;
	case 2:
		global.fontMain = fnt_mainLarge2;
		global.fontMainBold = fnt_mainBoldLarge2;
		global.fontChainContents = fnt_chainContentsLarge2;
		global.fontChainList = fnt_chainListLarge2;
		global.fontPanelTab = fnt_panelTabLarge2;
		global.fontSortPane = fnt_sortPaneLarge2;
		global.fontGridView = fnt_gridViewLarge2;
		break;
	case 3:
		global.fontMain = fnt_mainLarge3;
		global.fontMainBold = fnt_mainBoldLarge3;
		global.fontChainContents = fnt_chainContentsLarge3;
		global.fontChainList = fnt_chainListLarge3;
		global.fontPanelTab = fnt_panelTabLarge3;
		global.fontSortPane = fnt_sortPaneLarge3;
		global.fontGridView = fnt_gridViewLarge3;
		break;
	case 4:
		global.fontMain = fnt_mainLarge4;
		global.fontMainBold = fnt_mainBoldLarge4;
		global.fontChainContents = fnt_chainContentsLarge4;
		global.fontChainList = fnt_chainListLarge4;
		global.fontPanelTab = fnt_panelTabLarge4;
		global.fontSortPane = fnt_sortPaneLarge4;
		global.fontGridView = fnt_gridViewLarge4;
		break;
	case 5:
		global.fontMain = fnt_mainLarge5;
		global.fontMainBold = fnt_mainBoldLarge5;
		global.fontChainContents = fnt_chainContentsLarge5;
		global.fontChainList = fnt_chainListLarge5;
		global.fontPanelTab = fnt_panelTabLarge5;
		global.fontSortPane = fnt_sortPaneLarge5;
		break;
	default:
		global.fontMain = fnt_main;
		global.fontMainBold = fnt_mainBold;
		global.fontChainContents = fnt_chainContents;
		global.fontChainList = fnt_chainList;
		global.fontPanelTab = fnt_panelTab;
		global.fontSortPane = fnt_sortPane;
		global.fontGridView = fnt_gridView;
		break;
}
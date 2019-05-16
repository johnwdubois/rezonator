// Set and adjust the font size
global.fontSize = clamp(global.fontSize, 0, 5);

switch (global.fontSize) {
	case 0:
		global.fontMain = fnt_main;
		global.fontChainContents = fnt_chainContents;
		global.fontChainList = fnt_chainList;
		global.fontPanelTab = fnt_panelTab;
		global.fontSortPane = fnt_sortPane;
		break;
	case 1:
		global.fontMain = fnt_mainLarge1;
		global.fontChainContents = fnt_chainContentsLarge1;
		global.fontChainList = fnt_chainListLarge1;
		global.fontPanelTab = fnt_panelTabLarge1;
		global.fontSortPane = fnt_sortPaneLarge1;
		break;
	case 2:
		global.fontMain = fnt_mainLarge2;
		global.fontChainContents = fnt_chainContentsLarge2;
		global.fontChainList = fnt_chainListLarge2;
		global.fontPanelTab = fnt_panelTabLarge2;
		global.fontSortPane = fnt_sortPaneLarge2;
		break;
	case 3:
		global.fontMain = fnt_mainLarge3;
		global.fontChainContents = fnt_chainContentsLarge3;
		global.fontChainList = fnt_chainListLarge3;
		global.fontPanelTab = fnt_panelTabLarge3;
		global.fontSortPane = fnt_sortPaneLarge3;
		break;
	case 4:
		global.fontMain = fnt_mainLarge4;
		global.fontChainContents = fnt_chainContentsLarge4;
		global.fontChainList = fnt_chainListLarge4;
		global.fontPanelTab = fnt_panelTabLarge4;
		global.fontSortPane = fnt_sortPaneLarge4;
		break;
	case 5:
		global.fontMain = fnt_mainLarge5;
		global.fontChainContents = fnt_chainContentsLarge5;
		global.fontChainList = fnt_chainListLarge5;
		global.fontPanelTab = fnt_panelTabLarge5;
		global.fontSortPane = fnt_sortPaneLarge5;
		break;
	default:
		global.fontMain = fnt_main;
		global.fontChainContents = fnt_chainContents;
		global.fontChainList = fnt_chainList;
		global.fontPanelTab = fnt_panelTab;
		global.fontSortPane = fnt_sortPane;
		break;
}
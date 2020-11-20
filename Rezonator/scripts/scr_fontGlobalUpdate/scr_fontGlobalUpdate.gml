function scr_fontGlobalUpdate() {
	// Set and adjust the font size
	global.fontSize = clamp(global.fontSize, 0, 5);

	switch (global.fontSize) {
		case 0:
			global.fontMain = fnt_main;
			global.fontMainBold = fnt_main;
			global.fontChainContents = fnt_chainContents;
			global.fontChainList = fnt_main;
			global.fontChainListFocused = fnt_main;
			global.fontPanelTab = fnt_panelTab;
	//		global.fontSortPane = fnt_sortPane;
			global.fontGridView = fnt_gridView;
			//global.fontGridView = fnt_gridViewLarge2;
			break;
		case 1:
			global.fontMain = fnt_mainLarge1;
			global.fontMainBold = fnt_mainLarge1;
			global.fontChainContents = fnt_chainContentsLarge1;
			global.fontChainList = fnt_mainLarge1;
			global.fontChainListFocused = fnt_mainLarge1;
			global.fontPanelTab = fnt_panelTabLarge1;
	//		global.fontSortPane = fnt_sortPaneLarge1;
			global.fontGridView = fnt_gridViewLarge1;
			//global.fontGridView = fnt_gridViewLarge2;
			break;
		case 2:
			global.fontMain = fnt_mainLarge2;
			global.fontMainBold = fnt_mainLarge2;
			global.fontChainContents = fnt_chainContentsLarge2;
			global.fontChainList = fnt_mainLarge2;
			global.fontChainListFocused = fnt_mainLarge2;
			global.fontPanelTab = fnt_panelTabLarge2;
	//		global.fontSortPane = fnt_sortPaneLarge1;
			global.fontGridView = fnt_gridViewLarge2;
			break;
		case 3:
			global.fontMain = fnt_mainLarge3;
			global.fontMainBold = fnt_mainLarge3;
			global.fontChainContents = fnt_chainContentsLarge3;
			global.fontChainList = fnt_mainLarge3;
			global.fontChainListFocused = fnt_mainLarge3;
			global.fontPanelTab = fnt_panelTabLarge3;
	//		global.fontSortPane = fnt_sortPaneLarge1;
			global.fontGridView = fnt_gridViewLarge3;
			break;
		case 4:
			global.fontMain = fnt_mainLarge4;
			global.fontMainBold = fnt_mainLarge4;
			global.fontChainContents = fnt_chainContentsLarge4;
			global.fontChainList = fnt_mainLarge4;
			global.fontChainListFocused = fnt_mainLarge4;
			global.fontPanelTab = fnt_panelTabLarge4;
	//		global.fontSortPane = fnt_sortPaneLarge1;
			global.fontGridView = fnt_gridViewLarge4;
			break;
		case 5:
			global.fontMain = fnt_mainLarge5;
			global.fontMainBold = fnt_mainLarge5;
			global.fontChainContents = fnt_chainContentsLarge5;
			global.fontChainList = fnt_mainLarge5;
			global.fontChainListFocused = fnt_mainLarge5;
			global.fontPanelTab = fnt_panelTabLarge5;
	//		global.fontSortPane = fnt_sortPaneLarge1;
			global.fontGridView = fnt_gridViewLarge5;
			break;
		default:
			global.fontMain = fnt_main;
			global.fontMainBold = fnt_main;
			global.fontChainContents = fnt_chainContents;
			global.fontChainList = fnt_main;
			global.fontChainListFocused = fnt_main;
			global.fontPanelTab = fnt_panelTab;
			global.fontSortPane = fnt_sortPane;
			global.fontGridView = fnt_gridView;
			break;
	}
	
	if (global.lang_codes[| global.lang_index] == "zh" ) {
			global.fontMain = fnt_localeZH;
			global.fontMainBold = fnt_localeZH;
			global.fontChainContents = fnt_localeZH;
			global.fontChainList = fnt_localeZH;
			global.fontChainListFocused = fnt_localeZH;
			global.fontPanelTab = fnt_localeZH;
			global.fontSortPane = fnt_localeZH;
			global.fontGridView = fnt_localeZH;
	}
	
	if (global.lang_codes[| global.lang_index] == "ja" ) {
			global.fontMain = fnt_localeJA;
			global.fontMainBold = fnt_localeJA;
			global.fontChainContents = fnt_localeJA;
			global.fontChainList = fnt_localeJA;
			global.fontChainListFocused = fnt_localeJA;
			global.fontPanelTab = fnt_localeJA;
			global.fontSortPane = fnt_localeJA;
			global.fontGridView = fnt_localeJA;
	}
	
	if (global.lang_codes[| global.lang_index] == "he" ) {
			global.fontMain = fnt_localeHE;
			global.fontMainBold = fnt_localeHE;
			global.fontChainContents = fnt_localeHE;
			global.fontChainList = fnt_localeHE;
			global.fontChainListFocused = fnt_localeHE;
			global.fontPanelTab = fnt_localeHE;
			global.fontSortPane = fnt_localeHE;
			global.fontGridView = fnt_localeHE;
	}


}

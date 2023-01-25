function scr_fontGlobalUpdate() {
	// Set and adjust the font size
	global.fontSize = clamp(global.fontSize, 0, 5);

	switch (global.fontSize) {
		case 0:
			if (global.lang_codes[| global.lang_index] == "zh" or global.lang_codes[| global.lang_index] == "ja" ) {
				global.fontMain = global.localeCJK_M_0;
				global.fontMainBold = global.localeCJK_M_0;
				global.fontChainContents = global.localeCJK_S_0;
				global.fontChainList = global.localeCJK_M_0;
				global.fontChainListFocused = global.localeCJK_S_0;
				global.fontPanelTab = global.localeCJK_S_0;
				global.fontGridView = global.localeCJK_S_0;
			}
			else {
				global.fontMain = global.localeEN_M_0;
				global.fontMainBold = global.localeEN_M_0;
				global.fontChainContents = global.localeEN_S_0;
				global.fontChainList = global.localeEN_M_0;
				global.fontChainListFocused = global.localeEN_S_0;
				global.fontPanelTab = global.localeEN_S_0;
				global.fontGridView = global.localeEN_S_0;
			}
			break;
		case 1:
			if (global.lang_codes[| global.lang_index] == "zh" or global.lang_codes[| global.lang_index] == "ja" ) {
				global.fontMain = global.localeCJK_M_1;
				global.fontMainBold = global.localeCJK_M_1;
				global.fontChainContents = global.localeCJK_S_1;
				global.fontChainList = global.localeCJK_M_1;
				global.fontChainListFocused = global.localeCJK_S_1;
				global.fontPanelTab = global.localeCJK_S_1;
				global.fontGridView = global.localeCJK_S_1;
			}
			else {
				global.fontMain = global.localeEN_M_1;
				global.fontMainBold = global.localeEN_M_1;
				global.fontChainContents = global.localeEN_S_1;
				global.fontChainList = global.localeEN_M_1;
				global.fontChainListFocused = global.localeEN_S_1;
				global.fontPanelTab = global.localeEN_S_1;
				global.fontGridView = global.localeEN_S_1;
			}
			break;
		case 2:
			if (global.lang_codes[| global.lang_index] == "zh" or global.lang_codes[| global.lang_index] == "ja" ) {
				global.fontMain = global.localeCJK_M_2;
				global.fontMainBold = global.localeCJK_M_2;
				global.fontChainContents = global.localeCJK_S_2;
				global.fontChainList = global.localeCJK_M_2;
				global.fontChainListFocused = global.localeCJK_S_2;
				global.fontPanelTab = global.localeCJK_S_2;
				global.fontGridView = global.localeCJK_S_2;
			}
			else {
				global.fontMain = global.localeEN_M_2;
				global.fontMainBold = global.localeEN_M_2;
				global.fontChainContents = global.localeEN_S_2;
				global.fontChainList = global.localeEN_M_0;
				global.fontChainListFocused = global.localeEN_S_2;
				global.fontPanelTab = global.localeEN_S_2;
				global.fontGridView = global.localeEN_S_2;
			}
			break;
		case 3:
			if (global.lang_codes[| global.lang_index] == "zh" or global.lang_codes[| global.lang_index] == "ja" ) {
				global.fontMain = global.localeCJK_M_3;
				global.fontMainBold = global.localeCJK_M_3;
				global.fontChainContents = global.localeCJK_S_3;
				global.fontChainList = global.localeCJK_M_3;
				global.fontChainListFocused = global.localeCJK_S_3;
				global.fontPanelTab = global.localeCJK_S_3;
				global.fontGridView = global.localeCJK_S_3;
			}
			else {
				global.fontMain = global.localeEN_M_3;
				global.fontMainBold = global.localeEN_M_3;
				global.fontChainContents = global.localeEN_S_3;
				global.fontChainList = global.localeEN_M_3;
				global.fontChainListFocused = global.localeEN_S_3;
				global.fontPanelTab = global.localeEN_S_3;
				global.fontGridView = global.localeEN_S_3;
			}
			break;
		case 4:
			if (global.lang_codes[| global.lang_index] == "zh" or global.lang_codes[| global.lang_index] == "ja" ) {
				global.fontMain = global.localeCJK_M_4;
				global.fontMainBold = global.localeCJK_M_4;
				global.fontChainContents = global.localeCJK_S_4;
				global.fontChainList = global.localeCJK_M_4;
				global.fontChainListFocused = global.localeCJK_S_4;
				global.fontPanelTab = global.localeCJK_S_4;
				global.fontGridView = global.localeCJK_S_4;
			}
			else {
				global.fontMain = global.localeEN_M_4;
				global.fontMainBold = global.localeEN_M_4;
				global.fontChainContents = global.localeEN_S_4;
				global.fontChainList = global.localeEN_M_4;
				global.fontChainListFocused = global.localeEN_S_4;
				global.fontPanelTab = global.localeEN_S_4;
				global.fontGridView = global.localeEN_S_4;
			}
			break;
		case 5:
			if (global.lang_codes[| global.lang_index] == "zh" or global.lang_codes[| global.lang_index] == "ja" ) {
				global.fontMain = global.localeCJK_M_5;
				global.fontMainBold = global.localeCJK_M_5;
				global.fontChainContents = global.localeCJK_S_5;
				global.fontChainList = global.localeCJK_M_5;
				global.fontChainListFocused = global.localeCJK_S_5;
				global.fontPanelTab = global.localeCJK_S_5;
				global.fontGridView = global.localeCJK_S_5;
			}
			else {
				global.fontMain = global.localeEN_M_5;
				global.fontMainBold = global.localeEN_M_5;
				global.fontChainContents = global.localeEN_S_5;
				global.fontChainList = global.localeEN_M_5;
				global.fontChainListFocused = global.localeEN_S_5;
				global.fontPanelTab = global.localeEN_S_5;
				global.fontGridView = global.localeEN_S_5;
			}
			break;
		default:
		
			global.fontMain = global.localeEN_M_0;
			global.fontMainBold = global.localeEN_M_0;
			global.fontChainContents = global.localeEN_S_0;
			global.fontChainList = global.localeEN_M_0;
			global.fontChainListFocused = global.localeEN_S_0;
			global.fontPanelTab = global.localeEN_S_0;
			global.fontGridView = global.localeEN_S_0;
			global.fontSortPane = global.localeEN_S_0;
			
			break;
	}
	

	



}

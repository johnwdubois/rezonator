

function scr_fillHelpMenuGrid(){

	// Display the help menu when activated
	if (currentFunction != functionHelp) {
		exit;
	}

	var controlStr = "CTRL";
	if (os_type == os_macosx) {
		controlStr = "CMD";
	}

	var helpMenuHeight = 11;
	ds_grid_resize(functionHelp_menuGrid, functionHelp_menuGridWidth, helpMenuHeight);

	ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colName, 0, "help_label_shortcuts");
	ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colHide, 0, false);
	ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colCollapsed, 0, true);
	ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colGrid, 0, functionHelp_helpGridShortcuts);

	ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colName, 1, "help_header_link");
	ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colHide, 1, false);
	ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colCollapsed, 1, true);
	ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colGrid, 1, functionHelp_helpGridLink);

	ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colName, 2, "help_header_pick");
	ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colHide, 2, false);
	ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colCollapsed, 2, true);
	ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colGrid, 2, functionHelp_helpGridPick);

	ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colName, 3, "help_header_search");
	ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colHide, 3, false);
	ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colCollapsed, 3, true);
	ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colGrid, 3, functionHelp_helpGridSearch);

	ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colName, 4, "help_header_view");
	ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colHide, 4, false);
	ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colCollapsed, 4, true);
	ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colGrid, 4, functionHelp_helpGridView);

	ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colName, 5, "help_header_file");
	ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colHide, 5, false);
	ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colCollapsed, 5, true);
	ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colGrid, 5, functionHelp_helpGridFile);

	ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colName, 6, "help_header_move");
	ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colHide, 6, false);
	ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colCollapsed, 6, true);
	ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colGrid, 6, functionHelp_helpGridMove);

	ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colName, 7, "help_header_play");
	ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colHide, 7, true);
	ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colCollapsed, 7, true);
	ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colGrid, 7, functionHelp_helpGridPlay);

	ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colName, 8, "help_header_rightClick");
	ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colHide, 8, false);
	ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colCollapsed, 8, true);
	ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colGrid, 8, functionHelp_helpGridRightClick);
	
	ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colName, 9, "menu_settings");
	ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colHide, 9, false);
	ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colCollapsed, 9, true);
	ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colGrid, 9, functionHelp_helpGridSettings);

	ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colName, 10, "help_header_advanced");
	ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colHide, 10, false);
	ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colCollapsed, 10, true);
	ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colGrid, 10, functionHelp_helpGridAdvanced);





	// SHORTCUTS SECTION
	ds_grid_resize(functionHelp_helpGridShortcuts, functionHelp_helpGridWidth, 18);

	// Shortcuts -> Track tool
	ds_grid_set(functionHelp_helpGridShortcuts, functionHelp_helpGrid_colKey, 0, "key_track");
	ds_grid_set(functionHelp_helpGridShortcuts, functionHelp_helpGrid_colFunc, 0, "help_shortcut_track-tool");
	ds_grid_set(functionHelp_helpGridShortcuts, functionHelp_helpGrid_colHide, 0, false);
	
	// Shortcuts -> Resonance tool
	ds_grid_set(functionHelp_helpGridShortcuts, functionHelp_helpGrid_colKey, 1, "key_rez");
	ds_grid_set(functionHelp_helpGridShortcuts, functionHelp_helpGrid_colFunc, 1, "help_shortcut_resonance-tool");
	ds_grid_set(functionHelp_helpGridShortcuts, functionHelp_helpGrid_colHide, 1, false);
	
	// Shortcuts -> DELETE
	ds_grid_set(functionHelp_helpGridShortcuts, functionHelp_helpGrid_colKey, 2, "DELETE");
	ds_grid_set(functionHelp_helpGridShortcuts, functionHelp_helpGrid_colFunc, 2, "help_description_remove-from-chain");
	ds_grid_set(functionHelp_helpGridShortcuts, functionHelp_helpGrid_colHide, 2, false);
	
	// Shortcuts -> Filter current chain
	ds_grid_set(functionHelp_helpGridShortcuts, functionHelp_helpGrid_colKey, 3, "key_pick");
	ds_grid_set(functionHelp_helpGridShortcuts, functionHelp_helpGrid_colFunc, 3, "help_shortcut_pick");
	ds_grid_set(functionHelp_helpGridShortcuts, functionHelp_helpGrid_colHide, 3, false);
	
	// Shortcuts -> Filter all
	ds_grid_set(functionHelp_helpGridShortcuts, functionHelp_helpGrid_colKey, 4, controlStr + " p");
	ds_grid_set(functionHelp_helpGridShortcuts, functionHelp_helpGrid_colFunc, 4, "option_filter-all");
	ds_grid_set(functionHelp_helpGridShortcuts, functionHelp_helpGrid_colHide, 4, false);
	
	// Shortcuts -> One-to-many
	ds_grid_set(functionHelp_helpGridShortcuts, functionHelp_helpGrid_colKey, 5, "m");
	ds_grid_set(functionHelp_helpGridShortcuts, functionHelp_helpGrid_colFunc, 5, "option_one-to-many");
	ds_grid_set(functionHelp_helpGridShortcuts, functionHelp_helpGrid_colHide, 5, false);
	
	// Shortcuts -> Navigation pane
	ds_grid_set(functionHelp_helpGridShortcuts, functionHelp_helpGrid_colKey, 6, "n");
	ds_grid_set(functionHelp_helpGridShortcuts, functionHelp_helpGrid_colFunc, 6, "help_shortcut_navigation-pane");
	ds_grid_set(functionHelp_helpGridShortcuts, functionHelp_helpGrid_colHide, 6, false);

	// Shortcuts -> Justify
	ds_grid_set(functionHelp_helpGridShortcuts, functionHelp_helpGrid_colKey, 7, "key_justify");
	ds_grid_set(functionHelp_helpGridShortcuts, functionHelp_helpGrid_colFunc, 7, "help_shortcut_justify");
	ds_grid_set(functionHelp_helpGridShortcuts, functionHelp_helpGrid_colHide, 7, false);

	// Shortcuts -> Prose vs grid display
	ds_grid_set(functionHelp_helpGridShortcuts, functionHelp_helpGrid_colKey, 8, "k");
	ds_grid_set(functionHelp_helpGridShortcuts, functionHelp_helpGrid_colFunc, 8, "help_description_prose");
	ds_grid_set(functionHelp_helpGridShortcuts, functionHelp_helpGrid_colHide, 8, false);

	// Shortcuts -> Text direction
	ds_grid_set(functionHelp_helpGridShortcuts, functionHelp_helpGrid_colKey, 9, "l");
	ds_grid_set(functionHelp_helpGridShortcuts, functionHelp_helpGrid_colFunc, 9, "help_shortcut_text-direction");
	ds_grid_set(functionHelp_helpGridShortcuts, functionHelp_helpGrid_colHide, 9, false);
	
	// Shortcuts -> Word tips
	ds_grid_set(functionHelp_helpGridShortcuts, functionHelp_helpGrid_colKey, 10, "w");
	ds_grid_set(functionHelp_helpGridShortcuts, functionHelp_helpGrid_colFunc, 10, "help_description_word-tip");
	ds_grid_set(functionHelp_helpGridShortcuts, functionHelp_helpGrid_colHide, 10, false);

	// Shortcuts -> Select wordform display
	ds_grid_set(functionHelp_helpGridShortcuts, functionHelp_helpGrid_colKey, 11, "key_word-format");
	ds_grid_set(functionHelp_helpGridShortcuts, functionHelp_helpGrid_colFunc, 11, "help_shortcut_wordform-display");
	ds_grid_set(functionHelp_helpGridShortcuts, functionHelp_helpGrid_colHide, 11, false);
	
	// Shortcuts -> Insert zero before
	ds_grid_set(functionHelp_helpGridShortcuts, functionHelp_helpGrid_colKey, 12, "z");
	ds_grid_set(functionHelp_helpGridShortcuts, functionHelp_helpGrid_colFunc, 12, "help_shortcut_zero-before");
	ds_grid_set(functionHelp_helpGridShortcuts, functionHelp_helpGrid_colHide, 12, false);

	// Shortcuts -> Insert zero after
	ds_grid_set(functionHelp_helpGridShortcuts, functionHelp_helpGrid_colKey, 13, "SHIFT z");
	ds_grid_set(functionHelp_helpGridShortcuts, functionHelp_helpGrid_colFunc, 13, "help_shortcut_zero-after");
	ds_grid_set(functionHelp_helpGridShortcuts, functionHelp_helpGrid_colHide, 13, false);

	// Shortcuts -> Insert zero after
	ds_grid_set(functionHelp_helpGridShortcuts, functionHelp_helpGrid_colKey, 14, controlStr + " f");
	ds_grid_set(functionHelp_helpGridShortcuts, functionHelp_helpGrid_colFunc, 14, "help_shortcut_find-all");
	ds_grid_set(functionHelp_helpGridShortcuts, functionHelp_helpGrid_colHide, 14, false);
	
	// Shortcuts -> Go to line
	ds_grid_set(functionHelp_helpGridShortcuts, functionHelp_helpGrid_colKey, 15, "key_go-to-line");
	ds_grid_set(functionHelp_helpGridShortcuts, functionHelp_helpGrid_colFunc, 15, "menu_go-to-line");
	ds_grid_set(functionHelp_helpGridShortcuts, functionHelp_helpGrid_colHide, 15, false);
	
	// Shortcuts -> Select view
	ds_grid_set(functionHelp_helpGridShortcuts, functionHelp_helpGrid_colKey, 16, "key_change-view");
	ds_grid_set(functionHelp_helpGridShortcuts, functionHelp_helpGrid_colFunc, 16, "help_description_view-select");
	ds_grid_set(functionHelp_helpGridShortcuts, functionHelp_helpGrid_colHide, 16, false);

	// Shortcuts -> Save file
	ds_grid_set(functionHelp_helpGridShortcuts, functionHelp_helpGrid_colKey, 17, controlStr + " s");
	ds_grid_set(functionHelp_helpGridShortcuts, functionHelp_helpGrid_colFunc, 17, "help_description_save");
	ds_grid_set(functionHelp_helpGridShortcuts, functionHelp_helpGrid_colHide, 17, false);












	var helpGridHeightLink = 12;
	ds_grid_resize(functionHelp_helpGridLink, functionHelp_helpGridWidth, helpGridHeightLink);

	ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colKey, 0, "key_word_click");
	ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colFunc, 0, "help_label_link");
	ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colDesc, 0, "help_description_link-word");
	ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colHide, 0, false);

	ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colKey, 1, "key_quit-chain");
	ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colFunc, 1, "help_label_quit-chain");
	ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colDesc, 1, "help_description_quit-chain");
	ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colHide, 1, false);

	ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colKey, 2, "key_delete_link");
	ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colFunc, 2, "help_label_delete-link");
	ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colDesc, 2, "help_description_delete-link");
	ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colHide, 2, false);

	ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colKey, 3, "key_rez");
	ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colFunc, 3, "help_label_resonance");
	ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colDesc, 3, "help_description_rez");
	ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colHide, 3, false);

	ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colKey, 4, "key_track");
	ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colFunc, 4, "help_label_track");
	ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colDesc, 4, "help_description_track");
	ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colHide, 4, false);

	ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colKey, 5, "key_stack");
	ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colFunc, 5, "help_label_stack");
	ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colDesc, 5, "help_description_stack");
	ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colHide, 5, true);

	ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colKey, 6, "key_clique");
	ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colFunc, 6, "menu_clique");
	ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colDesc, 6, "help_description_clique-tab");
	ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colHide, 6, true);

	ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colKey, 7, "key_quicklink");
	ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colFunc, 7, "help_label_quicklink");
	ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colDesc, 7, "help_description_quicklink");
	ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colHide, 7, false);

	ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colKey, 8, "key_quickstack");
	ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colFunc, 8, "help_label_quickstack");
	ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colDesc, 8, "help_description_quickstack");
	ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colHide, 8, false);

	ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colKey, 9, "key_insert-word");
	ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colFunc, 9, "help_label_new_word");
	ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colDesc, 9, "help_description_insert-word");
	ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colHide, 9, true);

	ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colKey, 10, "key_box");
	ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colFunc, 10, "help_label_box");
	ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colDesc, 10, "help_description_box");
	ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colHide, 10, true);

	ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colKey, 11, "key_delete_chain");
	ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colFunc, 11, "help_label_delete_chain");
	ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colDesc, 11, "help_description_delete-chain");
	ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colHide, 11, false);

	var helpGridHeightPick = 3;
	ds_grid_resize(functionHelp_helpGridPick, functionHelp_helpGridWidth, helpGridHeightPick);

	ds_grid_set(functionHelp_helpGridPick, functionHelp_helpGrid_colKey, 0, "key_pick");
	ds_grid_set(functionHelp_helpGridPick, functionHelp_helpGrid_colFunc, 0, "help_label_pick");
	ds_grid_set(functionHelp_helpGridPick, functionHelp_helpGrid_colDesc, 0, "help_description_pick-chain");
	ds_grid_set(functionHelp_helpGridPick, functionHelp_helpGrid_colHide, 0, false);

	ds_grid_set(functionHelp_helpGridPick, functionHelp_helpGrid_colKey, 1, "key_filter");
	ds_grid_set(functionHelp_helpGridPick, functionHelp_helpGrid_colFunc, 1, "help_label_filter");
	ds_grid_set(functionHelp_helpGridPick, functionHelp_helpGrid_colDesc, 1, "help_description_filter");
	ds_grid_set(functionHelp_helpGridPick, functionHelp_helpGrid_colHide, 1, false);

	ds_grid_set(functionHelp_helpGridPick, functionHelp_helpGrid_colKey, 2, controlStr + "key_track");
	ds_grid_set(functionHelp_helpGridPick, functionHelp_helpGrid_colFunc, 2, "help_label_align");
	ds_grid_set(functionHelp_helpGridPick, functionHelp_helpGrid_colDesc, 2, "help_description_align");
	ds_grid_set(functionHelp_helpGridPick, functionHelp_helpGrid_colHide, 2, true);


	// SEARCH SECTION
	ds_grid_resize(functionHelp_helpGridSearch, functionHelp_helpGridWidth, 2);

	// Search -> Search
	ds_grid_set(functionHelp_helpGridSearch, functionHelp_helpGrid_colKey, 0, controlStr + " f");
	ds_grid_set(functionHelp_helpGridSearch, functionHelp_helpGrid_colFunc, 0, "help_label_search");
	ds_grid_set(functionHelp_helpGridSearch, functionHelp_helpGrid_colDesc, 0, "help_description_search-word");
	ds_grid_set(functionHelp_helpGridSearch, functionHelp_helpGrid_colHide, 0, false);

	// Search -> Go to line
	ds_grid_set(functionHelp_helpGridSearch, functionHelp_helpGrid_colKey, 1, "key_go-to-line");
	ds_grid_set(functionHelp_helpGridSearch, functionHelp_helpGrid_colFunc, 1, "help_label_go-to-line");
	ds_grid_set(functionHelp_helpGridSearch, functionHelp_helpGrid_colDesc, 1, "help_description_go-to-line");
	ds_grid_set(functionHelp_helpGridSearch, functionHelp_helpGrid_colHide, 1, false);


	// VIEW SECTION
	ds_grid_resize(functionHelp_helpGridView, functionHelp_helpGridWidth, 4);

	// View -> Justify
	ds_grid_set(functionHelp_helpGridView, functionHelp_helpGrid_colKey, 0, "key_justify");
	ds_grid_set(functionHelp_helpGridView, functionHelp_helpGrid_colFunc, 0, "help_label_justify");
	ds_grid_set(functionHelp_helpGridView, functionHelp_helpGrid_colDesc, 0, "help_description_justify");
	ds_grid_set(functionHelp_helpGridView, functionHelp_helpGrid_colHide, 0, false);
	
	// View -> Prose
	ds_grid_set(functionHelp_helpGridView, functionHelp_helpGrid_colKey, 1, "k");
	ds_grid_set(functionHelp_helpGridView, functionHelp_helpGrid_colFunc, 1, "import_type_prose");
	ds_grid_set(functionHelp_helpGridView, functionHelp_helpGrid_colDesc, 1, "help_description_prose");
	ds_grid_set(functionHelp_helpGridView, functionHelp_helpGrid_colHide, 1, false);

	// View -> Word Tip
	ds_grid_set(functionHelp_helpGridView, functionHelp_helpGrid_colKey, 2, "w");
	ds_grid_set(functionHelp_helpGridView, functionHelp_helpGrid_colFunc, 2, "word_tip");
	ds_grid_set(functionHelp_helpGridView, functionHelp_helpGrid_colDesc, 2, "help_description_word-tip");
	ds_grid_set(functionHelp_helpGridView, functionHelp_helpGrid_colHide, 2, false);
	
	// View -> Word Format
	ds_grid_set(functionHelp_helpGridView, functionHelp_helpGrid_colKey, 3, "key_word-format");
	ds_grid_set(functionHelp_helpGridView, functionHelp_helpGrid_colFunc, 3, "help_label_word-format2");
	ds_grid_set(functionHelp_helpGridView, functionHelp_helpGrid_colDesc, 3, "help_description_word-format2");
	ds_grid_set(functionHelp_helpGridView, functionHelp_helpGrid_colHide, 3, false);


	// FILE SECTION
	ds_grid_resize(functionHelp_helpGridFile, functionHelp_helpGridWidth, 2);

	// File -> Open
	ds_grid_set(functionHelp_helpGridFile, functionHelp_helpGrid_colKey, 0, controlStr + "O");
	ds_grid_set(functionHelp_helpGridFile, functionHelp_helpGrid_colFunc, 0, "help_label_open");
	ds_grid_set(functionHelp_helpGridFile, functionHelp_helpGrid_colDesc, 0, "help_description_open-file");
	ds_grid_set(functionHelp_helpGridFile, functionHelp_helpGrid_colHide, 0, false);

	// File -> Save
	ds_grid_set(functionHelp_helpGridFile, functionHelp_helpGrid_colKey, 1, "key_save");
	ds_grid_set(functionHelp_helpGridFile, functionHelp_helpGrid_colFunc, 1, "help_label_save");
	ds_grid_set(functionHelp_helpGridFile, functionHelp_helpGrid_colDesc, 1, "help_description_save");
	ds_grid_set(functionHelp_helpGridFile, functionHelp_helpGrid_colHide, 1, false);

	var helpGridHeightMove = 14;
	ds_grid_resize(functionHelp_helpGridMove, functionHelp_helpGridWidth, helpGridHeightMove);

	ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colKey, 0, "key_move-up");
	ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colFunc, 0, "help_label_move-up");
	ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colDesc, 0, "help_description_move-up");
	ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colHide, 0, false);

	ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colKey, 1, "key_move-down");
	ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colFunc, 1, "help_label_down");
	ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colDesc, 1, "help_description_move-down");
	ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colHide, 1, false);

	ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colKey, 2, "key_move-left");
	ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colFunc, 2, "help_label_move-left");
	ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colDesc, 2, "help_description_move-left");
	ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colHide, 2, false);

	ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colKey, 3, "key_move-right");
	ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colFunc, 3, "help_label_move-right");
	ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colDesc, 3, "help_description_move-right");
	ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colHide, 3, false);

	ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colKey, 4, "key_home");
	ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colFunc, 4, "help_label_home");
	ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colDesc, 4, "help_description_home");
	ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colHide, 4, false);

	var correctKey = "";
	if(os_type == os_macosx){
		correctKey = "Option";
	}
	else{
		correctKey = controlStr;
	}

	ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colKey, 5, "["+ correctKey +"] " + scr_get_translation("key_home_alt"));
	ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colFunc, 5, "help_label_home");
	ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colDesc, 5, "help_description_home");
	ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colHide, 5, false);

	ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colKey, 6, "key_end-of-line");
	ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colFunc, 6, "help_label_end");
	ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colDesc, 6,"help_description_end-of-line");
	ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colHide, 6, false);

	ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colKey, 7, "["+ correctKey +"] " + scr_get_translation("key_end-of-line_alt"));
	ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colFunc, 7, "help_label_end");
	ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colDesc, 7, "help_description_end-of-line");
	ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colHide, 7, false);

	ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colKey, 8, "key_pageup");
	ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colFunc, 8, "help_label_pageup");
	ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colDesc, 8, "help_description_pageup");
	ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colHide, 8, false);

	ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colKey, 9, "key_pagedown");
	ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colFunc, 9, "help_label_pagedown");
	ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colDesc, 9, "help_description_pagedown");
	ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colHide, 9, false);

	ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colKey, 10, "["+ correctKey +"] " + scr_get_translation("key_start-of-file"));
	ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colFunc,10, "help_label_first-line");
	ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colDesc, 10, "help_description_go-first-line");
	ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colHide, 10, false);

	ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colKey, 11, "["+ correctKey +"] " + scr_get_translation("key_end-of-file"));
	ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colFunc, 11, "help_label_end-of-file");
	ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colDesc, 11, "help_description_end-of-file");
	ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colHide, 11, false);

	ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colKey, 12, "key_next-pane");
	ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colFunc, 12, "help_label_next");
	ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colDesc, 12, "help_description_next-pane");
	ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colHide,12, true);

	ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colKey, 13, "key_change-view-reverse");
	ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colFunc, 13, "help_label_view-reverse");
	ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colDesc, 13, "help_description_Next-link");
	ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colHide, 13, true);


	var helpGridHeightPlay = 3;
	ds_grid_resize(functionHelp_helpGridPlay, functionHelp_helpGridWidth, helpGridHeightPlay);

	ds_grid_set(functionHelp_helpGridPlay, functionHelp_helpGrid_colKey, 0, "key_playAudio");
	ds_grid_set(functionHelp_helpGridPlay, functionHelp_helpGrid_colFunc, 0, "help_label_play");
	ds_grid_set(functionHelp_helpGridPlay, functionHelp_helpGrid_colDesc, 0, "help_description_playaudio");
	ds_grid_set(functionHelp_helpGridPlay, functionHelp_helpGrid_colHide, 0, false);

	ds_grid_set(functionHelp_helpGridPlay, functionHelp_helpGrid_colKey, 1, "key_syncplay");
	ds_grid_set(functionHelp_helpGridPlay, functionHelp_helpGrid_colFunc, 1, "help_label_syncplay");
	ds_grid_set(functionHelp_helpGridPlay, functionHelp_helpGrid_colDesc, 1, "help_description_syncplay");
	ds_grid_set(functionHelp_helpGridPlay, functionHelp_helpGrid_colHide, 1, false);

	ds_grid_set(functionHelp_helpGridPlay, functionHelp_helpGrid_colKey, 2, "key_mute");
	ds_grid_set(functionHelp_helpGridPlay, functionHelp_helpGrid_colFunc, 2, "help_label_mute");
	ds_grid_set(functionHelp_helpGridPlay, functionHelp_helpGrid_colDesc, 2, "help_description_mute");
	ds_grid_set(functionHelp_helpGridPlay, functionHelp_helpGrid_colHide, 2, false);

	var helpGridHeightAdvanced = 2;
	ds_grid_resize(functionHelp_helpGridAdvanced, functionHelp_helpGridWidth, helpGridHeightAdvanced);
	var altOption = "";
	if( os_type = os_macosx){
		altOption = "Option";
	}
	else{
		altOption = "Alt";
	}


	ds_grid_set(functionHelp_helpGridAdvanced, functionHelp_helpGrid_colKey, 0, "["+ altOption + "] [Shift] V");
	ds_grid_set(functionHelp_helpGridAdvanced, functionHelp_helpGrid_colFunc, 0, "Map View");
	ds_grid_set(functionHelp_helpGridAdvanced, functionHelp_helpGrid_colDesc, 0, "Toggle Map Viewer");
	ds_grid_set(functionHelp_helpGridAdvanced, functionHelp_helpGrid_colHide, 0, false);

	ds_grid_set(functionHelp_helpGridAdvanced, functionHelp_helpGrid_colKey, 1, "["+ altOption + "]" + " [Shift] D");
	ds_grid_set(functionHelp_helpGridAdvanced, functionHelp_helpGrid_colFunc, 1, "help_label_developer");
	ds_grid_set(functionHelp_helpGridAdvanced, functionHelp_helpGrid_colDesc, 1, "help_description_developer-view");
	ds_grid_set(functionHelp_helpGridAdvanced, functionHelp_helpGrid_colHide, 1, false);





	// RIGHT CLICK SECTION
	ds_grid_resize(functionHelp_helpGridRightClick, functionHelp_helpGridWidth, 5);

	ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colKey, 0, "key_replace");
	ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colFunc, 0, "help_label_new_word");
	ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colDesc, 0, "help_description_insert-word");
	ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colHide, 0, false);

	ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colKey, 1, "key_replace");
	ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colFunc, 1, "help_label_delete-inserted-word");
	ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colDesc, 1, "help_description_delete-new-word");
	ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colHide, 1, false);

	ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colKey, 2, "key_chain_context-menu");
	ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colFunc, 2, "help_label_rename");
	ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colDesc, 2, "help_description_rename");
	ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colHide, 2, false);

	ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colKey, 3, "key_chain_context-menu");
	ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colFunc, 3, "help_label_delete_plain");
	ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colDesc, 3, "help_description_delete-plain");
	ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colHide, 3, true);

	ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colKey, 4, "key_chain_context-menu");
	ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colFunc, 4, "help_label_caption");
	ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colDesc, 4, "help_description_caption");
	ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colHide, 4, true);


	// SETTINGS SECTION
	ds_grid_resize(functionHelp_helpGridSettings, functionHelp_helpGridWidth, 5);
	
	// Settings -> Decrease column width
	ds_grid_set(functionHelp_helpGridSettings, functionHelp_helpGrid_colKey, 0, "key_narrow-columns");
	ds_grid_set(functionHelp_helpGridSettings, functionHelp_helpGrid_colFunc, 0, "help_description_decrease");
	ds_grid_set(functionHelp_helpGridSettings, functionHelp_helpGrid_colDesc, 0, "help_label_columns-narrow");
	ds_grid_set(functionHelp_helpGridSettings, functionHelp_helpGrid_colHide, 0, false);
	
	// Settings -> Increase column width
	ds_grid_set(functionHelp_helpGridSettings, functionHelp_helpGrid_colKey, 1, "key_wide-columns");
	ds_grid_set(functionHelp_helpGridSettings, functionHelp_helpGrid_colFunc, 1, "help_description_increase");
	ds_grid_set(functionHelp_helpGridSettings, functionHelp_helpGrid_colDesc, 1, "help_label_wide-columns");
	ds_grid_set(functionHelp_helpGridSettings, functionHelp_helpGrid_colHide, 1, false);
	
	// Settings -> Decrease line height
	ds_grid_set(functionHelp_helpGridSettings, functionHelp_helpGrid_colKey, 2, "key_low-rows");
	ds_grid_set(functionHelp_helpGridSettings, functionHelp_helpGrid_colFunc, 2, "help_description_decrease-height");
	ds_grid_set(functionHelp_helpGridSettings, functionHelp_helpGrid_colDesc, 2, "help_label_decrease_height");
	ds_grid_set(functionHelp_helpGridSettings, functionHelp_helpGrid_colHide, 2, false);
	
	// Settings -> Increase line height
	ds_grid_set(functionHelp_helpGridSettings, functionHelp_helpGrid_colKey, 3, "key_tall-rows");
	ds_grid_set(functionHelp_helpGridSettings, functionHelp_helpGrid_colFunc, 3, "help_description_increase_height");
	ds_grid_set(functionHelp_helpGridSettings, functionHelp_helpGrid_colDesc, 3, "help_label_tall-rows");
	ds_grid_set(functionHelp_helpGridSettings, functionHelp_helpGrid_colHide, 3, false);
	
	// Settings -> Select theme
	ds_grid_set(functionHelp_helpGridSettings, functionHelp_helpGrid_colKey, 4, "key_theme");
	ds_grid_set(functionHelp_helpGridSettings, functionHelp_helpGrid_colFunc, 4, "help_description_theme");
	ds_grid_set(functionHelp_helpGridSettings, functionHelp_helpGrid_colDesc, 4, "help_label_theme");
	ds_grid_set(functionHelp_helpGridSettings, functionHelp_helpGrid_colHide, 4, false);
	
	

	var helpGridHeightRez = 21;
	ds_grid_resize(functionHelp_helpGridRez, functionHelp_helpGridWidth, helpGridHeightRez);

	ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 0, "key_focus");
	ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colFunc, 0, "help_label_focus");
	ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 0, "help_description_focus");

	ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 1, "key_quit-chain");
	ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colFunc, 1, "help_label_quit");
	ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 1, "help_description_quit-chain");

	ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 2, "key_delete_link");
	ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colFunc, 2, "help_label_zap");
	ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 2, "help_description_zap");

	ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 3, "key_rez");
	ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colFunc, 3, "help_label_resonance");
	ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 3, "help_description_rez");

	ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 4, "key_track");
	ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colFunc, 4, "help_label_track");
	ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 4, "help_description_track2");

	ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 5, "key_stack");
	ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colFunc, 5, "help_label_stack");
	ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 5, "help_description_stack_2");

	ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 6, "key_clique");
	ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colFunc, 6, "menu_clique");
	ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 6, "help_description_clique-tab2");

	ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 7, "key_pick");
	ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colFunc, 7, "help_label_pick");
	ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 7, "help_description_pick-chain");

	ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 8, "key_change-view");
	ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colFunc, 8, "help_label_view-select");
	ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 8, "help_description_view-select");

	ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 9, "key_justify");
	ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colFunc, 9, "help_label_justify");
	ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 9, "help_description_justify");

	ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 10, "key_word-format");
	ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colFunc, 10, "help_label_word-format2");
	ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 10, "help_description_word-format2");

	ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 11, controlStr + "+p");
	ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colFunc, 11, "help_label_filter");
	ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 11, "help_description_filter");

	ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 12, controlStr + "+t");
	ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colFunc, 12, "help_label_align");
	ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 12, "help_description_align");

	ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 13, controlStr + "+- [minus]");
	ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colFunc, 13, "help_label_zoom-out");
	ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 13, "help_description_columns-narrow");

	ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 14, controlStr + "++ [plus]");
	ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colFunc, 14, "help_label_zoom-in");
	ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 14, "help_description_columns-wide");

	ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 15, "SHIFT+- [minus]");
	ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colFunc, 15, "help_label_short");
	ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 15, "help_description_line-height-decrease");

	ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 16, "SHIFT++ [plus]");
	ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colFunc, 16, "help_label_tall-rows");
	ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 16, "help_description_tall");

	ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 17, "key_search");
	ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colFunc, 17, "help_label_find");
	ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 17, "help_description_find-all");

	ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 18, "key_go-to-line");
	ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colFunc, 18, "help_label_go-to-line");
	ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 18, "help_description_go-to-line");

	ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 19, controlStr + "+o");
	ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colFunc, 19, "help_label_open");
	ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 19, "help_description_open-file");

	ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 20, "key_save");
	ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colFunc, 20, "help_label_save");
	ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 20, "help_description_save");





	var helpGridHeightNav = 13;
	ds_grid_resize(functionHelp_helpGridNav, functionHelp_helpGridWidth, helpGridHeightNav);

	ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colKey, 0,"key_move-up");
	ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colFunc, 0, "help_label_move-up");
	ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colDesc, 0, "help_description_move-up");

	ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colKey, 1, "key_move-down");
	ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colFunc, 1, "help_label_down");
	ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colDesc, 1, "help_description_move-down");

	ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colKey, 2, "key_move-left");
	ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colFunc, 2, "help_label_move-left");
	ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colDesc, 2, "help_description_move-left");

	ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colKey, 3, "key_move-right");
	ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colFunc, 3, "help_label_move-right");
	ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colDesc, 3, "help_description_move-right");

	ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colKey, 4, "key_home");
	ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colFunc, 4, "help_label_home");
	ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colDesc, 4, "help_description_home");

	ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colKey, 5, controlStr + "key_home_alt");
	ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colFunc, 5, "help_label_home");
	ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colDesc, 5, "help_description_home");

	ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colKey, 6, "key_end-of-line");
	ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colFunc, 6, "help_label_end");
	ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colDesc, 6, "help_description_end-of-line");

	ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colKey, 7, controlStr + "key_end-of-line_alt");
	ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colFunc, 7, "help_label_end");
	ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colDesc, 7, "help_description_end-of-line");

	ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colKey, 8, "key_pageup");
	ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colFunc, 8, "help_label_pageup");
	ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colDesc, 8, "help_description_pageup");

	ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colKey, 9, "key_pagedown");
	ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colFunc, 9, "help_label_pagedown");
	ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colDesc, 9, "help_description_pagedown");

	ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colKey, 10, controlStr + "key_start-of-file");
	ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colFunc,10, "help_label_first-line");
	ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colDesc, 10, "help_description_go-first-line");

	ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colKey, 11, controlStr + "key_end-of-file");
	ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colFunc, 11, "help_label_end-of-file");
	ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colDesc, 11, "help_description_end-of-file");

	ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colKey, 12, "key_next-pane");
	ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colFunc, 12, "help_label_next");
	ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colDesc, 12, "help_description_next-pane");
}
///@description HelpMenu

// Display the help menu when activated
if (currentFunction != functionHelp) {
	exit;
}

var controlStr = "CTRL";
if (os_type == os_macosx) {
	controlStr = "CMD";
}

var helpMenuHeight = 10;
ds_grid_resize(functionHelp_menuGrid, functionHelp_menuGridWidth, helpMenuHeight);

ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colName, 0, scr_get_translation("help_header_link"));
ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colHide, 0, false);
ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colCollapsed, 0, true);
ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colGrid, 0, functionHelp_helpGridLink);

ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colName, 1, scr_get_translation("help_header_pick"));
ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colHide, 1, false);
ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colCollapsed, 1, true);
ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colGrid, 1, functionHelp_helpGridPick);

ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colName, 2, scr_get_translation("help_header_search"));
ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colHide, 2, false);
ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colCollapsed, 2, true);
ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colGrid, 2, functionHelp_helpGridSearch);

ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colName, 3, scr_get_translation("help_header_view"));
ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colHide, 3, false);
ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colCollapsed, 3, true);
ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colGrid, 3, functionHelp_helpGridView);

ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colName, 4, scr_get_translation("help_header_file"));
ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colHide, 4, false);
ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colCollapsed, 4, true);
ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colGrid, 4, functionHelp_helpGridFile);

ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colName, 5, scr_get_translation("help_header_move"));
ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colHide, 5, false);
ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colCollapsed, 5, true);
ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colGrid, 5, functionHelp_helpGridMove);

ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colName, 6, scr_get_translation("help_header_play"));
ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colHide, 6, true);
ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colCollapsed, 6, true);
ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colGrid, 6, functionHelp_helpGridPlay);


ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colName, 7, scr_get_translation("help_header_rightClick"));
ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colHide, 7, false);
ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colCollapsed, 7, true);
ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colGrid, 7, functionHelp_helpGridRightClick);

ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colName, 8, scr_get_translation("help_header_advanced"));
ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colHide, 8, false);
ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colCollapsed, 8, true);
ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colGrid, 8, functionHelp_helpGridAdvanced);

ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colName, 9, scr_get_translation("help_header_about"));
ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colHide, 9, false);
ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colCollapsed, 9, true);
ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colGrid, 9, functionHelp_helpGridAbout);



//show_message(string(ds_grid_height(functionHelp_menuGrid)));

var helpGridHeightLink = 12;
ds_grid_resize(functionHelp_helpGridLink, functionHelp_helpGridWidth, helpGridHeightLink);

ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colKey, 0, scr_get_translation("key_click"));
ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colFunc, 0, scr_get_translation("help_label_link"));
ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colDesc, 0, scr_get_translation("help_description_link-word"));
ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colHide, 0, false);

ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colKey, 1, scr_get_translation("key_quit-chain"));
ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colFunc, 1, scr_get_translation("help_label_quit-chain"));
ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colDesc, 1, scr_get_translation("help_description_quit-chain2"));
ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colHide, 1, false);

ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colKey, 2, scr_get_translation("key_delete_link"));
ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colFunc, 2, scr_get_translation("help_label_delete-link"));
ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colDesc, 2, scr_get_translation("help_description_delete-link"));
ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colHide, 2, false);

ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colKey, 3, scr_get_translation("key_rez"));
ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colFunc, 3, scr_get_translation("help_label_rez"));
ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colDesc, 3, scr_get_translation("help_description_rez"));
ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colHide, 3, false);

ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colKey, 4, scr_get_translation("key_track"));
ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colFunc, 4, scr_get_translation("help_label_track"));
ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colDesc, 4, scr_get_translation("help_description_track"));
ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colHide, 4, false);

ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colKey, 5, scr_get_translation("key_stack"));
ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colFunc, 5, scr_get_translation("help_label_stack"));
ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colDesc, 5, scr_get_translation("help_description_stack"));
ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colHide, 5, true);

ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colKey, 6, scr_get_translation("key_clique"));
ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colFunc, 6, scr_get_translation("help_label_clique"));
ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colDesc, 6, scr_get_translation("help_description_clique-tab"));
ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colHide, 6, true);

ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colKey, 7, scr_get_translation("key_quicklink"));
ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colFunc, 7, scr_get_translation("help_label_quicklink"));
ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colDesc, 7, scr_get_translation("help_description_quicklink"));
ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colHide, 7, false);

ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colKey, 8, scr_get_translation("key_quickstack"));
ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colFunc, 8, scr_get_translation("help_label_quickstack"));
ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colDesc, 8, scr_get_translation("help_description_quickstack"));
ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colHide, 8, false);

ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colKey, 9, scr_get_translation("key_insert-word"));
ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colFunc, 9, scr_get_translation("help_label_new_word"));
ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colDesc, 9, scr_get_translation("help_description_insert-word"));
ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colHide, 9, true);

ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colKey, 10, scr_get_translation("key_box"));
ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colFunc, 10, scr_get_translation("help_label_box"));
ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colDesc, 10, scr_get_translation("help_description_box"));
ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colHide, 10, true);

ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colKey, 11, scr_get_translation("key_delete_chain"));
ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colFunc, 11, scr_get_translation("help_label_delete_chain"));
ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colDesc, 11, scr_get_translation("help_description_delete-chain"));
ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colHide, 11, false);

var helpGridHeightPick = 3;
ds_grid_resize(functionHelp_helpGridPick, functionHelp_helpGridWidth, helpGridHeightPick);

ds_grid_set(functionHelp_helpGridPick, functionHelp_helpGrid_colKey, 0, scr_get_translation("key_pick"));
ds_grid_set(functionHelp_helpGridPick, functionHelp_helpGrid_colFunc, 0, scr_get_translation("help_label_pick"));
ds_grid_set(functionHelp_helpGridPick, functionHelp_helpGrid_colDesc, 0, scr_get_translation("help_description_pick-chain"));
ds_grid_set(functionHelp_helpGridPick, functionHelp_helpGrid_colHide, 0, false);

ds_grid_set(functionHelp_helpGridPick, functionHelp_helpGrid_colKey, 1, scr_get_translation("key_filter"));
ds_grid_set(functionHelp_helpGridPick, functionHelp_helpGrid_colFunc, 1, scr_get_translation("help_label_filter"));
ds_grid_set(functionHelp_helpGridPick, functionHelp_helpGrid_colDesc, 1, scr_get_translation("help_description_filter"));
ds_grid_set(functionHelp_helpGridPick, functionHelp_helpGrid_colHide, 1, false);

ds_grid_set(functionHelp_helpGridPick, functionHelp_helpGrid_colKey, 2, controlStr + scr_get_translation("key_track"));
ds_grid_set(functionHelp_helpGridPick, functionHelp_helpGrid_colFunc, 2, scr_get_translation("help_label_align"));
ds_grid_set(functionHelp_helpGridPick, functionHelp_helpGrid_colDesc, 2, scr_get_translation("help_description_align"));
ds_grid_set(functionHelp_helpGridPick, functionHelp_helpGrid_colHide, 2, true);

var helpGridHeightSearch = 2;
ds_grid_resize(functionHelp_helpGridSearch, functionHelp_helpGridWidth, helpGridHeightSearch);

ds_grid_set(functionHelp_helpGridSearch, functionHelp_helpGrid_colKey, 0, scr_get_translation("key_search"));
ds_grid_set(functionHelp_helpGridSearch, functionHelp_helpGrid_colFunc, 0, scr_get_translation("help_label_search-word"));
ds_grid_set(functionHelp_helpGridSearch, functionHelp_helpGrid_colDesc, 0, scr_get_translation("help_description_search-word"));
ds_grid_set(functionHelp_helpGridSearch, functionHelp_helpGrid_colHide, 0, false);

ds_grid_set(functionHelp_helpGridSearch, functionHelp_helpGrid_colKey, 1, scr_get_translation("key_go-to-line"));
ds_grid_set(functionHelp_helpGridSearch, functionHelp_helpGrid_colFunc, 1, scr_get_translation("help_label_go-to-line"));
ds_grid_set(functionHelp_helpGridSearch, functionHelp_helpGrid_colDesc, 1, scr_get_translation("help_description_go-to-line"));
ds_grid_set(functionHelp_helpGridSearch, functionHelp_helpGrid_colHide, 1, false);

var helpGridHeightView = 9;
ds_grid_resize(functionHelp_helpGridView, functionHelp_helpGridWidth, helpGridHeightView);

ds_grid_set(functionHelp_helpGridView, functionHelp_helpGrid_colKey, 0, scr_get_translation("key_change-view"));
ds_grid_set(functionHelp_helpGridView, functionHelp_helpGrid_colFunc, 0, scr_get_translation("help_label_search"));
ds_grid_set(functionHelp_helpGridView, functionHelp_helpGrid_colDesc, 0, scr_get_translation("help_description_search"));
ds_grid_set(functionHelp_helpGridView, functionHelp_helpGrid_colHide, 0, false);

ds_grid_set(functionHelp_helpGridView, functionHelp_helpGrid_colKey, 1, scr_get_translation("key_justify"));
ds_grid_set(functionHelp_helpGridView, functionHelp_helpGrid_colFunc, 1, scr_get_translation("help_label_justify"));
ds_grid_set(functionHelp_helpGridView, functionHelp_helpGrid_colDesc, 1, scr_get_translation("help_description_justify"));
ds_grid_set(functionHelp_helpGridView, functionHelp_helpGrid_colHide, 1, false);

ds_grid_set(functionHelp_helpGridView, functionHelp_helpGrid_colKey, 2, scr_get_translation("key_word-format"));
ds_grid_set(functionHelp_helpGridView, functionHelp_helpGrid_colFunc, 2, scr_get_translation("help_label_transcript"));
ds_grid_set(functionHelp_helpGridView, functionHelp_helpGrid_colDesc, 2, scr_get_translation("help_description_word-format"));
ds_grid_set(functionHelp_helpGridView, functionHelp_helpGrid_colHide, 2, false);

ds_grid_set(functionHelp_helpGridView, functionHelp_helpGrid_colKey, 3, scr_get_translation("key_narrow-columns"));
ds_grid_set(functionHelp_helpGridView, functionHelp_helpGrid_colFunc, 3, scr_get_translation("help_description_decrease"));
ds_grid_set(functionHelp_helpGridView, functionHelp_helpGrid_colDesc, 3, scr_get_translation("help_label_columns-narrow"));
ds_grid_set(functionHelp_helpGridView, functionHelp_helpGrid_colHide, 3, false);

ds_grid_set(functionHelp_helpGridView, functionHelp_helpGrid_colKey, 4, scr_get_translation("key_wide-columns"));
ds_grid_set(functionHelp_helpGridView, functionHelp_helpGrid_colFunc, 4, scr_get_translation("help_description_increase"));
ds_grid_set(functionHelp_helpGridView, functionHelp_helpGrid_colDesc, 4, scr_get_translation("help_label_wide-columns"));
ds_grid_set(functionHelp_helpGridView, functionHelp_helpGrid_colHide, 4, false);

ds_grid_set(functionHelp_helpGridView, functionHelp_helpGrid_colKey, 5, scr_get_translation("key_low-rows"));
ds_grid_set(functionHelp_helpGridView, functionHelp_helpGrid_colFunc, 5, scr_get_translation("help_description_decrease-height"));
ds_grid_set(functionHelp_helpGridView, functionHelp_helpGrid_colDesc, 5, scr_get_translation("help_label_decrease_height"));
ds_grid_set(functionHelp_helpGridView, functionHelp_helpGrid_colHide, 5, false);

ds_grid_set(functionHelp_helpGridView, functionHelp_helpGrid_colKey, 6, scr_get_translation("key_tall-rows"));
ds_grid_set(functionHelp_helpGridView, functionHelp_helpGrid_colFunc, 6, scr_get_translation("help_description_increase_height"));
ds_grid_set(functionHelp_helpGridView, functionHelp_helpGrid_colDesc, 6, scr_get_translation("help_label_tall-rows"));
ds_grid_set(functionHelp_helpGridView, functionHelp_helpGrid_colHide, 6, false);

ds_grid_set(functionHelp_helpGridView, functionHelp_helpGrid_colKey, 7, scr_get_translation("key_theme"));
ds_grid_set(functionHelp_helpGridView, functionHelp_helpGrid_colFunc, 7, scr_get_translation("help_description_theme"));
ds_grid_set(functionHelp_helpGridView, functionHelp_helpGrid_colDesc, 7, scr_get_translation("help_label_theme"));
ds_grid_set(functionHelp_helpGridView, functionHelp_helpGrid_colHide, 7, false);

ds_grid_set(functionHelp_helpGridView, functionHelp_helpGrid_colKey, 8, scr_get_translation("key_navigation"));
ds_grid_set(functionHelp_helpGridView, functionHelp_helpGrid_colFunc, 8, scr_get_translation("help_description_nav-hide"));
ds_grid_set(functionHelp_helpGridView, functionHelp_helpGrid_colDesc, 8, scr_get_translation("help_label_navigation"));
ds_grid_set(functionHelp_helpGridView, functionHelp_helpGrid_colHide, 8, false);


var helpGridHeightFile = 3;
ds_grid_resize(functionHelp_helpGridFile, functionHelp_helpGridWidth, helpGridHeightFile);

ds_grid_set(functionHelp_helpGridFile, functionHelp_helpGrid_colKey, 0, controlStr + " o");
ds_grid_set(functionHelp_helpGridFile, functionHelp_helpGrid_colFunc, 0, "Open");
ds_grid_set(functionHelp_helpGridFile, functionHelp_helpGrid_colDesc, 0, "Open file or project");
ds_grid_set(functionHelp_helpGridFile, functionHelp_helpGrid_colHide, 0, true);

ds_grid_set(functionHelp_helpGridFile, functionHelp_helpGrid_colKey, 1, "CTRL s");
ds_grid_set(functionHelp_helpGridFile, functionHelp_helpGrid_colFunc, 1, "Save");
ds_grid_set(functionHelp_helpGridFile, functionHelp_helpGrid_colDesc, 1, "Save Rez file");
ds_grid_set(functionHelp_helpGridFile, functionHelp_helpGrid_colHide, 1, false);

ds_grid_set(functionHelp_helpGridFile, functionHelp_helpGrid_colKey, 2, "CTRL e");
ds_grid_set(functionHelp_helpGridFile, functionHelp_helpGrid_colFunc, 2, "Export Clip");
ds_grid_set(functionHelp_helpGridFile, functionHelp_helpGrid_colDesc, 2, "Specify start/end lines of Save");
ds_grid_set(functionHelp_helpGridFile, functionHelp_helpGrid_colHide, 2, false);

var helpGridHeightMove = 14;
ds_grid_resize(functionHelp_helpGridMove, functionHelp_helpGridWidth, helpGridHeightMove);

ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colKey, 0, "UP ARROW");
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colFunc, 0, "Up");
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colDesc, 0, "move up to previous line");
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colHide, 0, false);

ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colKey, 1, "DOWN ARROW");
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colFunc, 1, "Down");
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colDesc, 1, "move down to next line");
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colHide, 1, false);

ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colKey, 2, "LEFT ARROW");
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colFunc, 2, "Left");
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colDesc, 2, "move left");
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colHide, 2, false);

ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colKey, 3, "RIGHT ARROW");
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colFunc, 3, "Right");
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colDesc, 3, "move right");
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colHide, 3, false);

ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colKey, 4, "[HOME]");
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colFunc, 4, "Home");
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colDesc, 4, "Jump to beginning of current line");
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colHide, 4, false);

var correctKey = "";
if(os_type == os_macosx){
	correctKey = "Option";
}
else{
	correctKey = controlStr;
}

ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colKey, 5, "["+ correctKey + "] LEFT ARROW");
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colFunc, 5, "Home");
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colDesc, 5, "Jump to beginning of current line");
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colHide, 5, false);

ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colKey, 6, "[END]");
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colFunc, 6, "End");
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colDesc, 6, "Jump to end of current line");
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colHide, 6, false);

ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colKey, 7, "["+ correctKey + "] RIGHT ARROW");
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colFunc, 7, "End");
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colDesc, 7, "Jump to end of current line");
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colHide, 7, false);

ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colKey, 8, "[PAGEUP]");
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colFunc, 8, "PageUp");
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colDesc, 8, "scroll up one screen at a time");
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colHide, 8, false);

ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colKey, 9, "[PAGEDOWN]");
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colFunc, 9, "PageDown");
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colDesc, 9, "scroll down one screen at a time");
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colHide, 9, false);

ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colKey, 10, "["+ correctKey + "] UP ARROW");
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colFunc,10, "First");
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colDesc, 10, "Jump to first line of conversation");
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colHide, 10, false);

ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colKey, 11, "["+ correctKey + "] DOWN ARROW");
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colFunc, 11, "Last");
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colDesc, 11, "Jump to last line of conversation");
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colHide, 11, false);

ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colKey, 12, "[TAB]");
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colFunc, 12, "Next");
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colDesc, 12, "Move to next pane (Nav, Detail, Main)");
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colHide,12, true);

ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colKey, 13, "[SHIFT] [TAB]");
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colFunc, 13, "");
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colDesc, 13, "Move to next word/line in current chain");
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colHide, 13, true);


var helpGridHeightPlay = 3;
ds_grid_resize(functionHelp_helpGridPlay, functionHelp_helpGridWidth, helpGridHeightPlay);

ds_grid_set(functionHelp_helpGridPlay, functionHelp_helpGrid_colKey, 0, "[SPACEBAR]");
ds_grid_set(functionHelp_helpGridPlay, functionHelp_helpGrid_colFunc, 0, "Play");
ds_grid_set(functionHelp_helpGridPlay, functionHelp_helpGrid_colDesc, 0, "Play/Pause audio [toggle]");
ds_grid_set(functionHelp_helpGridPlay, functionHelp_helpGrid_colHide, 0, false);

ds_grid_set(functionHelp_helpGridPlay, functionHelp_helpGrid_colKey, 1, "CTRL [SPACEBAR]");
ds_grid_set(functionHelp_helpGridPlay, functionHelp_helpGrid_colFunc, 1, "Rez-Play");
ds_grid_set(functionHelp_helpGridPlay, functionHelp_helpGrid_colDesc, 1, "Play/Pause Rez-chains and audio [toggle]");
ds_grid_set(functionHelp_helpGridPlay, functionHelp_helpGrid_colHide, 1, false);

ds_grid_set(functionHelp_helpGridPlay, functionHelp_helpGrid_colKey, 2, "m");
ds_grid_set(functionHelp_helpGridPlay, functionHelp_helpGrid_colFunc, 2, "Mute");
ds_grid_set(functionHelp_helpGridPlay, functionHelp_helpGrid_colDesc, 2, "Mute audio [toggle]");
ds_grid_set(functionHelp_helpGridPlay, functionHelp_helpGrid_colHide, 2, false);

var helpGridHeightAdvanced = 4;
ds_grid_resize(functionHelp_helpGridAdvanced, functionHelp_helpGridWidth, helpGridHeightAdvanced);
var altOption = "";
if( os_type = os_macosx){
	altOption = "Option";
}
else{
	altOption = "Alt";
}

ds_grid_set(functionHelp_helpGridAdvanced, functionHelp_helpGrid_colKey, 0, "["+ altOption + "] [SHIFT] e");
ds_grid_set(functionHelp_helpGridAdvanced, functionHelp_helpGrid_colFunc, 0, "Shuffle/Reset Order");
ds_grid_set(functionHelp_helpGridAdvanced, functionHelp_helpGrid_colDesc, 0, "Toggle between shuffling lines and resetting order");
ds_grid_set(functionHelp_helpGridAdvanced, functionHelp_helpGrid_colHide, 0, false);

ds_grid_set(functionHelp_helpGridAdvanced, functionHelp_helpGrid_colKey, 1, "[Right Click] on speaker");
ds_grid_set(functionHelp_helpGridAdvanced, functionHelp_helpGrid_colFunc, 1, "Shuffle");
ds_grid_set(functionHelp_helpGridAdvanced, functionHelp_helpGrid_colDesc, 1, "Sort lines in random order");
ds_grid_set(functionHelp_helpGridAdvanced, functionHelp_helpGrid_colHide, 1, false);

ds_grid_set(functionHelp_helpGridAdvanced, functionHelp_helpGrid_colKey, 2, "[Right Click] on speaker");
ds_grid_set(functionHelp_helpGridAdvanced, functionHelp_helpGrid_colFunc, 2, "Reset Order");
ds_grid_set(functionHelp_helpGridAdvanced, functionHelp_helpGrid_colDesc, 2, "Resets the lines into their original order");
ds_grid_set(functionHelp_helpGridAdvanced, functionHelp_helpGrid_colHide, 2, false);

ds_grid_set(functionHelp_helpGridAdvanced, functionHelp_helpGrid_colKey, 3, "["+ altOption + "] [SHIFT] d");
ds_grid_set(functionHelp_helpGridAdvanced, functionHelp_helpGrid_colFunc, 3, "Developer");
ds_grid_set(functionHelp_helpGridAdvanced, functionHelp_helpGrid_colDesc, 3, "Turn on Developer view");
ds_grid_set(functionHelp_helpGridAdvanced, functionHelp_helpGrid_colHide, 3, false);
/*
ds_grid_set(functionHelp_helpGridAdvanced, functionHelp_helpGrid_colKey, 2, "["+ altOption + "] [SHIFT] u");
ds_grid_set(functionHelp_helpGridAdvanced, functionHelp_helpGrid_colFunc, 2, "User-word");
ds_grid_set(functionHelp_helpGridAdvanced, functionHelp_helpGrid_colDesc, 2, "Insert a new word");
ds_grid_set(functionHelp_helpGridAdvanced, functionHelp_helpGrid_colHide, 2, false);
*/
var helpGridHeightAbout = 2;
ds_grid_resize(functionHelp_helpGridAbout, functionHelp_helpGridWidth, helpGridHeightAbout);

ds_grid_set(functionHelp_helpGridAbout, functionHelp_helpGrid_colKey, 0, "xxx");
ds_grid_set(functionHelp_helpGridAbout, functionHelp_helpGrid_colFunc, 0, "Download");
ds_grid_set(functionHelp_helpGridAbout, functionHelp_helpGrid_colDesc, 0, "Download Rezonator");
ds_grid_set(functionHelp_helpGridAbout, functionHelp_helpGrid_colHide, 0, false);

ds_grid_set(functionHelp_helpGridAbout, functionHelp_helpGrid_colKey, 1, "xxx");
ds_grid_set(functionHelp_helpGridAbout, functionHelp_helpGrid_colFunc, 1, "About Us");
ds_grid_set(functionHelp_helpGridAbout, functionHelp_helpGrid_colDesc, 1, "Go to Rezonator.com for Info");
ds_grid_set(functionHelp_helpGridAbout, functionHelp_helpGrid_colHide, 1, false);



var helpGridHeightRightClick = 10;
ds_grid_resize(functionHelp_helpGridRightClick, functionHelp_helpGridWidth, helpGridHeightRightClick);

//ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colKey, 0, "[Right Click] on word");
//ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colFunc, 0, "Replace Word");
//ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colDesc, 0, "Change the display string of a word");
//ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colHide, 0, false);

//ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colKey, 1, "[Right Click] on word");
//ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colFunc, 1, "Restore Word");
//ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colDesc, 1, "Revert word back to its original string");
//ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colHide, 1, false);

ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colKey, 0, "[Right Click] on word");
ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colFunc, 0, "Split Word");
ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colDesc, 0, "Split selected word into two seperate words");
ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colHide, 0, false);

ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colKey, 1, "[Right Click] on word");
ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colFunc, 1, "New Word");
ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colDesc, 1, "Adds a new word before or after the selected word");
ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colHide, 1, false);

ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colKey, 2, "[Right Click] on word");
ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colFunc, 2, "Delete New Word");
ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colDesc, 2, "Delete a new word that has been added");
ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colHide, 2, false);

//ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colKey, 5, "[Right Click] on word");
//ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colFunc, 5, "Delete Link");
//ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colDesc, 5, "remove the selected word from it's chain");
//ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colHide, 5, false);

ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colKey, 3, "[Right Click] on speaker");
ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colFunc, 3, "Swap");
ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colDesc, 3, "Swap this line with another line");
ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colHide, 3, false);

ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colKey, 4, "[Right Click] on speaker");
ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colFunc, 4, "Shuffle");
ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colDesc, 4, "Sort lines in random order");
ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colHide, 4, false);

ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colKey, 5, "[Right Click] on speaker");
ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colFunc, 5, "Reset Order");
ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colDesc, 5, "Resets the lines into their original order");
ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colHide, 5, false);

//ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colKey, 9, "[Right Click] on speaker");
//ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colFunc, 9, "Tag");
//ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colDesc, 9, "Add a tag of emotion to the unit");
//ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colHide, 9, false);

ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colKey, 6, "[Right Click] on chain");
ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colFunc, 6, "Rename");
ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colDesc, 6, "Change the name of the selected chain");
ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colHide, 6, false);

ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colKey, 7, "[Right Click] on chain");
ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colFunc, 7, "recolor");
ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colDesc, 7, "Change the color of the selected chain");
ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colHide, 7, false);

ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colKey, 8, "[Right Click] on chain");
ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colFunc, 8, "Delete");
ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colDesc, 8, "Delete the selected chain");
ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colHide, 8, true);

ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colKey, 9, "[Right Click] on chain");
ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colFunc, 9, "Caption");
ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colDesc, 9, "Add a caption for stack shows");
ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colHide, 9, true);



var helpGridHeightRez = 21;
ds_grid_resize(functionHelp_helpGridRez, functionHelp_helpGridWidth, helpGridHeightRez);

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 0, "[CLICK]");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colFunc, 0, "Focus");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 0, "Focus a word (and add to chain)");

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 1, "[ESC], q");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colFunc, 1, "Quit");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 1, "Quit adding words to the current chain");

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 2, "[DEL]");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colFunc, 2, "Zap");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 2, "Remove a word from a chain");

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 3, "r");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colFunc, 3, "Rez");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 3, "Start a new Rez chain");

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 4, "t");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colFunc, 4, "Track");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 4, "Start a new Track chain");

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 5, "k");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colFunc, 5, "Stack");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 5, "Start a new Stack chain");

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 6, "c");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colFunc, 6, "Clique");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 6, "Move to Nav window Clique Tab");

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 7, "p");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colFunc, 7, "Pick");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 7, "Pick the currently focused element to add it to pickList [toggle]");

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 8, "v");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colFunc, 8, "View");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 8, "view main vs. grid vs. search [toggle]");

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 9, "j");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colFunc, 9, "Justify");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 9, "Justification/spacing of words [toggle]");

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 10, "w");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colFunc, 10, "Word-form");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 10, "Words vs. transcriptions displayed");

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 11, controlStr + "+p");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colFunc, 11, "Filter");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 11, "Show just the current picks");

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 12, controlStr + "+t");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colFunc, 12, "Align");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 12, "Align current Track");

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 13, controlStr + "+- [minus]");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colFunc, 13, "Zoom-out");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 13, "Smaller columns (more info)");

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 14, controlStr + "++ [plus]");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colFunc, 14, "Zoom-in");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 14, "Larger columns (less info)");

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 15, "SHIFT+- [minus]");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colFunc, 15, "Short");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 15, "Smaller line height (more info)");

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 16, "SHIFT++ [plus]");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colFunc, 16, "Tall");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 16, "Larger line height (less info)");

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 17, "f");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colFunc, 17, "Find");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 17, "Find all instances of a word");

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 18, "g");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colFunc, 18, "Go");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 18, "Go to user-specified line");

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 19, controlStr + "+o");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colFunc, 19, "Open");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 19, "Open file or project");

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 20, "CTRL s");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colFunc, 20, "Save");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 20, "Save file");





var helpGridHeightNav = 13;
ds_grid_resize(functionHelp_helpGridNav, functionHelp_helpGridWidth, helpGridHeightNav);

ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colKey, 0, "UP ARROW");
ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colFunc, 0, "Up");
ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colDesc, 0, "move up to previous line");

ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colKey, 1, "DOWN ARROW");
ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colFunc, 1, "Down");
ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colDesc, 1, "move down to next line");

ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colKey, 2, "LEFT ARROW");
ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colFunc, 2, "Left");
ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colDesc, 2, "move left");

ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colKey, 3, "RIGHT ARROW");
ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colFunc, 3, "Right");
ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colDesc, 3, "move right");

ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colKey, 4, "[HOME]");
ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colFunc, 4, "Home");
ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colDesc, 4, "Jump to beginning of current line");

ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colKey, 5, controlStr + "+LEFT ARROW");
ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colFunc, 5, "Home");
ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colDesc, 5, "Jump to beginning of current line");

ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colKey, 6, "[END]");
ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colFunc, 6, "End");
ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colDesc, 6, "Jump to end of current line");

ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colKey, 7, controlStr + "+RIGHT ARROW");
ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colFunc, 7, "End");
ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colDesc, 7, "Jump to end of current line");

ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colKey, 8, "[PAGEUP]");
ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colFunc, 8, "PageUp");
ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colDesc, 8, "scroll up one screen at a time");

ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colKey, 9, "[PAGEDOWN]");
ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colFunc, 9, "PageDown");
ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colDesc, 9, "scroll down one screen at a time");

ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colKey, 10, controlStr + "+UP ARROW");
ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colFunc,10, "First");
ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colDesc, 10, "Jump to first line of conversation");

ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colKey, 11, controlStr + "+DOWN ARROW");
ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colFunc, 11, "Last");
ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colDesc, 11, "Jump to last line of conversation");

ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colKey, 12, "[TAB]");
ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colFunc, 12, "Next");
ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colDesc, 12, "Move to next pane (Nav, Detail, Main)");
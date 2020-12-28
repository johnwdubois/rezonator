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

ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colName, 9, scr_get_translation("menu_about"));
ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colHide, 9, false);
ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colCollapsed, 9, true);
ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colGrid, 9, functionHelp_helpGridAbout);



//show_message(string(ds_grid_height(functionHelp_menuGrid)));

var helpGridHeightLink = 12;
ds_grid_resize(functionHelp_helpGridLink, functionHelp_helpGridWidth, helpGridHeightLink);

ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colKey, 0, scr_get_translation("key_word_click"));
ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colFunc, 0, scr_get_translation("help_label_link"));
ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colDesc, 0, scr_get_translation("help_description_link-word"));
ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colHide, 0, false);

ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colKey, 1, scr_get_translation("key_quit-chain"));
ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colFunc, 1, scr_get_translation("help_label_quit-chain"));
ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colDesc, 1, scr_get_translation("help_description_quit-chain"));
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
ds_grid_set(functionHelp_helpGridLink, functionHelp_helpGrid_colFunc, 6, scr_get_translation("menu_clique"));
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
ds_grid_set(functionHelp_helpGridSearch, functionHelp_helpGrid_colFunc, 0, scr_get_translation("help_label_search"));
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

ds_grid_set(functionHelp_helpGridFile, functionHelp_helpGrid_colKey, 0, controlStr + scr_get_translation("key_open"));
ds_grid_set(functionHelp_helpGridFile, functionHelp_helpGrid_colFunc, 0, scr_get_translation("help_label_open"));
ds_grid_set(functionHelp_helpGridFile, functionHelp_helpGrid_colDesc, 0, scr_get_translation("help_description_open-file"));
ds_grid_set(functionHelp_helpGridFile, functionHelp_helpGrid_colHide, 0, true);

ds_grid_set(functionHelp_helpGridFile, functionHelp_helpGrid_colKey, 1, scr_get_translation("key_save"));
ds_grid_set(functionHelp_helpGridFile, functionHelp_helpGrid_colFunc, 1, scr_get_translation("help_label_save"));
ds_grid_set(functionHelp_helpGridFile, functionHelp_helpGrid_colDesc, 1, scr_get_translation("help_description_save"));
ds_grid_set(functionHelp_helpGridFile, functionHelp_helpGrid_colHide, 1, false);

ds_grid_set(functionHelp_helpGridFile, functionHelp_helpGrid_colKey, 2, scr_get_translation("key_clip"));
ds_grid_set(functionHelp_helpGridFile, functionHelp_helpGrid_colFunc, 2, scr_get_translation("help_label_clip"));
ds_grid_set(functionHelp_helpGridFile, functionHelp_helpGrid_colDesc, 2, scr_get_translation("help_description_clip"));
ds_grid_set(functionHelp_helpGridFile, functionHelp_helpGrid_colHide, 2, false);

var helpGridHeightMove = 14;
ds_grid_resize(functionHelp_helpGridMove, functionHelp_helpGridWidth, helpGridHeightMove);

ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colKey, 0, scr_get_translation("key_move-up"));
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colFunc, 0, scr_get_translation("help_label_move-up"));
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colDesc, 0, scr_get_translation("help_description_move-up"));
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colHide, 0, false);

ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colKey, 1, scr_get_translation("key_move-down"));
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colFunc, 1, scr_get_translation("help_label_down"));
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colDesc, 1, scr_get_translation("help_description_move-down"));
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colHide, 1, false);

ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colKey, 2, scr_get_translation("key_move-left"));
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colFunc, 2, scr_get_translation("help_label_move-left"));
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colDesc, 2, scr_get_translation("help_description_move-left"));
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colHide, 2, false);

ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colKey, 3, scr_get_translation("key_move-right"));
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colFunc, 3, scr_get_translation("help_label_move-right"));
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colDesc, 3, scr_get_translation("help_description_move-right"));
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colHide, 3, false);

ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colKey, 4, scr_get_translation("key_home"));
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colFunc, 4, scr_get_translation("help_label_home"));
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colDesc, 4, scr_get_translation("help_description_home"));
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colHide, 4, false);

var correctKey = "";
if(os_type == os_macosx){
	correctKey = "Option";
}
else{
	correctKey = controlStr;
}

ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colKey, 5, "["+ correctKey + scr_get_translation("key_home_alt"));
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colFunc, 5, scr_get_translation("help_label_home"));
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colDesc, 5, scr_get_translation("help_description_home"));
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colHide, 5, false);

ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colKey, 6, scr_get_translation("key_end-of-line"));
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colFunc, 6, scr_get_translation("help_label_end"));
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colDesc, 6,scr_get_translation("help_description_end-of-line"));
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colHide, 6, false);

ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colKey, 7, "["+ correctKey + scr_get_translation("key_end-of-line_alt"));
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colFunc, 7, scr_get_translation("help_label_end"));
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colDesc, 7, scr_get_translation("help_description_end-of-line"));
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colHide, 7, false);

ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colKey, 8, scr_get_translation("key_pageup"));
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colFunc, 8, scr_get_translation("help_label_pageup"));
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colDesc, 8, scr_get_translation("help_description_pageup"));
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colHide, 8, false);

ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colKey, 9, scr_get_translation("key_pagedown"));
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colFunc, 9, scr_get_translation("help_label_pagedown"));
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colDesc, 9, scr_get_translation("help_description_pagedown"));
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colHide, 9, false);

ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colKey, 10, "["+ correctKey + scr_get_translation("key_start-of-file"));
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colFunc,10, scr_get_translation("help_label_first-line"));
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colDesc, 10, scr_get_translation("help_description_go-first-line"));
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colHide, 10, false);

ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colKey, 11, "["+ correctKey + scr_get_translation("key_end-of-file"));
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colFunc, 11, scr_get_translation("help_label_end-of-file"));
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colDesc, 11, scr_get_translation("help_description_end-of-file"));
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colHide, 11, false);

ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colKey, 12, scr_get_translation("key_next-pane"));
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colFunc, 12, scr_get_translation("help_label_next"));
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colDesc, 12, scr_get_translation("help_description_next-pane"));
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colHide,12, true);

ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colKey, 13, scr_get_translation("key_change-view-reverse"));
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colFunc, 13, scr_get_translation("help_label_view-reverse"));
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colDesc, 13, scr_get_translation("help_description_Next-link"));
ds_grid_set(functionHelp_helpGridMove, functionHelp_helpGrid_colHide, 13, true);


var helpGridHeightPlay = 3;
ds_grid_resize(functionHelp_helpGridPlay, functionHelp_helpGridWidth, helpGridHeightPlay);

ds_grid_set(functionHelp_helpGridPlay, functionHelp_helpGrid_colKey, 0, scr_get_translation("key_playAudio"));
ds_grid_set(functionHelp_helpGridPlay, functionHelp_helpGrid_colFunc, 0, scr_get_translation("help_label_play"));
ds_grid_set(functionHelp_helpGridPlay, functionHelp_helpGrid_colDesc, 0, scr_get_translation("help_description_playaudio"));
ds_grid_set(functionHelp_helpGridPlay, functionHelp_helpGrid_colHide, 0, false);

ds_grid_set(functionHelp_helpGridPlay, functionHelp_helpGrid_colKey, 1, scr_get_translation("key_syncplay"));
ds_grid_set(functionHelp_helpGridPlay, functionHelp_helpGrid_colFunc, 1, scr_get_translation("help_label_syncplay"));
ds_grid_set(functionHelp_helpGridPlay, functionHelp_helpGrid_colDesc, 1, scr_get_translation("help_description_syncplay"));
ds_grid_set(functionHelp_helpGridPlay, functionHelp_helpGrid_colHide, 1, false);

ds_grid_set(functionHelp_helpGridPlay, functionHelp_helpGrid_colKey, 2, scr_get_translation("key_mute"));
ds_grid_set(functionHelp_helpGridPlay, functionHelp_helpGrid_colFunc, 2, scr_get_translation("help_label_mute"));
ds_grid_set(functionHelp_helpGridPlay, functionHelp_helpGrid_colDesc, 2, scr_get_translation("help_description_mute"));
ds_grid_set(functionHelp_helpGridPlay, functionHelp_helpGrid_colHide, 2, false);

var helpGridHeightAdvanced = 3;
ds_grid_resize(functionHelp_helpGridAdvanced, functionHelp_helpGridWidth, helpGridHeightAdvanced);
var altOption = "";
if( os_type = os_macosx){
	altOption = "Option";
}
else{
	altOption = "Alt";
}

//hardcoded need translation 
ds_grid_set(functionHelp_helpGridAdvanced, functionHelp_helpGrid_colKey, 0, "["+ correctKey + "] R");
ds_grid_set(functionHelp_helpGridAdvanced, functionHelp_helpGrid_colFunc, 0, scr_get_translation("help_label_shuffle"));
ds_grid_set(functionHelp_helpGridAdvanced, functionHelp_helpGrid_colDesc, 0, scr_get_translation("help_description_shuffle"));
ds_grid_set(functionHelp_helpGridAdvanced, functionHelp_helpGrid_colHide, 0, false);

ds_grid_set(functionHelp_helpGridAdvanced, functionHelp_helpGrid_colKey, 1, "["+ correctKey + "] G");
ds_grid_set(functionHelp_helpGridAdvanced, functionHelp_helpGrid_colFunc, 1, scr_get_translation("Grid View"));
ds_grid_set(functionHelp_helpGridAdvanced, functionHelp_helpGrid_colDesc, 1, scr_get_translation("Toggle Grid Viewer"));
ds_grid_set(functionHelp_helpGridAdvanced, functionHelp_helpGrid_colHide, 1, false);

ds_grid_set(functionHelp_helpGridAdvanced, functionHelp_helpGrid_colKey, 2, "["+ altOption + "]" + " [Shift] D");
ds_grid_set(functionHelp_helpGridAdvanced, functionHelp_helpGrid_colFunc, 2, scr_get_translation("help_label_developer"));
ds_grid_set(functionHelp_helpGridAdvanced, functionHelp_helpGrid_colDesc, 2, scr_get_translation("help_description_developer-view"));
ds_grid_set(functionHelp_helpGridAdvanced, functionHelp_helpGrid_colHide, 2, false);
/*
ds_grid_set(functionHelp_helpGridAdvanced, functionHelp_helpGrid_colKey, 2, "["+ altOption + "] [SHIFT] u");
ds_grid_set(functionHelp_helpGridAdvanced, functionHelp_helpGrid_colFunc, 2, scr_get_translation("help_label_insert-word"));
ds_grid_set(functionHelp_helpGridAdvanced, functionHelp_helpGrid_colDesc, 2, scr_get_translation("help_description_insert-word"));
ds_grid_set(functionHelp_helpGridAdvanced, functionHelp_helpGrid_colHide, 2, false);
*/
var helpGridHeightAbout = 2;
ds_grid_resize(functionHelp_helpGridAbout, functionHelp_helpGridWidth, helpGridHeightAbout);

ds_grid_set(functionHelp_helpGridAbout, functionHelp_helpGrid_colKey, 0, "xxx");
ds_grid_set(functionHelp_helpGridAbout, functionHelp_helpGrid_colFunc, 0, scr_get_translation("help_label_download"));
ds_grid_set(functionHelp_helpGridAbout, functionHelp_helpGrid_colDesc, 0, scr_get_translation("help_description_download"));
ds_grid_set(functionHelp_helpGridAbout, functionHelp_helpGrid_colHide, 0, false);

ds_grid_set(functionHelp_helpGridAbout, functionHelp_helpGrid_colKey, 1, "xxx");
ds_grid_set(functionHelp_helpGridAbout, functionHelp_helpGrid_colFunc, 1, scr_get_translation("help_label_about"));
ds_grid_set(functionHelp_helpGridAbout, functionHelp_helpGrid_colDesc, 1, scr_get_translation("help_description_rezonator-dot-com"));
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

ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colKey, 0, scr_get_translation("key_replace"));
ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colFunc, 0, scr_get_translation("help_label_split-word"));
ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colDesc, 0, scr_get_translation("help_description_split"));
ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colHide, 0, false);

ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colKey, 1, scr_get_translation("key_replace"));
ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colFunc, 1, scr_get_translation("help_label_new_word"));
ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colDesc, 1, scr_get_translation("help_description_insert-word"));
ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colHide, 1, false);

ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colKey, 2, scr_get_translation("key_replace"));
ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colFunc, 2, scr_get_translation("help_label_delete-inserted-word"));
ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colDesc, 2, scr_get_translation("help_description_delete-new-word"));
ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colHide, 2, false);

//ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colKey, 5, "[Right Click] on word");
//ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colFunc, 5, "Delete Link");
//ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colDesc, 5, "remove the selected word from it's chain");
//ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colHide, 5, false);

ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colKey, 3, scr_get_translation("key_rightclick_speaker"));
ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colFunc, 3, scr_get_translation("help_label_swap-lines"));
ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colDesc, 3, scr_get_translation("help_description_swap-lines"));
ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colHide, 3, false);

ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colKey, 4, scr_get_translation("key_rightclick_speaker"));
ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colFunc, 4, scr_get_translation("help_label_shuffle"));
ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colDesc, 4, scr_get_translation("help_description_shuffle"));
ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colHide, 4, false);

ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colKey, 5, scr_get_translation("key_rightclick_speaker"));
ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colFunc, 5, scr_get_translation("help_label_restore-sequence"));
ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colDesc, 5, scr_get_translation("help_description_restore-sequence"));
ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colHide, 5, false);

//ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colKey, 9, "[Right Click] on speaker");
//ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colFunc, 9, "Tag");
//ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colDesc, 9, "Add a tag of emotion to the unit");
//ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colHide, 9, false);

ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colKey, 6, scr_get_translation("key_chain_context-menu"));
ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colFunc, 6, scr_get_translation("help_label_rename"));
ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colDesc, 6, scr_get_translation("help_description_rename"));
ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colHide, 6, false);

ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colKey, 7, scr_get_translation("key_chain_context-menu"));
ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colFunc, 7, scr_get_translation("help_label_color"));
ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colDesc, 7, scr_get_translation("help_description_color"));
ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colHide, 7, false);

ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colKey, 8, scr_get_translation("key_chain_context-menu"));
ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colFunc, 8, scr_get_translation("help_label_delete_plain"));
ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colDesc, 8, scr_get_translation("help_description_delete-plain"));
ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colHide, 8, true);

ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colKey, 9, scr_get_translation("key_chain_context-menu"));
ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colFunc, 9, scr_get_translation("help_label_caption"));
ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colDesc, 9, scr_get_translation("help_description_caption"));
ds_grid_set(functionHelp_helpGridRightClick, functionHelp_helpGrid_colHide, 9, true);



var helpGridHeightRez = 21;
ds_grid_resize(functionHelp_helpGridRez, functionHelp_helpGridWidth, helpGridHeightRez);

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 0, scr_get_translation("key_focus"));
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colFunc, 0, scr_get_translation("help_label_focus"));
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 0, scr_get_translation("help_description_focus"));

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 1, scr_get_translation("key_quit-chain"));
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colFunc, 1, scr_get_translation("help_label_quit"));
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 1, scr_get_translation("help_description_quit-chain"));

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 2, scr_get_translation("key_delete_link"));
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colFunc, 2, scr_get_translation("help_label_zap"));
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 2, scr_get_translation("help_description_zap"));

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 3, scr_get_translation("key_rez"));
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colFunc, 3, scr_get_translation("help_label_rez"));
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 3, scr_get_translation("help_description_rez"));

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 4, scr_get_translation("key_track"));
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colFunc, 4, scr_get_translation("help_label_track"));
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 4, scr_get_translation("help_description_track2"));

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 5, scr_get_translation("key_stack"));
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colFunc, 5, scr_get_translation("help_label_stack"));
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 5, scr_get_translation("help_description_stack_2"));

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 6, scr_get_translation("key_clique"));
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colFunc, 6, scr_get_translation("menu_clique"));
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 6, scr_get_translation("help_description_clique-tab2"));

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 7, scr_get_translation("key_pick"));
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colFunc, 7, scr_get_translation("help_label_pick"));
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 7, scr_get_translation("help_description_pick-chain"));

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 8, scr_get_translation("key_change-view"));
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colFunc, 8, scr_get_translation("help_label_view-select"));
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 8, scr_get_translation("help_description_view-select"));

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 9, scr_get_translation("key_justify"));
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colFunc, 9, scr_get_translation("help_label_justify"));
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 9, scr_get_translation("help_description_justify"));

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 10, scr_get_translation("key_word-format"));
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colFunc, 10, scr_get_translation("help_label_word-format2"));
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 10, scr_get_translation("help_description_word-format2"));

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 11, controlStr + "+p");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colFunc, 11, scr_get_translation("help_label_filter"));
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 11, scr_get_translation("help_description_filter"));

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 12, controlStr + "+t");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colFunc, 12, scr_get_translation("help_label_align"));
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 12, scr_get_translation("help_description_align"));

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 13, controlStr + "+- [minus]");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colFunc, 13, scr_get_translation("help_label_zoom-out"));
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 13, scr_get_translation("help_description_columns-narrow"));

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 14, controlStr + "++ [plus]");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colFunc, 14, scr_get_translation("help_label_zoom-in"));
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 14, scr_get_translation("help_description_columns-wide"));

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 15, "SHIFT+- [minus]");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colFunc, 15, scr_get_translation("help_label_short"));
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 15, scr_get_translation("help_description_line-height-decrease"));

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 16, "SHIFT++ [plus]");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colFunc, 16, scr_get_translation("help_label_tall-rows"));
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 16, scr_get_translation("help_description_tall"));

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 17, scr_get_translation("key_search"));
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colFunc, 17, scr_get_translation("help_label_find"));
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 17, scr_get_translation("help_description_find-all"));

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 18, scr_get_translation("key_go-to-line"));
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colFunc, 18, scr_get_translation("help_label_go-to-line"));
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 18, scr_get_translation("help_description_go-to-line"));

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 19, controlStr + "+o");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colFunc, 19, scr_get_translation("help_label_open"));
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 19, scr_get_translation("help_description_open-file"));

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 20, scr_get_translation("key_save"));
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colFunc, 20, scr_get_translation("help_label_save"));
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 20, scr_get_translation("help_description_save"));





var helpGridHeightNav = 13;
ds_grid_resize(functionHelp_helpGridNav, functionHelp_helpGridWidth, helpGridHeightNav);

ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colKey, 0,scr_get_translation("key_move-up"));
ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colFunc, 0, scr_get_translation("help_label_move-up"));
ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colDesc, 0, scr_get_translation("help_description_move-up"));

ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colKey, 1, scr_get_translation("key_move-down"));
ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colFunc, 1, scr_get_translation("help_label_down"));
ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colDesc, 1, scr_get_translation("help_description_move-down"));

ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colKey, 2, scr_get_translation("key_move-left"));
ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colFunc, 2, scr_get_translation("help_label_move-left"));
ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colDesc, 2, scr_get_translation("help_description_move-left"));

ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colKey, 3, scr_get_translation("key_move-right"));
ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colFunc, 3, scr_get_translation("help_label_move-right"));
ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colDesc, 3, scr_get_translation("help_description_move-right"));

ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colKey, 4, scr_get_translation("key_home"));
ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colFunc, 4, scr_get_translation("help_label_home"));
ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colDesc, 4, scr_get_translation("help_description_home"));

ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colKey, 5, controlStr + scr_get_translation("key_home_alt"));
ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colFunc, 5, scr_get_translation("help_label_home"));
ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colDesc, 5, scr_get_translation("help_description_home"));

ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colKey, 6, scr_get_translation("key_end-of-line"));
ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colFunc, 6, scr_get_translation("help_label_end"));
ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colDesc, 6, scr_get_translation("help_description_end-of-line"));

ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colKey, 7, controlStr + scr_get_translation("key_end-of-line_alt"));
ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colFunc, 7, scr_get_translation("help_label_end"));
ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colDesc, 7, scr_get_translation("help_description_end-of-line"));

ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colKey, 8, scr_get_translation("key_pageup"));
ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colFunc, 8, scr_get_translation("help_label_pageup"));
ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colDesc, 8, scr_get_translation("help_description_pageup"));

ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colKey, 9, scr_get_translation("key_pagedown"));
ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colFunc, 9, scr_get_translation("help_label_pagedown"));
ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colDesc, 9, scr_get_translation("help_description_pagedown"));

ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colKey, 10, controlStr + scr_get_translation("key_start-of-file"));
ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colFunc,10, scr_get_translation("help_label_first-line"));
ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colDesc, 10, scr_get_translation("help_description_go-first-line"));

ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colKey, 11, controlStr + scr_get_translation("key_end-of-file"));
ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colFunc, 11, scr_get_translation("help_label_end-of-file"));
ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colDesc, 11, scr_get_translation("help_description_end-of-file"));

ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colKey, 12, scr_get_translation("key_next-pane"));
ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colFunc, 12, scr_get_translation("help_label_next"));
ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colDesc, 12, scr_get_translation("help_description_next-pane"));
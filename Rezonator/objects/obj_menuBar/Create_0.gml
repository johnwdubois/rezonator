
/// @description Insert description here
// You can write your code in this editor
//fuck it, gonna make a grid 
menuBarGridHeight = 7;
menuBarGridWidth = 4;
menuBarGrid = ds_grid_create(menuBarGridWidth, menuBarGridHeight);


menuBarGrid_colString = 0
menuBarGrid_colMouseOver = 1;
menuBarGrid_colOptionList = 2;
menuBarGrid_colOptionListType = 3;



menuBarGrid_rowFile = 0;
menuBarGrid_rowEdit = 1;
menuBarGrid_rowView = 2;
menuBarGrid_rowFilter = 3;
menuBarGrid_rowTools = 4;
menuBarGrid_rowSettings = 5;
menuBarGrid_rowHelp = 6;





fileOptionList = ds_list_create();
ds_list_add(fileOptionList, "menu_save", 
							"menu_save-as",
							"help_label_open",
							"menu_media", 
							"menu_export",
							"menu_import", 
							"menu_exit");


editOptionList = ds_list_create();
ds_list_add(editOptionList, "menu_delete-all",
							"menu_go-to-line",
							"menu_go-to-time");

viewOptionList = ds_list_create();
ds_list_add(viewOptionList, "menu_window", 
							"menu_justify",
							"menu_prose",
							"menu_hide",
							"word_tip",
							"tab_name_chunk",
							"arrheads",
							"text_dir");

filterOptionList = ds_list_create();
ds_list_add(filterOptionList, "menu_filter",
								"menu_pick", 
								"menu_filter-context",
								"menu_clear");



toolsOptionList = ds_list_create();
ds_list_add(toolsOptionList,"menu_search", 
							"menu_track",
							"menu_resonance",
							"help_label_tag",
							"menu_stacker");

settingsOptionList = ds_list_create();
ds_list_add(settingsOptionList, "menu_user", 
								"menu_zoom",
								"menu_theme",  
								"menu_language", 
								"menu_autosave", 
								"menu_advanced"); // "Delete All","Autosave");

helpOptionList = ds_list_create();
ds_list_add(helpOptionList, "menu_help",
							"menu_guide",
							"menu_about");


ds_grid_set(menuBarGrid, menuBarGrid_colString, menuBarGrid_rowFile, "menu_file");
ds_grid_set(menuBarGrid, menuBarGrid_colMouseOver, menuBarGrid_rowFile, false);
ds_grid_set(menuBarGrid, menuBarGrid_colOptionList, menuBarGrid_rowFile, fileOptionList);
ds_grid_set(menuBarGrid, menuBarGrid_colOptionListType, menuBarGrid_rowFile, global.optionListTypeFile);

ds_grid_set(menuBarGrid, menuBarGrid_colString, menuBarGrid_rowEdit, "menu_edit");
ds_grid_set(menuBarGrid, menuBarGrid_colMouseOver, menuBarGrid_rowEdit, false);
ds_grid_set(menuBarGrid, menuBarGrid_colOptionList, menuBarGrid_rowEdit, editOptionList);
ds_grid_set(menuBarGrid, menuBarGrid_colOptionListType, menuBarGrid_rowEdit, global.optionListTypeEdit);

ds_grid_set(menuBarGrid, menuBarGrid_colString, menuBarGrid_rowView, "menu_view");
ds_grid_set(menuBarGrid, menuBarGrid_colMouseOver, menuBarGrid_rowView, false);
ds_grid_set(menuBarGrid, menuBarGrid_colOptionList, menuBarGrid_rowView, viewOptionList);
ds_grid_set(menuBarGrid, menuBarGrid_colOptionListType, menuBarGrid_rowView, global.optionListTypeView);

ds_grid_set(menuBarGrid, menuBarGrid_colString, menuBarGrid_rowFilter, "menu_filter");
ds_grid_set(menuBarGrid, menuBarGrid_colMouseOver, menuBarGrid_rowFilter, false);
ds_grid_set(menuBarGrid, menuBarGrid_colOptionList, menuBarGrid_rowFilter, filterOptionList);
ds_grid_set(menuBarGrid, menuBarGrid_colOptionListType, menuBarGrid_rowFilter, global.optionListTypeFilter);

ds_grid_set(menuBarGrid, menuBarGrid_colString, menuBarGrid_rowTools, "menu_tools");
ds_grid_set(menuBarGrid, menuBarGrid_colMouseOver, menuBarGrid_rowTools, false);
ds_grid_set(menuBarGrid, menuBarGrid_colOptionList, menuBarGrid_rowTools, toolsOptionList);
ds_grid_set(menuBarGrid, menuBarGrid_colOptionListType, menuBarGrid_rowTools, global.optionListTypeTools);

ds_grid_set(menuBarGrid, menuBarGrid_colString, menuBarGrid_rowSettings, "menu_settings");
ds_grid_set(menuBarGrid, menuBarGrid_colMouseOver, menuBarGrid_rowSettings, false);
ds_grid_set(menuBarGrid, menuBarGrid_colOptionList, menuBarGrid_rowSettings, settingsOptionList);
ds_grid_set(menuBarGrid, menuBarGrid_colOptionListType, menuBarGrid_rowSettings, global.optionListTypeSettings);

ds_grid_set(menuBarGrid, menuBarGrid_colString, menuBarGrid_rowHelp, "menu_help");
ds_grid_set(menuBarGrid, menuBarGrid_colMouseOver, menuBarGrid_rowHelp, false);
ds_grid_set(menuBarGrid, menuBarGrid_colOptionList, menuBarGrid_rowHelp, helpOptionList);
ds_grid_set(menuBarGrid, menuBarGrid_colOptionListType, menuBarGrid_rowHelp, global.optionListTypeHelp);



 
menuHeight = 30;
menuWidth = 90;
menuClickedIn = false;
y = 0;

sortPaneOpen = false;
sortClosing = false;
sortPane = -1;
chainDeselected = false;

mouseoverMenuBar = false;

saveTextAlpha = 1;
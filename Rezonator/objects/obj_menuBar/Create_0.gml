
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
//menuBarGrid_rowLink = 1;
//menuBarGrid_rowEdit = 2;
//menuBarGrid_rowTools = 3;
//menuBarGrid_rowSettings = 5;
menuBarGrid_rowEdit = 1;
menuBarGrid_rowView = 2;
menuBarGrid_rowFilter = 3;
menuBarGrid_rowTools = 4;
menuBarGrid_rowSettings = 5;
menuBarGrid_rowHelp = 6;




fileDropDownOptionListType = 4; // optionListTypeFile = 4;
editDropDownOptionListType = 42; // optionListTypeEdit = 42;
viewDropDownOptionListType = 6; // optionListTypeView = 6;
toolsDropDownOptionListType = 22; //optionListTypeTools = 22;
settingsDropDownOptionListType = 21; // optionListTypeSettings = 21;
filterDropDownOptionListType = 33; // optionListTypeFilter = 33;
helpDropDownOptionListType = 23; // optionListTypeHelp = 23;



fileOptionList = ds_list_create();
ds_list_add(fileOptionList, scr_get_translation("menu_save"), 
							"Save As",
							scr_get_translation("menu_media"), 
							scr_get_translation("menu_clip"), 
							scr_get_translation("menu_export"),
							scr_get_translation("menu_import"), 
							scr_get_translation("menu_exit"));

/*linkOptionList = ds_list_create();
ds_list_add(linkOptionList, scr_get_translation("menu_track),
							scr_get_translation("menu_rez),
							scr_get_translation("menu_stack),
							"Quick",
							scr_get_translation("menu_clique),
							scr_get_translation("help_label_focus),
							scr_get_translation("help_label_zap),
							scr_get_translation("help_label_quit));

editOptionList = ds_list_create();
ds_list_add(editOptionList, "Insert", "Paste", "Delete", "Edit", "Split", "Restore", "Chunk", "Tag");*/

editOptionList = ds_list_create();
ds_list_add(editOptionList, "Delete All",
							scr_get_translation("menu_goToLine"),
							scr_get_translation("menu_goToTime"));

viewOptionList = ds_list_create();
ds_list_add(viewOptionList, "Window", 
							scr_get_translation("menu_justify"),
							scr_get_translation("menu_prose"),
							scr_get_translation("menu_hide"));//"Word", "Justify", "Prose", "Hide", "Zoom", "Dark Theme");

filterOptionList = ds_list_create();
ds_list_add(filterOptionList, scr_get_translation("menu_filter"),
								scr_get_translation("menu_pick"), 
								scr_get_translation("menu_filter-context"),
								"Clear");

//toolsOptionList = ds_list_create();
//ds_list_add(toolsOptionList, "Sort", "StackShow", "Play", "Rez-Play");

toolsOptionList = ds_list_create();
ds_list_add(toolsOptionList, scr_get_translation("menu_search"), 
							scr_get_translation("menu_track"),
							scr_get_translation("menu_rez"),
							scr_get_translation("menu_stack"), "Play and Learn");

settingsOptionList = ds_list_create();
ds_list_add(settingsOptionList, scr_get_translation("menu_user"), 
								scr_get_translation("menu_zoom"),
								"Zero", 
								scr_get_translation("menu_theme"), "Restore Hints", "Autosave", "Advanced"); // "Delete All","Autosave");

//settingsOptionList = ds_list_create();
//ds_list_add(settingsOptionList, "Zoom", "Dark Theme", "Mute", "Author");

helpOptionList = ds_list_create();
ds_list_add(helpOptionList, scr_get_translation("menu_help"),
							scr_get_translation("menu_docs"),
							scr_get_translation("menu_about"));




//"File", "Link", "Edit", "View", "Search", "Tools", "Advanced", "Setting", "Help"
ds_grid_set(menuBarGrid, menuBarGrid_colString, menuBarGrid_rowFile, scr_get_translation("menu_file"));
ds_grid_set(menuBarGrid, menuBarGrid_colMouseOver, menuBarGrid_rowFile, false);
ds_grid_set(menuBarGrid, menuBarGrid_colOptionList, menuBarGrid_rowFile, fileOptionList);
ds_grid_set(menuBarGrid, menuBarGrid_colOptionListType, menuBarGrid_rowFile, fileDropDownOptionListType);

/*ds_grid_set(menuBarGrid, menuBarGrid_colString, menuBarGrid_rowLink, "Link");
ds_grid_set(menuBarGrid, menuBarGrid_colMouseOver, menuBarGrid_rowLink, false);
ds_grid_set(menuBarGrid, menuBarGrid_colOptionList, menuBarGrid_rowLink, linkOptionList);
ds_grid_set(menuBarGrid, menuBarGrid_colOptionListType, menuBarGrid_rowLink, linkDropDownOptionListType);

ds_grid_set(menuBarGrid, menuBarGrid_colString, menuBarGrid_rowEdit, "Edit");
ds_grid_set(menuBarGrid, menuBarGrid_colMouseOver, menuBarGrid_rowEdit, false);
ds_grid_set(menuBarGrid, menuBarGrid_colOptionList, menuBarGrid_rowEdit, editOptionList);
ds_grid_set(menuBarGrid, menuBarGrid_colOptionListType, menuBarGrid_rowEdit, editDropDownOptionListType);*/

ds_grid_set(menuBarGrid, menuBarGrid_colString, menuBarGrid_rowEdit, scr_get_translation("menu_edit"));
ds_grid_set(menuBarGrid, menuBarGrid_colMouseOver, menuBarGrid_rowEdit, false);
ds_grid_set(menuBarGrid, menuBarGrid_colOptionList, menuBarGrid_rowEdit, editOptionList);
ds_grid_set(menuBarGrid, menuBarGrid_colOptionListType, menuBarGrid_rowEdit, editDropDownOptionListType);

ds_grid_set(menuBarGrid, menuBarGrid_colString, menuBarGrid_rowView, scr_get_translation("menu_view"));
ds_grid_set(menuBarGrid, menuBarGrid_colMouseOver, menuBarGrid_rowView, false);
ds_grid_set(menuBarGrid, menuBarGrid_colOptionList, menuBarGrid_rowView, viewOptionList);
ds_grid_set(menuBarGrid, menuBarGrid_colOptionListType, menuBarGrid_rowView, viewDropDownOptionListType);

ds_grid_set(menuBarGrid, menuBarGrid_colString, menuBarGrid_rowFilter, scr_get_translation("menu_filter"));
ds_grid_set(menuBarGrid, menuBarGrid_colMouseOver, menuBarGrid_rowFilter, false);
ds_grid_set(menuBarGrid, menuBarGrid_colOptionList, menuBarGrid_rowFilter, filterOptionList);
ds_grid_set(menuBarGrid, menuBarGrid_colOptionListType, menuBarGrid_rowFilter, filterDropDownOptionListType);

ds_grid_set(menuBarGrid, menuBarGrid_colString, menuBarGrid_rowTools, "Tools");
ds_grid_set(menuBarGrid, menuBarGrid_colMouseOver, menuBarGrid_rowTools, false);
ds_grid_set(menuBarGrid, menuBarGrid_colOptionList, menuBarGrid_rowTools, toolsOptionList);
ds_grid_set(menuBarGrid, menuBarGrid_colOptionListType, menuBarGrid_rowTools, toolsDropDownOptionListType);

ds_grid_set(menuBarGrid, menuBarGrid_colString, menuBarGrid_rowSettings, "Settings");
ds_grid_set(menuBarGrid, menuBarGrid_colMouseOver, menuBarGrid_rowSettings, false);
ds_grid_set(menuBarGrid, menuBarGrid_colOptionList, menuBarGrid_rowSettings, settingsOptionList);
ds_grid_set(menuBarGrid, menuBarGrid_colOptionListType, menuBarGrid_rowSettings, settingsDropDownOptionListType);

//ds_grid_set(menuBarGrid, menuBarGrid_colString, menuBarGrid_rowSettings, "Settings");
//ds_grid_set(menuBarGrid, menuBarGrid_colMouseOver, menuBarGrid_rowSettings, false);
//ds_grid_set(menuBarGrid, menuBarGrid_colOptionList, menuBarGrid_rowSettings, settingsOptionList);
//ds_grid_set(menuBarGrid, menuBarGrid_colOptionListType, menuBarGrid_rowSettings, settingsDropDownOptionListType);

ds_grid_set(menuBarGrid, menuBarGrid_colString, menuBarGrid_rowHelp, scr_get_translation("menu_help"));
ds_grid_set(menuBarGrid, menuBarGrid_colMouseOver, menuBarGrid_rowHelp, false);
ds_grid_set(menuBarGrid, menuBarGrid_colOptionList, menuBarGrid_rowHelp, helpOptionList);
ds_grid_set(menuBarGrid, menuBarGrid_colOptionListType, menuBarGrid_rowHelp, helpDropDownOptionListType);



 
menuHeight = 30;
menuWidth = 90;
menuClickedIn = false;
/*mouseOverFile = false;
mouseOverEdit = false;
mouseOverView = false;
mouseOverSearch = false;
mouseOverOptions = false;
mouseOverStackShow = false;
mouseOverSortPane = false;*/
y= 0;

sortPaneOpen = false;
sortClosing = false;
sortPane = -1;
chainDeselected = false;
/*menuList = ds_list_create();
ds_list_add(menuList, "File", "Link", "Edit", "View", "Search", "Tools", "Advanced", "Setting", "Help");
menuListSize = ds_list_size(menuList);*/
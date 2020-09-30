//if (live_call()) return live_result;
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




fileDropDownOptionListType = 4;
editDropDownOptionListType = 42;
viewDropDownOptionListType = 6;
toolsDropDownOptionListType = 22;
settingsDropDownOptionListType = 21;
filterDropDownOptionListType = 33;
helpDropDownOptionListType = 23;



fileOptionList = ds_list_create();
ds_list_add(fileOptionList, "Save", "Media", "Clip", "Export", "Import", "Exit");

/*linkOptionList = ds_list_create();
ds_list_add(linkOptionList, "Track", "Rez", "Stack", "Quick", "Clique", "Focus", "Zap", "Quit");

editOptionList = ds_list_create();
ds_list_add(editOptionList, "Insert", "Paste", "Delete", "Edit", "Split", "Restore", "Chunk", "Tag");*/

editOptionList = ds_list_create();
ds_list_add(editOptionList, "Go to Line", "Go to Time");

viewOptionList = ds_list_create();
ds_list_add(viewOptionList, "Window", "Justify", "Prose", "Hide");//"Word", "Justify", "Prose", "Hide", "Zoom", "Dark Theme");

filterOptionList = ds_list_create();
ds_list_add(filterOptionList, "Toggle",  "Pick All", "Context", "Clear");

//toolsOptionList = ds_list_create();
//ds_list_add(toolsOptionList, "Sort", "StackShow", "Play", "Rez-Play");

toolsOptionList = ds_list_create();
ds_list_add(toolsOptionList, "Search", "Stack");

settingsOptionList = ds_list_create();
ds_list_add(settingsOptionList, "User", "Zoom", "Zero", "Theme", "Autosave", "Advanced"); // "Delete All","Autosave");

//settingsOptionList = ds_list_create();
//ds_list_add(settingsOptionList, "Zoom", "Dark Theme", "Mute", "Author");

helpOptionList = ds_list_create();
ds_list_add(helpOptionList, "Help", "Documentation", "About");




//"File", "Link", "Edit", "View", "Search", "Tools", "Advanced", "Setting", "Help"
ds_grid_set(menuBarGrid, menuBarGrid_colString, menuBarGrid_rowFile, "File");
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

ds_grid_set(menuBarGrid, menuBarGrid_colString, menuBarGrid_rowEdit, "Edit");
ds_grid_set(menuBarGrid, menuBarGrid_colMouseOver, menuBarGrid_rowEdit, false);
ds_grid_set(menuBarGrid, menuBarGrid_colOptionList, menuBarGrid_rowEdit, editOptionList);
ds_grid_set(menuBarGrid, menuBarGrid_colOptionListType, menuBarGrid_rowEdit, editDropDownOptionListType);

ds_grid_set(menuBarGrid, menuBarGrid_colString, menuBarGrid_rowView, "View");
ds_grid_set(menuBarGrid, menuBarGrid_colMouseOver, menuBarGrid_rowView, false);
ds_grid_set(menuBarGrid, menuBarGrid_colOptionList, menuBarGrid_rowView, viewOptionList);
ds_grid_set(menuBarGrid, menuBarGrid_colOptionListType, menuBarGrid_rowView, viewDropDownOptionListType);

ds_grid_set(menuBarGrid, menuBarGrid_colString, menuBarGrid_rowFilter, "Filter");
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

ds_grid_set(menuBarGrid, menuBarGrid_colString, menuBarGrid_rowHelp, "Help");
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
/*menuList = ds_list_create();
ds_list_add(menuList, "File", "Link", "Edit", "View", "Search", "Tools", "Advanced", "Setting", "Help");
menuListSize = ds_list_size(menuList);*/
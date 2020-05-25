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
menuBarGrid_rowView = 1;
menuBarGrid_rowSearch = 2;
menuBarGrid_rowTools = 3;
menuBarGrid_rowAdvanced = 4;
menuBarGrid_rowSettings = 5;
menuBarGrid_rowHelp = 6;


fileDropDownOptionListType = 4;
//linkDropDownOptionListType = -1;
//editDropDownOptionListType = 5;
viewDropDownOptionListType = 6;
searchDropDownOptionListType = 7;
toolsDropDownOptionListType = 22;
advancedDropDownOptionListType = 5;
// formally options
settingsDropDownOptionListType = 21;
helpDropDownOptionListType = 23;


fileOptionList = ds_list_create();
ds_list_add(fileOptionList, "Open", "Save", "Import", "Export", "Clip", "Media",  "Exit");

/*linkOptionList = ds_list_create();
ds_list_add(linkOptionList, "Track", "Rez", "Stack", "Quick", "Clique", "Focus", "Zap", "Quit");

editOptionList = ds_list_create();
ds_list_add(editOptionList, "Insert", "Paste", "Delete", "Edit", "Split", "Restore", "Chunk", "Tag");*/

viewOptionList = ds_list_create();
ds_list_add(viewOptionList, "Pane", "Word", "Justify", "Prose", "Hide", "Filter", "Context", "Clear");

searchOptionList = ds_list_create();
ds_list_add(searchOptionList, "Word", "Line", "Time");

toolsOptionList = ds_list_create();
ds_list_add(toolsOptionList, "Sort", "StackShow", "Play", "Rez-Play");

advancedOptionList = ds_list_create();
ds_list_add(advancedOptionList, "Developer", "Shuffle", "Delete All");

settingsOptionList = ds_list_create();
ds_list_add(settingsOptionList, "Zoom", "Dark Theme", "Mute", "Author");

helpOptionList = ds_list_create();
ds_list_add(helpOptionList, "Help", "Download", "About");



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

ds_grid_set(menuBarGrid, menuBarGrid_colString, menuBarGrid_rowView, "View");
ds_grid_set(menuBarGrid, menuBarGrid_colMouseOver, menuBarGrid_rowView, false);
ds_grid_set(menuBarGrid, menuBarGrid_colOptionList, menuBarGrid_rowView, viewOptionList);
ds_grid_set(menuBarGrid, menuBarGrid_colOptionListType, menuBarGrid_rowView, viewDropDownOptionListType);

ds_grid_set(menuBarGrid, menuBarGrid_colString, menuBarGrid_rowSearch, "Search");
ds_grid_set(menuBarGrid, menuBarGrid_colMouseOver, menuBarGrid_rowSearch, false);
ds_grid_set(menuBarGrid, menuBarGrid_colOptionList, menuBarGrid_rowSearch, searchOptionList);
ds_grid_set(menuBarGrid, menuBarGrid_colOptionListType, menuBarGrid_rowSearch, searchDropDownOptionListType);

ds_grid_set(menuBarGrid, menuBarGrid_colString, menuBarGrid_rowTools, "Tools");
ds_grid_set(menuBarGrid, menuBarGrid_colMouseOver, menuBarGrid_rowTools, false);
ds_grid_set(menuBarGrid, menuBarGrid_colOptionList, menuBarGrid_rowTools, toolsOptionList);
ds_grid_set(menuBarGrid, menuBarGrid_colOptionListType, menuBarGrid_rowTools, toolsDropDownOptionListType);

ds_grid_set(menuBarGrid, menuBarGrid_colString, menuBarGrid_rowAdvanced, "Advanced");
ds_grid_set(menuBarGrid, menuBarGrid_colMouseOver, menuBarGrid_rowAdvanced, false);
ds_grid_set(menuBarGrid, menuBarGrid_colOptionList, menuBarGrid_rowAdvanced, advancedOptionList);
ds_grid_set(menuBarGrid, menuBarGrid_colOptionListType, menuBarGrid_rowAdvanced, advancedDropDownOptionListType);

ds_grid_set(menuBarGrid, menuBarGrid_colString, menuBarGrid_rowSettings, "Settings");
ds_grid_set(menuBarGrid, menuBarGrid_colMouseOver, menuBarGrid_rowSettings, false);
ds_grid_set(menuBarGrid, menuBarGrid_colOptionList, menuBarGrid_rowSettings, settingsOptionList);
ds_grid_set(menuBarGrid, menuBarGrid_colOptionListType, menuBarGrid_rowSettings, settingsDropDownOptionListType);

ds_grid_set(menuBarGrid, menuBarGrid_colString, menuBarGrid_rowHelp, "Help");
ds_grid_set(menuBarGrid, menuBarGrid_colMouseOver, menuBarGrid_rowHelp, false);
ds_grid_set(menuBarGrid, menuBarGrid_colOptionList, menuBarGrid_rowHelp, helpOptionList);
ds_grid_set(menuBarGrid, menuBarGrid_colOptionListType, menuBarGrid_rowHelp, helpDropDownOptionListType);



 
menuHeight = 30;
menuWidth = 75;
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
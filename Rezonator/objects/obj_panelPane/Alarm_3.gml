// Display the help menu when activated
if (currentFunction != functionHelp) {
	exit;
}

var controlStr = "CTRL";
if (os_type == os_macosx) {
	controlStr = "CMD";
}

var helpGridHeightRez = 21;
ds_grid_resize(functionHelp_helpGridRez, functionHelp_helpGridWidth, helpGridHeightRez);

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 0, "[CLICK]");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 0, "Focus a word (and add to chain)");

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 1, "[ESC], q");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 1, "Quit adding words to the current chain");

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 2, "[DEL]");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 2, "Remove a word from a chain");

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 3, "r");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 3, "Start a new Rez chain");

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 4, "t");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 4, "Start a new Track chain");

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 5, "k");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 5, "Start a new Stack chain");

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 6, "c");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 6, "Move to Nav window Clique Tab");

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 7, "p");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 7, "Pick the currently focused element to add it to pickList [toggle]");

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 8, "v");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 8, "view main vs. grid vs. search [toggle]");

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 9, "j");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 9, "Justification/spacing of words [toggle]");

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 10, "w");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 10, "Words vs. transcriptions displayed");

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 11, controlStr + "+p");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 11, "Show just the current picks");

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 12, controlStr + "+t");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 12, "Align current Track");

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 13, controlStr + "+- [minus]");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 13, "Smaller columns (more info)");

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 14, controlStr + "++ [plus]");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 14, "Larger columns (less info)");

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 15, "SHIFT+- [minus]");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 15, "Smaller line height (more info)");

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 16, "SHIFT++ [plus]");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 16, "Larger line height (less info)");

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 17, "f");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 17, "Find all instances of a word");

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 18, "g");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 18, "Go to user-specified line");

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 19, controlStr + "+o");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 19, "Open file or project");

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 20, controlStr + "+s");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 20, "Save file");





var helpGridHeightNav = 13;
ds_grid_resize(functionHelp_helpGridNav, functionHelp_helpGridWidth, helpGridHeightNav);

ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colKey, 0, "UP ARROW");
ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colDesc, 0, "move up to previous line");

ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colKey, 1, "DOWN ARROW");
ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colDesc, 1, "move down to next line");

ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colKey, 2, "LEFT ARROW");
ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colDesc, 2, "move left");

ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colKey, 3, "RIGHT ARROW");
ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colDesc, 3, "move right");

ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colKey, 4, "[HOME]");
ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colDesc, 4, "Jump to beginning of current line");

ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colKey, 5, controlStr + "+LEFT ARROW");
ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colDesc, 5, "Jump to beginning of current line");

ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colKey, 6, "[END]");
ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colDesc, 6, "Jump to end of current line");

ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colKey, 7, controlStr + "+RIGHT ARROW");
ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colDesc, 7, "Jump to end of current line");

ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colKey, 8, "[PAGEUP]");
ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colDesc, 8, "scroll up one screen at a time");

ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colKey, 9, "[PAGEDOWN]");
ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colDesc, 9, "scroll down one screen at a time");


ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colKey, 10, controlStr + "+UP ARROW");
ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colDesc, 10, "Jump to first line of conversation");

ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colKey, 11, controlStr + "+DOWN ARROW");
ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colDesc, 11, "Jump to last line of conversation");

ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colKey, 12, "[TAB]");
ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colDesc, 12, "Move to next pane (Nav, Detail, Main)");
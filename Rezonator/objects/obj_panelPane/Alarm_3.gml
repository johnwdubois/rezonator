// Display the help menu when activated
if (currentFunction != functionHelp) {
	exit;
}

var helpGridHeightRez = 15;
ds_grid_resize(functionHelp_helpGridRez, functionHelp_helpGridWidth, helpGridHeightRez);

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 0, "[CLICK]");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 0, "Focus a word (and if whip is present, add to chain)");

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 1, "[ESC], q");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 1, "Quit the current chain (stop adding words)");

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 2, "[DEL]");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 2, "Remove a word from a chain");

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 3, "r");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 3, "Start a new Rez chain");

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 4, "t");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 4, "Start a new Track chain");

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 5, "k");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 5, "Start a new Stack chain");

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 6, "c");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 6, "Move to Clique Tab");

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 7, "p");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 7, "Pick the currently focused element to add it to pickList");

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 8, "CTRL/CMD+p");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 8, "Pick filter");

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 9, "CTRL/CMD+p");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 9, "Pick filter");

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 10, "CTRL/CMD+t");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 10, "Align current Track");

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 11, "w");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 11, "Words vs. transcriptions displayed");

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 12, "w");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 12, "Words vs. transcriptions displayed");

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 13, "j");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 13, "Justification/spacing of words");

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 14, "[SPACEBAR]");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 14, "Play/Pause audio");

ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, 15, "m");
ds_grid_set(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, 15, "Mute audio");







var helpGridHeightNav = 7;
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

ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colKey, 5, "CTRL+←");
ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colDesc, 5, "Jump to beginning of current line");

ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colKey, 6, "[END]");
ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colDesc, 6, "Jump to end of current line");

ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colKey, 7, "CTRL+→");
ds_grid_set(functionHelp_helpGridNav, functionHelp_helpGrid_colDesc, 7, "Jump to end of current line");
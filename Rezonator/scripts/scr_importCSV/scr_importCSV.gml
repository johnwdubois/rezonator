// Begin the import process of a single user specified CSV file

var filename = argument0;

global.importCSVGrid = load_csv(filename);

//show_message("done... width = " + string(ds_grid_width(global.importCSVGrid)) + ", height = " + string(ds_grid_height(global.importCSVGrid)));

room_goto(rm_mainScreen);
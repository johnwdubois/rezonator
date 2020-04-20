// Begin the import process of a single user specified CSV file

var filename = argument0;

global.importCSVGrid = load_csv(filename);


var unitCounter = 0;
var previousUID = -1;

var importCSVGridHeight = ds_grid_height(global.importCSVGrid);
for (var i = 0; i < importCSVGridHeight; i++) {
	
	var currentUID = real(ds_grid_get(global.importCSVGrid, global.importCSVGrid_colUID, i));
	if (previousUID != currentUID) {
		previousUID = currentUID;
		unitCounter++;
	}
}
global.importCSVUnitGridHeight = unitCounter;
global.totalUnitAmount = unitCounter;


room_goto(rm_mainScreen);
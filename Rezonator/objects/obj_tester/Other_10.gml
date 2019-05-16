/// @description Insert description here
test_it("doesn't slow down the program");

for(var testLoop = 0; testLoop < ds_grid_height(obj_control.unitGrid) - 1; testLoop++) {
	scr_wordClicked(ds_list_find_value(ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colWordIDList, testLoop+1), 0), ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colUnitID, testLoop+1));
	assert((fps > 40), "gotta go fast");
}

test_end();
test_describe_pass();

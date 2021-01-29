function scr_gridViewerSelectGridOptions(optionSelected) {

	// create a temp list called gridNameList to hold every gridName, then we can search that grid for optionSelected
	var gridNameList = ds_list_create();
	var gridList = ds_list_size(obj_gridViewer.gridList);
	for (var i = 0; i < gridList; i++) {
		var currentGrid = ds_list_find_value(obj_gridViewer.gridList, i);
		ds_list_add(gridNameList, scr_getGridNameString(currentGrid));
	}

	var optionSelectedIndex = ds_list_find_index(gridNameList, optionSelected);
	var gridSelected = ds_list_find_value(obj_gridViewer.gridList, optionSelectedIndex);

	obj_gridViewer.grid = gridSelected;

	ds_list_destroy(gridNameList);

	with(obj_dropDown){
	    instance_destroy();
	}

}

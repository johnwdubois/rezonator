fileLineRipList = ds_grid_get(global.fileLineRipGrid, global.fileLineRipGrid_colFileLineRipList, discourseProcessing);
currentDiscoID = ds_grid_get(global.fileLineRipGrid, global.fileLineRipGrid_colDiscoID, discourseProcessing);

if (fileLineRipListElement < ds_list_size(fileLineRipList) - 1)
{
	fileLineRipListElement++;
}

currentElement = ds_list_find_value(fileLineRipList, fileLineRipListElement);
		
scr_loadNextElement();
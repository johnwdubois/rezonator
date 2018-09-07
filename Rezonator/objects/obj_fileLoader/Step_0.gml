fileLoadRate = ceil(fps);

for (var i = 0; i < fileLoadRate; i++)
{

	if (discourseProcessing < 0 or discourseProcessing >= ds_grid_height(global.fileLineRipGrid))
	{
		exit;
	}
	
	if not instance_exists(obj_control)
	{
		exit;
	}
	
	if (ds_grid_height(obj_control.unitGrid) >= global.totalUnitAmount)
	{
		exit;
	}
	


	fileLineRipList = ds_grid_get(global.fileLineRipGrid, global.fileLineRipGrid_colFileLineRipList, discourseProcessing);
	currentDiscoID = ds_grid_get(global.fileLineRipGrid, global.fileLineRipGrid_colDiscoID, discourseProcessing);






	currentElement = ds_list_find_value(fileLineRipList, fileLineRipListElement);
	
	
	scr_loadNextElement();


	if (fileLineRipListElement < ds_list_size(fileLineRipList) - 1)
	{
		fileLineRipListElement++;
	}
	else
	{
		fileLineRipListElement = 0;
		discourseProcessing++;
	}

}
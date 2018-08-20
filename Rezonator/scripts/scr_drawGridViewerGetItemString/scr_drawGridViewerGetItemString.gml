var grid = argument0;
var col = argument1;
var row = argument2;

var currentCell = ds_grid_get(grid, col, row);
var itemString = "";
var itemList = 0;

if (grid == obj_control.unitGrid)
{
	if (col == obj_control.unitGrid_colWordIDList)
	{
		itemList = currentCell;
	}
}
else if (grid == obj_control.filterGrid)
{
	if (col == obj_control.lineGrid_colWordIDList)
	{
		itemList = currentCell;
	}
}
else if (grid == obj_control.lineGrid)
{
	if (col == obj_control.lineGrid_colWordIDList)
	{
		itemList = currentCell;
	}
}
else if (grid == obj_control.dynamicWordGrid)
{
	if (col == obj_control.dynamicWordGrid_colInChainList)
	{
		itemList = currentCell;
	}
}
else if (grid == obj_chain.rezChainGrid or grid == obj_chain.trackChainGrid or grid == obj_chain.stackChainGrid)
{
	if (col == obj_chain.chainGrid_colWordIDList)
	{
		itemList = currentCell;
	}
}
else if (grid == obj_control.searchGrid)
{
	if (col == obj_control.searchGrid_colHitIDList)
	{
		itemList = currentCell;
	}
}



if (itemList == 0 or itemList == undefined or currentCell == undefined)
{
	itemString = string(ds_grid_get(grid, col, row));
	if (string_length(itemString) == 0)
	{
		itemString = " ";
	}
}
else
{
	itemString = "{";
	
	for (var i = 0; i < ds_list_size(itemList);  i++)
	{
		itemString += string(ds_list_find_value(itemList, i));
		
		if (i < ds_list_size(itemList) - 1)
		{
			itemString += ", "
		}
	}
	
	itemString += "}";
}


return itemString;
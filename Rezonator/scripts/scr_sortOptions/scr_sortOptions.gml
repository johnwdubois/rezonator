var optionSelected = argument0;

with (obj_panelPane)
{
	if (currentFunction == functionSort)
	{
		var rowInSortGrid = ds_grid_value_y(functionSort_sortGrid, functionSort_gridSortColGrid_colMouseover, 0, functionSort_gridSortColGrid_colMouseover, ds_grid_height(functionSort_sortGrid), true);
			
		if (rowInSortGrid > -1)
		{
			var newSortCol = ds_grid_get(functionSort_sortGrid, functionSort_gridSortColGrid_colCol, rowInSortGrid);
			//"discoID", "unitStart", "unitEnd", "uID", "unitID"
			switch (optionSelected)
			{
				case "discoID":
					newSortCol = obj_control.lineGrid_colDiscoID;
					break;
				case "unitStart":
					newSortCol = obj_control.lineGrid_colUnitStart;
					break;
				case "unitEnd":
					newSortCol = obj_control.lineGrid_colUnitEnd;
					break;
				case "uID":
					newSortCol = obj_control.lineGrid_colLineNumberLabel;
					break;
				case "unitID":
					newSortCol = obj_control.lineGrid_colUnitID;
					break;
				default:
					break;
			}
				
			ds_grid_set(functionSort_sortGrid, functionSort_gridSortColGrid_colCol, rowInSortGrid, newSortCol);
		}
	}
}
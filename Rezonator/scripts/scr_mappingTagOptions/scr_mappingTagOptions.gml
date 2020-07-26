var optionSelected = argument0;

switch (optionSelected)
{
	case "Token":
		ds_grid_set(global.tagInfoGrid, obj_importMapping.colToChange, obj_importMapping.rowToChange , global.levelToken);
		var checkIfDisplayT = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colDisplayToken,obj_importMapping.rowToChange);
		var checkIfDisplayU = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colDisplayUnit,obj_importMapping.rowToChange);
		if(checkIfDisplayT || checkIfDisplayU){
			ds_grid_set(global.tagInfoGrid, global.tagInfoGrid_colDisplayToken , obj_importMapping.rowToChange , false);
			ds_grid_set(global.tagInfoGrid, global.tagInfoGrid_colDisplayUnit , obj_importMapping.rowToChange , false);
		}
		break;
	case "Unit":
		ds_grid_set(global.tagInfoGrid, obj_importMapping.colToChange, obj_importMapping.rowToChange , global.levelUnit);
		var checkIfDisplayT = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colDisplayToken,obj_importMapping.rowToChange);
		var checkIfDisplayU = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colDisplayUnit,obj_importMapping.rowToChange);
		if(checkIfDisplayT || checkIfDisplayU){
			ds_grid_set(global.tagInfoGrid, global.tagInfoGrid_colDisplayToken , obj_importMapping.rowToChange , false);
			ds_grid_set(global.tagInfoGrid, global.tagInfoGrid_colDisplayUnit , obj_importMapping.rowToChange , false);
		}
		break;
	case "Discourse":	
		ds_grid_set(global.tagInfoGrid, obj_importMapping.colToChange, obj_importMapping.rowToChange , global.levelDiscourse);
		var checkIfDisplayT = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colDisplayToken,obj_importMapping.rowToChange);
		var checkIfDisplayU = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colDisplayUnit,obj_importMapping.rowToChange);
		if(checkIfDisplayT || checkIfDisplayU){
			ds_grid_set(global.tagInfoGrid, global.tagInfoGrid_colDisplayToken , obj_importMapping.rowToChange , false);
			ds_grid_set(global.tagInfoGrid, global.tagInfoGrid_colDisplayUnit , obj_importMapping.rowToChange , false);
		}
		break;
	case "Exception":
		ds_grid_set(global.tagInfoGrid, obj_importMapping.colToChange, obj_importMapping.rowToChange , global.levelUnknown);
		var checkIfDisplayT = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colDisplayToken,obj_importMapping.rowToChange);
		var checkIfDisplayU = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colDisplayUnit,obj_importMapping.rowToChange);
		if(checkIfDisplayT || checkIfDisplayU){
			ds_grid_set(global.tagInfoGrid, global.tagInfoGrid_colDisplayToken , obj_importMapping.rowToChange , false);
			ds_grid_set(global.tagInfoGrid, global.tagInfoGrid_colDisplayUnit , obj_importMapping.rowToChange , false);
		}
		break;
	default:
		break;
}

//scr_gridMultiColSort(global.tagInfoGrid, global.tagInfoGrid_colLevel, true, global.tagInfoGrid_colTokenCount, false, global.tagInfoGrid_colDisplayToken, false, global.tagInfoGrid_colDisplayUnit, false);

with(obj_dropDown){
	instance_destroy();
}
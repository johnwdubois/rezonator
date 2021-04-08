// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_getUnitText(unitID){
	
	// get unitText
	var unitText = "";
	var wordIDList = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colWordIDList, unitID - 1);
	var wordIDListSize = ds_list_size(wordIDList);
	var i = 0;
	
	repeat (wordIDListSize) {
		var unitTextWordID = wordIDList[| i];
		var unitTextWordDisplayStr = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, unitTextWordID - 1);
				
		// concatenate the UnitText string
		if (is_string(unitTextWordDisplayStr)) unitText += scr_adaptFont(unitTextWordDisplayStr,"M");
		if (i < wordIDListSize - 1) unitText += " ";
		
		i++;
	}
	
	return unitText;
}
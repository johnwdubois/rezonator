function scr_speakerLabelOptions(argument0) {
	var optionSelected = argument0;

	with (obj_panelPane)
	{
		if (currentFunction == functionChainList)
		{
			
			switch (optionSelected)
			{
				//"Red", "Blue", "Green", "Gold", "Custom"
				case "Swap":
					if (!obj_control.dialogueBoxActive) {
						keyboard_string = "";
						obj_control.swapLine = true;
					}


					obj_control.dialogueBoxActive = true;

					if (!instance_exists(obj_dialogueBox)) {
						instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
					}
				
				
					instance_destroy(obj_dropDown);
					//return true;
					break;
						
				case "Shuffle":	
					obj_control.lineGridShuffle = !obj_control.lineGridShuffle;
					if (obj_control.lineGridShuffle) {
						scr_shuffleDisplayRows();
						scr_refreshLineGridDisplayRow(obj_control.lineGrid);
					}
					else {
						ds_grid_copy(obj_control.lineGrid, obj_control.lineGridBackup);
						scr_refreshLineGridPixelY();
						scr_refreshLineGridDisplayRow(obj_control.lineGrid);
					}
					instance_destroy(obj_dropDown);
					//return true;
					break;
				case "Toggle Line #":
					
					obj_control.showLineNumber = !obj_control.showLineNumber;
					//return false;
					break;
						
				case "Reset Order":

					//ds_grid_copy(obj_control.unitGrid, obj_control.unitGridBackup);
					
					ds_grid_copy(obj_control.lineGrid, obj_control.lineGridBackup);
					scr_refreshLineGridPixelY();
					scr_refreshLineGridDisplayRow(obj_control.lineGrid);
					instance_destroy(obj_dropDown);
					//return true;
					break;
				
				case "Check Order":
					
					
					var tempLineGrid = ds_grid_create(ds_grid_width(obj_control.currentActiveLineGrid), ds_grid_height(obj_control.currentActiveLineGrid));
					ds_grid_copy(tempLineGrid, obj_control.currentActiveLineGrid);
					
					scr_gridMultiColSort(tempLineGrid, obj_control.lineGrid_colDiscoID, true, obj_control.lineGrid_colUnitStart, true, obj_control.lineGrid_colUnitEnd, true, obj_control.lineGrid_colUnitID, true);
					
					var checkList1 = ds_list_create();
					var currentActiveLineGridHeight = ds_grid_height(obj_control.currentActiveLineGrid);
					for (var i = 0; i < currentActiveLineGridHeight; i++) {
						ds_list_add(checkList1, ds_grid_get(obj_control.currentActiveLineGrid, obj_control.lineGrid_colUnitID, i));
					}
					var checkList2 = ds_list_create();
					var tempLineGridHeight = ds_grid_height(tempLineGrid)
					for (var i = 0; i < tempLineGridHeight; i++) {
						ds_list_add(checkList2, ds_grid_get(tempLineGrid, obj_control.lineGrid_colUnitID, i));
					}
					
					if(scr_compareLists(checkList1, checkList2)){
						show_message(scr_get_translation("msg_congrats"));
					}
					else{
						show_message(scr_get_translation("msg_lines-notordered"));
					}
					
					
					ds_list_destroy(checkList1);
					ds_list_destroy(checkList2);
					ds_grid_destroy(tempLineGrid);
					
					instance_destroy(obj_dropDown);
					//return true;
					break;
				case "Tag":
						
					var dropDownOptionList = ds_list_create();
					ds_list_add(dropDownOptionList, "Happy", "Sad", "Playful", "Serious", "Delete tag");
						
					if (ds_list_size(dropDownOptionList) > 0) {
						var dropDownInst = instance_create_depth(obj_dropDown.x + obj_dropDown.windowWidth , obj_dropDown.y+ obj_dropDown.optionSpacing*3, -999, obj_dropDown);
						dropDownInst.optionList = dropDownOptionList;
						dropDownInst.optionListType = dropDownInst.optionListTypeWordTags;
					
						obj_control.ableToCreateDropDown = false;
						obj_control.alarm[0] = 2;
					}
					
					break;
				default:
					break;
			}
		}
	}


}

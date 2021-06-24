function scr_speakerLabelOptions(optionSelected) {

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
				
					scr_shuffleDisplayRows();
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
				case "Delete Link":
			
					scr_deleteFromChain(true);
			
			


					instance_destroy(obj_dropDown);
					break;
					
			case "Tag Chain":
			
			// set field/tags
			if (obj_control.rightClickID != "") {
				var unitSubMap = global.nodeMap[? obj_control.rightClickID];
				if(scr_isNumericAndExists(unitSubMap, ds_type_map)){
					
					var inChainsList = unitSubMap[? "inChainsList"];
					var inChainsListSize = ds_list_size(inChainsList);

					for(var i = 0; i < inChainsListSize; i++){
						var currentChainID = inChainsList[| i];
						var chainSubMap = global.nodeMap[? currentChainID];						
						if(scr_isNumericAndExists(chainSubMap, ds_type_map)){
							var chainType = chainSubMap[? "type"];							
							if (obj_panelPane.functionField_chainFieldSelected != "" && obj_panelPane.functionField_chainTagSelected != ""
							&& is_string(obj_panelPane.functionField_chainFieldSelected) && is_string(obj_panelPane.functionField_chainTagSelected)) {
								var chainTagMap = chainSubMap[? "tagMap"];
								if (scr_isNumericAndExists(chainTagMap, ds_type_map)) {
									chainTagMap[? obj_panelPane.functionField_chainFieldSelected] = obj_panelPane.functionField_chainTagSelected;
									show_debug_message("scr_unitRightClicked ... setting ChainSubMap: " + string(currentChainID) + ", field:" + string(obj_panelPane.functionField_chainFieldSelected) + ", tag: " + string(obj_panelPane.functionField_chainTagSelected));
								}
							}			
						}						
					}
				}
			}
			

			instance_destroy(obj_dropDown);
			break;
			case "Tag Unit":
			
			// set field/tags
			if (obj_control.rightClickID != "") {
				var unitSubMap = global.nodeMap[? obj_control.rightClickID];
				if(scr_isNumericAndExists(unitSubMap, ds_type_map)){
					if (obj_panelPane.functionField_unitFieldSelected != "" && obj_panelPane.functionField_unitTagSelected != ""
					&& is_string(obj_panelPane.functionField_unitFieldSelected) && is_string(obj_panelPane.functionField_unitTagSelected)) {
						var unitTagMap = unitSubMap[? "tagMap"];
						if (scr_isNumericAndExists(unitTagMap, ds_type_map)) {
							unitTagMap[? obj_panelPane.functionField_unitFieldSelected] = obj_panelPane.functionField_unitTagSelected;
							show_debug_message("scr_unitRightClicked ... setting unitSubMap: " + string(obj_control.rightClickID) + ", field:" + string(obj_panelPane.functionField_unitFieldSelected) + ", tag: " + string(obj_panelPane.functionField_unitTagSelected));
						}
					}			
				}
			}
			

			instance_destroy(obj_dropDown);
			break;
		case "Tag Entry":
			
			// set field/tags
			if (obj_control.rightClickID != "") {
				var unitSubMap = global.nodeMap[? obj_control.rightClickID];
				if(scr_isNumericAndExists(unitSubMap, ds_type_map)){
					var inChainsList = unitSubMap[? "inChainsList"];
					var inChainsListSize = ds_list_size(inChainsList);
					
					for(var i = 0; i < inChainsListSize; i++){
						var currentChainID = inChainsList[| i];
						var chainSubMap = global.nodeMap[? currentChainID];	
						
						if(scr_isNumericAndExists(chainSubMap, ds_type_map)){
							var chainType = chainSubMap[? "type"];		
							
	
							var chainSetList = chainSubMap[? "setIDList"];
							var sizeOfSetList = ds_list_size(chainSetList);
								 
							for(var j = 0 ; j < sizeOfSetList ; j ++){
								var currentEntry = chainSetList[|j];
								var currentEntrySubMap = global.nodeMap[?currentEntry];
									
								if(scr_isNumericAndExists(currentEntrySubMap , ds_type_map)){
									var currentunitID = currentEntrySubMap[?"unit"];
										
									if(currentunitID == obj_control.rightClickID){
										if (obj_panelPane.functionField_entryFieldSelected != "" && obj_panelPane.functionField_entryTagSelected != ""
										&& is_string(obj_panelPane.functionField_entryFieldSelected) && is_string(obj_panelPane.functionField_entryTagSelected)) {
											var currentEntryTagMap = currentEntrySubMap[? "tagMap"];
											if (scr_isNumericAndExists(currentEntryTagMap, ds_type_map)) {
												currentEntryTagMap[? obj_panelPane.functionField_entryFieldSelected] = obj_panelPane.functionField_entryTagSelected;
												show_debug_message("scr_unitRightClicked ... setting ChainSubMap: " + string(currentEntry) + ", field:" + string(obj_panelPane.functionField_entryFieldSelected) + ", tag: " + string(obj_panelPane.functionField_entryTagSelected));
											}
										}
									}
								}
							}									
						}						
					}
				}
			}

			instance_destroy(obj_dropDown);
			break;
				default:
					break;
			}
		}
	}
obj_control.rightClicked = false;

}

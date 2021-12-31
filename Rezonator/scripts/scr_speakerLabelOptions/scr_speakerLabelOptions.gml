function scr_speakerLabelOptions(optionSelected) {
	var optionIndex = ds_list_find_index(optionList, optionSelected);
	with (obj_panelPane) {
		if (currentFunction == functionChainList) {
			
			if (optionSelected == "option_create-tree" || optionSelected == "Create tree (unit)") {
				var unitSubMap = global.nodeMap[? obj_control.rightClickID];
				if (scr_isNumericAndExists(unitSubMap, ds_type_map)) {
					var tokenList = ds_list_create();
					var entryList = unitSubMap[? "entryList"];
					var entryListSize = ds_list_size(entryList);
						
					for (var i = 0; i < entryListSize; i++) {
						var currentEntry = entryList[| i];
						var currentEntrySubMap = global.nodeMap[? currentEntry];
						var currentToken = currentEntrySubMap[? "token"];
						ds_list_add(tokenList, currentToken);
					}
						
					scr_createTree(tokenList);
				}
				instance_destroy(obj_dropDown);
			}
			else if (optionSelected == "Create tree (stack)") {
				var unitSubMap = global.nodeMap[? obj_control.rightClickID];
				if (scr_isNumericAndExists(unitSubMap, ds_type_map)) {
					var inChainsList = unitSubMap[? "inChainsList"];
					if (ds_list_size(inChainsList) > 0) {
						scr_createTreeFromStack(inChainsList[| 0]);
					}
				}
				instance_destroy(obj_dropDown);
			}
			else if (optionSelected == "Toggle Line #") {
				obj_control.showLineNumber = !obj_control.showLineNumber;
			}
			else if (optionSelected == "help_label_delete-link") {
				scr_deleteFromChain(true);

				instance_destroy(obj_dropDown);
			}
			else if (optionSelected == "option_set-chain-name") {
				scr_setChainName();

				instance_destroy(obj_dropDown);
			}
			else if (optionSelected == "Tag Chain") {
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
			}
			else if (optionSelected == "Tag Unit") {
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
			}
			else if (optionSelected == "Tag Entry") {
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
				
			}
			else if (optionSelected == "tab_name_tag") {
				obj_control.unitToChange =	obj_control.rightClickID;
				with(obj_dropDown){
					scr_destroyAllDropDownsOtherThanSelf();
				}
				var dropDownOptionList = ds_list_create();
				ds_list_add(dropDownOptionList, "Tag Unit");
				if(obj_control.inChain == true){
					ds_list_add(dropDownOptionList, "Tag Chain", "Tag Entry");
				}
				if (ds_list_size(dropDownOptionList) > 0) {
					scr_createDropDown(obj_dropDown.x + obj_dropDown.windowWidth, obj_dropDown.y + (obj_dropDown.optionSpacing * optionIndex), dropDownOptionList, global.optionListTypeTag);
				}
			}
		}
	}
	obj_control.inChain = false;
	obj_control.rightClicked = false;

}

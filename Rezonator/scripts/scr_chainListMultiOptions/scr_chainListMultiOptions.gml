// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_chainListMultiOptions(optionSelected){
	
	var optionIndex = ds_list_find_index(optionList, optionSelected);
	
	
	
	var currentSelectedChainList = "";
	var visibleList = "";
	var filterList = "";
	
	
	if(obj_panelPane.functionChainList_currentTab == obj_panelPane.functionChainList_tabRezBrush){
		currentSelectedChainList = obj_control.selectedRezChainList;
		visibleList = obj_control.hiddenRezChainList;
		filterList = obj_chain.filteredRezChainList;
	}
	else if(obj_panelPane.functionChainList_currentTab == obj_panelPane.functionChainList_tabTrackBrush){
		currentSelectedChainList = obj_control.selectedTrackChainList;
		visibleList = obj_control.hiddenTrackChainList;
		filterList = obj_chain.filteredTrackChainList;
	}
	else{
		currentSelectedChainList = obj_control.selectedStackChainList;
		visibleList = obj_control.hiddenStackChainList;
		filterList = obj_chain.filteredStackChainList;
		
	}
	var currentSelectedChainListSize = ds_list_size(currentSelectedChainList);
	
	
	if (optionSelected == "option_add-to-show") {
		var dropDownOptionList = ds_list_create();
		var showList = global.nodeMap[? "showList"];
		ds_list_copy(dropDownOptionList, showList);
		ds_list_insert(dropDownOptionList, 0, "option_create-show");
		with (obj_dropDown) if (level > 1) instance_destroy();
		scr_createDropDown(obj_dropDown.x + obj_dropDown.windowWidth, obj_dropDown.y + (obj_dropDown.optionSpacing * optionIndex), dropDownOptionList, global.optionListTypeSelectShow);
	}
	else if (optionSelected == "help_label_delete_plain") {
		while(ds_list_size(currentSelectedChainList) > 0){
			scr_deleteChain(currentSelectedChainList[|0])
		}
		with (obj_dropDown)  instance_destroy();
	}
	else if (optionSelected == "menu_filter") {
		for(var i = 0 ; i < currentSelectedChainListSize; i++){
			var currentChain = currentSelectedChainList[|i];
			var currentChainSubMap = global.nodeMap[?currentChain];
			currentChainSubMap[?"filter"] = !currentChainSubMap[?"filter"];
			if(!currentChainSubMap[?"filter"]){
				scr_deleteFromList(filterList, currentChain);
			}
			else{
				scr_addToListOnce(filterList,currentChain);
			}
		}
		with (obj_dropDown)  instance_destroy();
	}
	else if (optionSelected == "menu_hide") {
		for(var i = 0 ; i < currentSelectedChainListSize; i++){
			var currentChain = currentSelectedChainList[|i];
			var currentChainSubMap = global.nodeMap[?currentChain];
			currentChainSubMap[?"visible"] = !currentChainSubMap[?"visible"];
			if(currentChainSubMap[?"visible"]){
				scr_deleteFromList(visibleList, currentChain);
			}
			else{
				scr_addToListOnce(visibleList,currentChain);
			}
		}
		with (obj_dropDown)  instance_destroy();
	}
	
	if ( optionSelected == "option_clip" ){					
		// Create a clip file based on that Stack
		scr_clipAllStacks(obj_control.selectedStackChainList);			
		// Destory the Dropdown
		instance_destroy(obj_dropDown);
	}
	if ( optionSelected == "option_create-tree"){
		scr_treeAllStacks(obj_control.selectedStackChainList);
	
		// Destory the Dropdown
		instance_destroy(obj_dropDown);
	}

}
function scr_rightClickWordOptions(optionSelected) {

	switch (optionSelected)
	{
		
		case "Replace Word":
		
			if (obj_control.rightClickID != "") {

					if (!obj_control.dialogueBoxActive) {
						keyboard_string = "";
						obj_control.replace = true;
					}

					obj_control.fromDropDown = true;
					obj_control.dialogueBoxActive = true;

					if (!instance_exists(obj_dialogueBox)) {
						instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
					}
		
			}
			
			instance_destroy();

			break;
			
		case "Split Word":
			scr_destroyAllDropDownsOtherThanSelf();
			if (obj_control.rightClickID != "") {

					if (!obj_control.dialogueBoxActive) {
						keyboard_string = "";
						obj_control.replace = true;
					}

					obj_control.fromDropDown = true;
					obj_control.dialogueBoxActive = true;
					obj_control.splitWord = true;

					if (!instance_exists(obj_dialogueBox)) {
						instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
						
					}
		
			}
			instance_destroy();

			break;
			
		case "New Word":
		
			scr_destroyAllDropDownsOtherThanSelf();
			var dropDownOptionList = ds_list_create();
			ds_list_add(dropDownOptionList, "<0>", "<ZERO>", "<PRO>", "Custom");
						

			if (ds_list_size(dropDownOptionList) > 0) {
				scr_createDropDown(obj_dropDown.x + obj_dropDown.windowWidth, obj_dropDown.y, dropDownOptionList, global.optionListTypeNewWord);
			}
	
			break;
			
		case "Delete Word":
			scr_destroyAllDropDownsOtherThanSelf();
			
			/* bring back with deleteing new words
			obj_control.newWordHoverWordID = obj_control.rightClickWordID;
			obj_control.deleteNewWord = true;
			scr_deleteNewWord();
			*/
			
			obj_control.deleteNewWord = false;
			instance_destroy();
	
			break;
			
		case "Delete Link":
			
			scr_deleteFromChain(true);
			
			


			instance_destroy();
			break;
			
		case "Delete Chunk":

			
			obj_control.deleteChunkWord = true;
			var chunkSubMap = global.nodeMap[?obj_control.rightClickID];
			var inChainsList = chunkSubMap[?"inChainsList"];
			if(ds_list_size(inChainsList) > 0){
				scr_deleteFromChain(true);
			}
			scr_deleteChunk(obj_control.rightClickID);
			
			obj_control.deleteChunkWord = false;
			instance_destroy();
			break;
		case "Split Line":
			
			if (instance_exists(obj_control)) {
				scr_splitLine(obj_control.rightClickWordID);
			}

			instance_destroy();
			break;	
			
			
		default:
			break;
	}

obj_control.rightClicked = false;
}

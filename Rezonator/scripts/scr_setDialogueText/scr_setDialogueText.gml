// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_setDialogueText(){
	
	if (room == rm_openingScreen) {
		titleText = "";
		var newVersionNum = instance_exists(obj_DBcontrol) ? obj_DBcontrol.newestVersionNum : "";
		descriptionText = "A new version of Rezonator (version " + string(newVersionNum) + ") is available! Would you like to download it?";
		exit;
	}

	
	if(obj_dialogueBox.questionWindowActive){
			
		if(clearAllStacks) {
			titleText = scr_get_translation("Clear Stacks");
			descriptionText = scr_get_translation("msg_warning_clear_stacks");
		}
		if(clearAllRez) {
			titleText = scr_get_translation("Clear Rez Chains");
			descriptionText = scr_get_translation("msg_warning_clear_rez");
		}
		if(clearAllTracks) {
			titleText = scr_get_translation("Clear Track Chains");
			descriptionText =  scr_get_translation("msg_warning_clear_track");
		}
		if(clearAllLinks) {
			titleText = scr_get_translation("Clear All Chains");
			descriptionText = scr_get_translation("msg_warning_clear_chains");
		}
		if (clearChain) {
			titleText = scr_get_translation("Clear Current Chains");
			descriptionText = scr_get_translation("msg_warning_clear_focused_chain");
		}
		if (clearShow) {
			titleText = scr_get_translation("Delete Show");
			descriptionText =  scr_get_translation("You are about to delete this show");
		}
		if(layerLink) {
			titleText = scr_get_translation("help_label_link");
			descriptionText = scr_get_translation("masg_warning_layer_link");
		}
		if(combineChains) {
			if (obj_control.stackMerged) {
				titleText = scr_get_translation("Merging Stacks");
				descriptionText = scr_get_translation("msg_warning_merge_stacks");
			}
			else{
				titleText = scr_get_translation("Merging Chains");
				descriptionText = scr_get_translation("msg_warning_merge_chains");
			}
		}
		if (removeTagToken || removeTagUnit || removeTagEntry || removeTagChain || removeTagChunk || removeTagLink) {
			titleText = scr_get_translation("msg_remove") + " " + scr_get_translation("tab_name_tag");
			descriptionText = scr_get_translation("msg_remove-mark-tag") + string(stringToBeRemoved);
		}
		if (removeFieldToken || removeFieldUnit || removeFieldEntry || removeFieldChain || removeFieldChunk || removeFieldLink) {
			titleText = scr_get_translation("msg_remove") + " " + scr_get_translation("option_field");
			descriptionText =  scr_get_translation("msg_remove-field-tag") + string(stringToBeRemoved);
		}
		if (removeSearch) {
			var searchSubMap = global.searchMap[?searchToBeRemoved];
			var searchTermList = searchSubMap[?"searchTermList"];
			titleText = scr_get_translation("msg_remove") + " " + scr_get_translation("menu_search");
			descriptionText = scr_get_translation("msg_remove-search") + ": " + scr_getStringOfList(searchTermList);
		}
		if (removeTree) {
			var searchSubMap = global.treeMap[?stringToBeRemoved];
			titleText = scr_get_translation("msg_remove") + " " + scr_get_translation("tab_name_tree");
			descriptionText =  "This will permanently delete the tree:  " + string(searchSubMap[? "name"]);
		}
		if (instance_exists(obj_stacker)) {
			if (obj_stacker.confirmStackCreate) {
				var stackChainList = global.nodeMap[? "stackList"];
				if (scr_isNumericAndExists(stackChainList, ds_type_list)) {
					var stackChainListSize = ds_list_size(stackChainList);
					descriptionText =  scr_get_translation("msg_stacks_created-1") + string(stackChainListSize) + scr_get_translation("msg_stacks_created-2");
					noButtonActive = true;
				}
			}
		}
	}
		
	if(obj_dialogueBox.inputWindowActive){
	
		//Setting input prompt
		if (obj_control.changeAuthor) {
			titleText = scr_get_translation("Input New User");
			descriptionText = scr_get_translation("msg_input_creator");
		}
		if (obj_control.changeZero) {
			titleText = scr_get_translation("Input New Zero");
			descriptionText = scr_get_translation("msg_input_new-string");
		}
		if (obj_control.replace) {
			if(obj_control.splitWord){
				titleText = scr_get_translation("help_label_split-word");
				descriptionText = scr_get_translation("msg_input_split_words");
			}
			else{
				titleText = scr_get_translation("option_new-token");
				descriptionText = scr_get_translation("msg_input_new-word");
			}
		}
		if (obj_control.newWordCreated) {
			titleText = scr_get_translation("option_new-token");
			descriptionText = scr_get_translation("msg_input_add_new-word");
		}
		
		if(obj_control.caption){
			titleText = scr_get_translation("msg_input_caption");
			descriptionText = scr_get_translation("msg_input_caption");
		}	
		if (obj_control.rename) {
			titleText = scr_get_translation("help_description_rename");
			descriptionText = scr_get_translation("msg_input_chain-name");
		}
		if (obj_control.recolor) {
			titleText = scr_get_translation("option_recolor");
			descriptionText = scr_get_translation("msg_input_chain-color");
		}
		
		if (obj_control.gPressed) {
			if(obj_control.goToTime){
				titleText = scr_get_translation("msg_time_search");
				descriptionText = scr_get_translation("msg_input_time-jump");
			}
			else{
				titleText = scr_get_translation("msg_specify_line");
				descriptionText = scr_get_translation("msg_input_line-jump");
			}
		}
		
		var drawNewFieldText = (obj_control.newCustomFieldToken || obj_control.newCustomFieldUnit || obj_control.newCustomFieldEntry || obj_control.newCustomFieldChain || obj_control.newCustomFieldChunk || obj_control.newCustomFieldLink);
		var drawNewTagText = (obj_control.newCustomTagToken || obj_control.newCustomTagUnit || obj_control.newCustomTagEntry || obj_control.newCustomTagChain || obj_control.newCustomTagChunk || obj_control.newCustomTagLink);
		
		if (drawNewFieldText) {
			titleText = scr_get_translation("option_new-field");
			descriptionText = scr_get_translation("search_custom-field");
		}
		else if (drawNewTagText) {
			titleText = scr_get_translation("msg_create_tag");
			descriptionText = scr_get_translation("search_custom-tag");
		}
		if (obj_control.ePressed) {
			titleText = scr_get_translation("Input Beggining Line");
			descriptionText = scr_get_translation("search_beginning-line");
		}
		
		if(obj_control.fPressed) {
			// draw background text
			if(obj_control.regExCheck){
				titleText = scr_get_translation("search_dialogue_regEx");
				descriptionText = scr_get_translation("msg_input_regex");
			}
			else{
				titleText = scr_get_translation("search_dialogue_word");
				descriptionText = scr_get_translation("search_dialogue_word");
			}
		}
		

	}
}
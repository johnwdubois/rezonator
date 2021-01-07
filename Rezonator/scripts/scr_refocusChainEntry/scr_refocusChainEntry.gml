// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_refocusChainEntry(wordID){
	
	// find which chain entry node this word is associated with, so we can refocus it
	if (ds_map_exists(global.nodeMap, obj_chain.currentFocusedChainID)) {
		var entryToFocus = "";
		var chainSubMap = ds_map_find_value(global.nodeMap, obj_chain.currentFocusedChainID);
		var chainEntryList = ds_map_find_value(chainSubMap, "setIDList");
		
		// loop through this chain's entry list to find the entry with the correct word
		var chainEntryListSize = ds_list_size(chainEntryList);
		for (var i = 0; i < chainEntryListSize; i++) {
			var currentChainEntry = ds_list_find_value(chainEntryList, i);
			var currentChainsetSubMap = ds_map_find_value(global.nodeMap, currentChainEntry);
			var currentChainEntryWordID = ds_map_find_value(currentChainsetSubMap, "word");
			if (wordID == currentChainEntryWordID) {
				entryToFocus = currentChainEntry;
			}
		}
		
		show_debug_message("scr_wordClicked() ... entryToFocus: " + string(entryToFocus));
		
		// if we have found the entry to focus, and it exists in the NodeMap, let's focus it!
		if (ds_map_exists(global.nodeMap, entryToFocus)) {
			show_debug_message("scr_wordClicked() ... focusing... ");
			ds_map_replace(chainSubMap, "focused", entryToFocus);
		}
	}

}
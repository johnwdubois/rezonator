function scr_getDropDownTagStr(option){
	
	var tagText = "";
	
	// check for tag text
	var isTagOption = string_count("Tag", option) > 0;
	if (isTagOption) {
		var isTokenOption = string_count("Token", option) > 0;
		var isUnitOption = string_count("Unit", option) > 0;
		var isChainOption = string_count("Chain", option) > 0;
		var isEntryOption = string_count("Entry", option) > 0;
		var isChunkOption = string_count("Chunk", option) > 0;
		var isTreeLinkOption = string_count("Link", option) > 0;
	
		var tagText = "";
		if(isTokenOption){
			tagText =  "   (" + string(obj_panelPane.functionField_tokenTagSelected) + " : " + string(obj_panelPane.functionField_tokenFieldSelected) + ")";
		}
		else if(isUnitOption){
			tagText =  "   (" + string(obj_panelPane.functionField_unitTagSelected) + " : " + string(obj_panelPane.functionField_unitFieldSelected) + ")";
		}
		else if(isChainOption){
			tagText =  "   (" + string(obj_panelPane.functionField_chainTagSelected) + " : " + string(obj_panelPane.functionField_chainFieldSelected) + ")";
		}
		else if(isEntryOption){
			tagText =  "   (" + string(obj_panelPane.functionField_entryTagSelected) + " : " + string(obj_panelPane.functionField_entryFieldSelected) + ")";
		}
		else if(isChunkOption){
			tagText =  "   (" + string(obj_panelPane.functionField_chunkTagSelected) + " : " + string(obj_panelPane.functionField_chunkFieldSelected) + ")";
		}
		else if(isTreeLinkOption){
			tagText =  "   (" + string(obj_panelPane.functionField_linkFieldSelected) + " : " + string(obj_panelPane.functionField_linkTagSelected) + ")";
		}
	}
	
	return tagText;
}
function scr_renameClique(_cliqueID, _name){
	
	// get clique submap, set clique name
	if (scr_isNumericAndExists(global.cliqueMap, ds_type_map)) {
		var cliqueSubMap = global.cliqueMap[? _cliqueID];
		if (scr_isNumericAndExists(cliqueSubMap, ds_type_map)) {
			cliqueSubMap[? "name"] = _name;
		}
	}

}
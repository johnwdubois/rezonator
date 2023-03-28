function scr_generateRandomID() {
	
	// generate a random string
	var str = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
	var ID = "";
	for (var i = 0; i < 11; i++) {
		ID += string_char_at(str, irandom_range(1, string_length(str)));
	}
	
	// continue generating random hex strings until we find one that is not
	// already a key in the NodeMap
	if (ds_map_exists(global.nodeMap, ID) || ds_map_exists(global.searchMap, ID) || ds_map_exists(global.treeMap, ID)  || ds_map_exists(global.cliqueMap, ID) || ds_map_exists(global.stackingMap, ID)) {
		ID = scr_generateRandomID();
	}
	
	return ID;

}
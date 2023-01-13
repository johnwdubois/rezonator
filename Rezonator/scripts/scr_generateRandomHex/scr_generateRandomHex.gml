function scr_generateRandomHex(){
	
	// generate a random number and turn it into a hex string
	var hexMin = 100;
	var hexMax = 100000000;
	var hex = irandom_range(hexMin, hexMax);
	hex = scr_baseConvert(hex, 10, 16);
	
	// continue generating random hex strings until we find one that is not
	// already a key in the NodeMap
	while (ds_map_exists(global.nodeMap, hex) || ds_map_exists(global.searchMap, hex) || ds_map_exists(global.treeMap, hex)  || ds_map_exists(global.cliqueMap, hex)) {
		hex = irandom_range(hexMin, hexMax);
		hex = scr_baseConvert(hex, 10, 16);
	}
	
	return hex;

}
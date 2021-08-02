// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_generateRandomHex(){
	
	// generate a random number and turn it into a hex string
	var hexMin = 1000;
	var hexMax = 1000000000000000;
	var hex = irandom_range(hexMin, hexMax);
	hex = scr_baseConvert(hex, 10, 16);
	
	// continue generating random hex strings until we find one that is not
	// already a key in the NodeMap
	while (ds_map_exists(global.nodeMap, hex) || ds_map_exists(global.searchMap, hex) || ds_map_exists(global.treeMap, hex)) {
		hex = irandom_range(hexMin, hexMax);
		hex = scr_baseConvert(hex, 10, 16);
	}
	
	return hex;

}
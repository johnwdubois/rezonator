// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_splitToken(splitTokenID){
	show_debug_message("Reached splitToken... splitTokenID = " + splitTokenID)
	var splitTokenSubmap = global.nodeMap[?splitTokenID];
	var splitTokenTagmap = splitTokenSubmap[?"tagMap"];
	var splitTokenText = splitTokenTagmap[?global.displayTokenField]
	
	
	if(!instance_exists(obj_dialogueBox)){
		instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
		obj_dialogueBox.inputWindowActive = true;
		global.inputBoxDefStr = splitTokenText;
		obj_control.splitToken = true;
	}
	
	
	
}
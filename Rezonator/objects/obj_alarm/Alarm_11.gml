///@description right click on mainscreen
var subMap  = global.nodeMap[?obj_control.rightClickID];
if(!scr_isNumericAndExists(subMap, ds_type_map)){exit;}
var IDType = subMap[?"type"];
if(IDType == "token"){
	scr_tokenRightClicked();
}
if(IDType == "chunk"){
	scr_chunkRightClicked();
}
if(IDType == "unit"){
	scr_unitRightClicked();
}
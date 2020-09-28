///@description End Chain Use
// End chain adding/use
if(!obj_control.dialogueBoxActive){
	
	if((obj_control.stackShowActive and (currentFocusedChainIndex > -1)) and global.wheresElmo) {
		scr_goldStandard();
	}
	var shouldExit = false;
	if(instance_exists(obj_dialogueBox)){
		if(obj_dialogueBox.combineChains){
			shouldExit = true;	
		}
	}
	if(shouldExit){
		exit;
	}
	
	
	
	scr_chainDeselect();

	scr_refreshVizLinkGrid();
}
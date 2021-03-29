///@description End Chain Use
// End chain adding/use
if(!obj_control.dialogueBoxActive){
	
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
}
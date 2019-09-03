///@description End Chain Use
// End chain adding/use
if(!obj_control.dialogueBoxActive){
	if((obj_control.stackShowActive and (currentFocusedChainIndex > -1)) and global.wheresElmo) {
		scr_goldStandard();
	}
	
	scr_chainDeselect();

	scr_refreshVizLinkGrid();
}
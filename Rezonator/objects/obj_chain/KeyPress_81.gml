///@description End Chain Use
// End chain adding/use
if(keyboard_check(vk_control)) {
	obj_chain.showChainArrows = !obj_chain.showChainArrows;
}
else {
	if(!obj_control.dialogueBoxActive){
		scr_chainDeselect();
	}
}
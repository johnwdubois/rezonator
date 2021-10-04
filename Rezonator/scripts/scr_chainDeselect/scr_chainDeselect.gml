function scr_chainDeselect() {
	if(instance_exists(obj_dropDown)){show_debug_message("scr_chainDeselect() but drop down exists");exit;}
	
	show_debug_message("scr_chainDeselect()");
	obj_chain.currentFocusedChainID = "";
	obj_chain.dragStartOriginalChain = "";
	obj_chain.dragStartOriginalUnit = "";
	
	// if there is a chain being shown in chainContents, we will make sure it does not have a focused entry
	with (obj_panelPane) {
		//functionChainContents_showID = "";
	}
	
	

}

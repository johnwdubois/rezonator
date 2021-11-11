// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_1to1Options(optionSelected){
	
	var leftPaneInst = -1;
	var rightPaneInst = -1;
	with (obj_panelPane) {
		if (currentFunction == functionChainList) leftPaneInst = self.id;
		if (currentFunction == functionChainContents) rightPaneInst = self.id;
	}
	
	
	
	
	if (optionSelected == "option_one-to-one") {
		
		with (obj_panelPane) chainViewOneToMany = false;
		if (instance_exists(leftPaneInst)) {
			with (rightPaneInst) {
				scrollPlusY = leftPaneInst.scrollPlusY;
				scrollPlusYDest = leftPaneInst.scrollPlusYDest;
			}
		}
	}
	else if (optionSelected == "option_one-to-many") {
		
		with (obj_panelPane) chainViewOneToMany = true;
		if (instance_exists(rightPaneInst)) {
			with (leftPaneInst) {
				scrollPlusY = rightPaneInst.scrollPlusY;
				scrollPlusYDest = rightPaneInst.scrollPlusYDest;
			}
		}
	}
	
}
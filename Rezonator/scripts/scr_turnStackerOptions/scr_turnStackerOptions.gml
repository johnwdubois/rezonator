function scr_turnStackerOptions(optionSelected) {
	
	var confirmStack = false;
	var stackChainList = global.nodeMap[? "stackList"];
	var doStacksExist = (ds_list_size(stackChainList) > 0);
	
	if (optionSelected == "From participant labels") {
		obj_stacker.stackerMode = "participant";
		if (doStacksExist) confirmStack = true;
	}
	else if (optionSelected == "From turn delimiter") {
		obj_stacker.stackerMode = "menu_turn";
		if (doStacksExist) confirmStack = true;
	}
	
	obj_stacker.confirmStackName = true;

	with (obj_dropDown) instance_destroy();

}
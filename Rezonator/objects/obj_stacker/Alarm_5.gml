/// @description Call Stacker Loops
show_debug_message("obj_stacker Alarm 5");

// Determine which Stacks to genreate
switch (currentStackerFuntion) {
	case stackerFunctionRandom:
		obj_control.activeStacking = "Random";
		scr_randomStackerLoop();
		break;
		
	case stackerFunctionTurn:
		obj_control.activeStacking = "menu_turn";
		scr_turnStackerLoop();
		break;
		
	case stackerFunctionSent:
		obj_control.activeStacking = "Sentence";
		scr_sentStackerLoop();
		break;
		
	case stackerFunctionGroup:
		obj_control.activeStacking = "Group";
		scr_groupStackerLoop();
		scr_destroyEmptyLayers("stack");
		break;
		
	case stackerFunctionPsent:
		obj_control.activeStacking = "pSent";
		scr_psentStackerLoop();
		break;
		
	case stackerFunctionConllu:
		scr_importConlluAutotag();
		break;
	default:
		break;
}
currentStackerFuntion = stackerFunctionDefault;
obj_control.activeStacking = scr_findDefaultLayer(global.stackingMap);
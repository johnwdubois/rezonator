/// @description Call Stacker Loops
show_debug_message("obj_stacker Alarm 5");

// Determine which Stacks to genreate
switch (currentStackerFuntion) {
	case stackerFunctionRandom:
		obj_control.activeStackType = "Random";
		scr_randomStackerLoop();
		break;
		
	case stackerFunctionTurn:
		obj_control.activeStackType = "Turn";
		scr_turnStackerLoop();
		break;
		
	case stackerFunctionSent:
		obj_control.activeStackType = "Sentence";
		scr_sentStackerLoop();
		break;
		
	case stackerFunctionGroup:
		obj_control.activeStackType = "Group";
		scr_groupStackerLoop();
		break;
		
	default:
		break;
}
currentStackerFuntion = stackerFunctionDefault;
obj_control.activeStackType = "Default";
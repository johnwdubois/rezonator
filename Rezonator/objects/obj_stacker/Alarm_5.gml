/// @description Call Stacker Loops
show_debug_message("obj_stacker Alarm 5");

// Determine which Stacks to genreate
switch (currentStackerFuntion) {
	case stackerFunctionRandom:
		scr_randomStackerLoop();
		break;
		
	case stackerFunctionTurn:
		scr_turnStackerLoop();
		break;
		
	case stackerFunctionSent:
		scr_sentStackerLoop();
		break;
		
	case stackerFunctionGroup:
		scr_groupStackerLoop();
		break;
		
	default:
		break;
}
currentStackerFuntion = stackerFunctionDefault;
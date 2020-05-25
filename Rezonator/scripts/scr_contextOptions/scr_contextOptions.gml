//contextOptions
var optionSelected = argument0;

switch (optionSelected)
{
	case "Prior":// show/hide prior context
		obj_chain.focusPrior = !obj_chain.focusPrior;
	break;
	case "Tween":// show/hide tween context
		obj_chain.focusTween = !obj_chain.focusTween;
	break;
	case "Next":// hide/show next context
		obj_chain.focusNext = !obj_chain.focusNext;
	break;
	default:
	break;
	
}
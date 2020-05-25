//hideOptions
var optionSelected = argument0;

switch (optionSelected)
{
	case "Track":// hide/show track chains
		obj_chain.toggleDrawTrack = !obj_chain.toggleDrawTrack;
	break;
	case "Rez":// hide/show rez chains
		obj_chain.toggleDrawRez = !obj_chain.toggleDrawRez;
	break;
	case "Stack":// hide/show stack chains
		obj_chain.toggleDrawStack = !obj_chain.toggleDrawStack;
	break;
	case "Place":// hide/show place chains
		obj_chain.showPlaceChains = !obj_chain.showPlaceChains;	
	break;
	default:
	break;
	
}

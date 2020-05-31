//helpOptions
var optionSelected = argument0;

switch (optionSelected)
{
	case "Help":// hide/show track chains
		obj_panelPane.functionHelp_collapsed = !obj_panelPane.functionHelp_collapsed;
	break;
	case "Download":// hide/show rez chains
		url_open("https://rezonator.com/download/");
	break;
	case "About":// hide/show stack chains
		url_open("https://rezonator.com/");
	break;
	default:
	break;
}

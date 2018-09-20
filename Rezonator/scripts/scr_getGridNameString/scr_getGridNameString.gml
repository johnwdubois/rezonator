var colName = string(argument0);

switch (argument0)
{
	case obj_control.unitGrid:
		colName = "Unit";
		break;
	case obj_control.lineGrid:
		colName = "Line";
		break;
	case obj_control.wordGrid:
		colName = "Word";
		break;
	case obj_control.dynamicWordGrid:
		colName = "DynamicWord";
		break;
	case obj_control.filterGrid:
		colName = "Filter";
		break;
	case obj_control.searchGrid:
		colName = "Search";
		break;
	case obj_control.hitGrid:
		colName = "Hit";
		break;
	case obj_chain.linkGrid:
		colName = "Link";
		break;
	case obj_chain.rezChainGrid:
		colName = "RezChain";
		break;
	case obj_chain.trackChainGrid:
		colName = "TrackChain";
		break;
	case obj_chain.stackChainGrid:
		colName = "StackChain";
		break;
	case obj_chain.unitInStackGrid:
		colName = "UnitInStack";
		break;
	case obj_chain.cliqueGrid:
		colName = "Clique";
		break;
	default:
		break;
}

return colName;
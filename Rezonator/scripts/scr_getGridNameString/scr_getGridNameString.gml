var colName = string(argument0);

switch (argument0)
{
	case obj_control.unitGrid:
		colName = "unitGrid";
		break;
	case obj_control.lineGrid:
		colName = "lineGrid";
		break;
	case obj_control.wordGrid:
		colName = "wordGrid";
		break;
	case obj_control.dynamicWordGrid:
		colName = "dynamicWordGrid";
		break;
	case obj_control.filterGrid:
		colName = "filterGrid";
		break;
	case obj_control.searchGrid:
		colName = "searchGrid";
		break;
	case obj_control.hitGrid:
		colName = "hitGrid";
		break;
	case obj_chain.linkGrid:
		colName = "linkGrid";
		break;
	case obj_chain.rezChainGrid:
		colName = "rezChainGrid";
		break;
	case obj_chain.trackChainGrid:
		colName = "trackChainGrid";
		break;
	case obj_chain.stackChainGrid:
		colName = "stackChainGrid";
		break;
	case obj_chain.unitInStackGrid:
		colName = "unitInStackGrid";
		break;
	default:
		break;
}

return colName;
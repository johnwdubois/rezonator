var gridName = string(argument0);

switch (argument0) {
	case obj_control.unitGrid:
		gridName = "Unit";
		break;
	case obj_control.lineGrid:
		gridName = "Line";
		break;
	case obj_control.wordGrid:
		gridName = "Word";
		break;
	case obj_control.dynamicWordGrid:
		gridName = "DynamicWord";
		break;
	case obj_control.filterGrid:
		gridName = "Filter";
		break;
	case obj_control.searchGrid:
		gridName = "Search";
		break;
	case obj_control.hitGrid:
		gridName = "Hit";
		break;
	case obj_control.wordNewGrid:
		gridName = "WordNew";
		break;
	case obj_chain.linkGrid:
		gridName = "Link";
		break;
	case obj_chain.vizLinkGrid:
		gridName = "VizLink";
		break;
	case obj_chain.rezChainGrid:
		gridName = "RezChain";
		break;
	case obj_chain.trackChainGrid:
		gridName = "TrackChain";
		break;
	case obj_chain.stackChainGrid:
		gridName = "StackChain";
		break;
	case obj_chain.chunkGrid:
		gridName = "Box";
		break;
	case obj_chain.unitInStackGrid:
		gridName = "UnitInStack";
		break;
	case obj_chain.cliqueGrid:
		gridName = "Clique";
		break;
	case obj_chain.rezPlayLinkGrid:
		gridName = "RezPlayLink";
		break;
	default:
		break;
}

return gridName;
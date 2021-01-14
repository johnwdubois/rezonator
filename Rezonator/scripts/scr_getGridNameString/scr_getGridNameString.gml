function scr_getGridNameString(gridName) {
	// Store and return the strings of Grid names
	
	
	switch (gridName) {
		case obj_control.unitGrid:
			gridName = "Unit"; // Unit Grid
			break;
		case obj_control.lineGrid:
			gridName = "Line"; // Line Grid
			break;
		case obj_control.wordGrid:
			gridName = "Word"; // Word Grid
			break;
		case obj_control.dynamicWordGrid:
			gridName = "vizWord"; // dynamicWordGrid
			break;
		case obj_control.filterGrid:
			gridName = "Pick"; // Filter Grid
			break;
		case obj_control.searchGrid:
			gridName = "Search"; // searchGrid
			break;
		case obj_control.hitGrid:
			gridName = "Hit"; // hitGrid
			break;
		case obj_control.wordDrawGrid:
			gridName = "wordDrawGrid";
			break;
		case obj_chain.linkGrid:
			gridName = "Link"; // Link Grid 
			break;
		case obj_chain.rezPlayLinkGrid:
			gridName = "playLink"; // rezPlay Link Grid
			break;
		case obj_chain.vizLinkGrid:
			gridName = "vizLink"; // vizLink Grid
			break;
		case obj_chain.placeChainGrid:
			gridName = "Place"; // Place Chain Grid
			break;
		case obj_chain.chunkGrid:
			gridName = "Chunk"; // Chunk Grid
			break;
		case obj_chain.unitInStackGrid:
			gridName = "StackUnit"; // Unit In Stack
			break;
		case obj_chain.cliqueGrid:
			gridName = "Clique"; // Clique Grid
			break;
		case obj_chain.DepRelLinkGrid:
			gridName = "DepRelLink"; // vizClique
			break;
		case obj_chain.goldStandardGrid:
			gridName = "GoldStandard"; // vizClique
			break;
		case global.importGrid:
			gridName = "Import"; // Import Grid
			break;
		case obj_control.morphGrid:
			gridName = "Morph"; // Morph Grid
			break;
		case global.importCSVGrid:
			gridName = "ImportCSV"; // Import CSV Grid
			break;
		case global.tokenImportGrid:
			gridName = "TokenImport"; // Token Import Grid
			break;			
		case global.wordImportGrid:
			gridName = "WordImport"; // Word Import Grid
			break;		
		case global.unitImportGrid:
			gridName = "UnitImport"; // Unit Import Grid
			break;		
		case global.discoImportGrid:
			gridName = "DiscoImport"; // Discourse Import Grid
			break;		
		case global.customLabelGrid:
			gridName = "CustomLabel"; // Custom Label Grid
			break;
		case obj_control.quickFilterGrid:
			gridName = "QuickPick"; // Custom Label Grid
			break;
		default:
			gridName = string(gridName);
			break;
	}

	return gridName;


}

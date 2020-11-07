function scr_gridViewerSelectGridOptions(optionSelected) {


	// create a temp list called gridNameList to hold every gridName, then we can search that grid for optionSelected
	var gridNameList = ds_list_create();
	var gridList = ds_list_size(obj_gridViewer.gridList);
	for (var i = 0; i < gridList; i++) {
		var currentGrid = ds_list_find_value(obj_gridViewer.gridList, i);
		ds_list_add(gridNameList, scr_getGridNameString(currentGrid));
	}

	var optionSelectedIndex = ds_list_find_index(gridNameList, optionSelected);
	var gridSelected = ds_list_find_value(obj_gridViewer.gridList, optionSelectedIndex);

	obj_gridViewer.grid = gridSelected;

	ds_list_destroy(gridNameList);


	/*
	switch (optionSelected)
	{

	    case "Unit":
	        obj_gridViewer.grid = obj_control.unitGrid;
	        break;
	    case "Line":
	        obj_gridViewer.grid = obj_control.lineGrid;
	        break;
	    case "Word":
	        obj_gridViewer.grid = obj_control.wordGrid;
	        break;
	    case "VizWord":
	        obj_gridViewer.grid = obj_control.dynamicWordGrid;
	        break;
		case "Pick":
			obj_gridViewer.grid = obj_control.filterGrid;
			break;
		case "Search":
			obj_gridViewer.grid = obj_control.searchGrid;
			break;
		case "Hit":
			obj_gridViewer.grid = obj_control.hitGrid;
			break;
		case "wordDrawGrid":
			obj_gridViewer.grid = obj_control.wordDrawGrid;
			break;
		case "Link":
			obj_gridViewer.grid = obj_chain.linkGrid;
			break;
		case "playLink":
			obj_gridViewer.grid = obj_chain.rezPlayLinkGrid;
			break;
		case "vizLink":
			obj_gridViewer.grid = obj_chain.vizLinkGrid;
			break;
		case "Rez":
			obj_gridViewer.grid = obj_chain.rezChainGrid;
			break;
		case "Track":
			gridName = "Track"; // Track Chain Grid
			break;
		case "Stack":
			gridName = "Stack"; // Stack Chain Grid
			break;
		case "Place":
			gridName = "Place"; // Place Chain Grid
			break;
		case "Chunk":
			gridName = "Chunk"; // Chunk Grid
			break;
		case "StackUnit":
			gridName = "StackUnit"; // Unit In Stack
			break;
		case "Clique":
			gridName = "Clique"; // Clique Grid
			break;
		case "vizClique":
			gridName = "vizClique"; // vizClique
			break;
		case "DepRelLink":
			gridName = "DepRelLink"; // vizClique
			break;
		case "GoldStandard":
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
		case global.unitImportGrid:
			gridName = "UnitImport"; // Unit Import Grid
			break;		
		case global.customLabelGrid:
			gridName = "CustomLabel"; // Custom Label Grid
			break;
		
	    default:
	        break;
	}
	*/

	with(obj_dropDown){
	    instance_destroy();
	}






}

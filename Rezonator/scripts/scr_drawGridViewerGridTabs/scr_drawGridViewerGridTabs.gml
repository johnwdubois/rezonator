/*
	scr_drawGridViewerGridTabs(gridArrayIndex);
	
	Last Updated: 2018-09-11
	
	Called from: obj_gridViewer
	
	Purpose: draw the tabs showing all of the viewable grids for the gridViewer
	
	Mechanism: loop through a list of the viewable grids and draw tabs for each grid,
				and when the tab is clicked on, that is the grid to be shown
	
	Author: Terry DuBois
*/

draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_set_font(fnt_debug);

var rectWidth = windowWidth / ds_list_size(gridList);
var rectHeight = 20;

for (var i = 0; i < ds_list_size(gridList); i++) {
	var currentGrid = ds_list_find_value(gridList, i);
	
	var rectX1 = windowX + (i * rectWidth);
	var rectY1 = windowY - rectHeight;
	var rectX2 = rectX1 + rectWidth;
	var rectY2 = windowY;
	
	if (grid == currentGrid) {
		draw_set_color(obj_control.c_ltblue);
	}
	else {
		draw_set_color(global.colorThemeBG);
	}
	
	draw_rectangle(rectX1, rectY1, rectX2, rectY2, false);
	
	draw_set_color(global.colorThemeText);
	draw_rectangle(rectX1, rectY1, rectX2, rectY2, true);
	
	var colName = "";
	
	switch (currentGrid) {
		case obj_control.unitGrid:
			colName = "Unit"; // Unit Grid
			break;
		case obj_control.lineGrid:
			colName = "Line"; // Line Grid
			break;
		case obj_control.wordGrid:
			colName = "Word"; // Word Grid
			break;
		case obj_control.dynamicWordGrid:
			colName = "vizWord"; // dynamicWordGrid
			break;
		case obj_control.filterGrid:
			colName = "Pick"; // Filter Grid
			break;
		case obj_control.searchGrid:
			colName = "Search"; // searchGrid
			break;
		case obj_control.hitGrid:
			colName = "Hit"; // hitGrid
			break;
		case obj_control.wordDrawGrid:
			colName = "wordDrawGrid";
			break;
		case obj_chain.linkGrid:
			colName = "Link"; // Link Grid 
			break;
		case obj_chain.rezPlayLinkGrid:
			colName = "playLink"; // rezPlay Link Grid
			break;
		case obj_chain.vizLinkGrid:
			colName = "vizLink"; // vizLink Grid
			break;
		case obj_chain.rezChainGrid:
			colName = "Rez"; // Rez Chain Grid
			break;
		case obj_chain.trackChainGrid:
			colName = "Track"; // Track Chain Grid
			break;
		case obj_chain.stackChainGrid:
			colName = "Stack"; // Stack Chain Grid
			break;
		case obj_chain.placeChainGrid:
			colName = "Place"; // Place Chain Grid
			break;
		case obj_chain.chunkGrid:
			colName = "Chunk"; // Chunk Grid
			break;
		case obj_chain.unitInStackGrid:
			colName = "StackUnit"; // Unit In Stack
			break;
		case obj_chain.cliqueGrid:
			colName = "Clique"; // Clique Grid
			break;
		case obj_chain.cliqueDisplayGrid:
			colName = "vizClique"; // vizClique
			break;
		case obj_chain.DepRelLinkGrid:
			colName = "DepRelLink"; // vizClique
			break;
		default:
			break;
	}
	
	draw_text(rectX1 + 5, mean(rectY1, rectY2), colName);
	
	if (point_in_rectangle(mouse_x, mouse_y, rectX1, rectY1, rectX2, rectY2)) {
		if (mouse_check_button_pressed(mb_left)) {
			grid = currentGrid;
		}
	}
}
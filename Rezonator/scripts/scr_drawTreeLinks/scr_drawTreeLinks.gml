// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_drawTreeLinks(){
	
	var treeSubMap = global.treeMap[? obj_panelPane.functionTree_treeSelected];
	
	var linkList = treeSubMap[?"linkIDList"];
	
	var linkListSize = ds_list_size(linkList);
	for(var i = 0; i < linkListSize; i++){
		
		var currentLink = linkList[| i];
		var linkSubMap = global.treeMap[? currentLink];
		var source = linkSubMap[?"source"];
		var goal = linkSubMap[?"goal"];
		
		var sourceSubMap = global.treeMap[? source];
		var goalSubMap = global.treeMap[? goal];
		
		
		var arrowX1 = mean(sourceSubMap[? "entryX1"],sourceSubMap[? "entryX2"]);
		var arrowY1 = mean(sourceSubMap[? "entryY1"],sourceSubMap[? "entryY2"]);
		var arrowX2 = mean(goalSubMap[? "entryX1"],goalSubMap[? "entryX2"]);
		var arrowY2 = mean(goalSubMap[? "entryY1"],goalSubMap[? "entryY2"]);
		
		
		draw_set_alpha(1);
		draw_set_color(global.colorThemeBorders);
		draw_line_width(arrowX1-clipX,arrowY1-clipY,arrowX2-clipX,arrowY2-clipY,2);
	}
	
}
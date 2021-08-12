// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_deleteTreeLink(){
var treeSubMap = global.treeMap[? obj_panelPane.functionTree_treeSelected];
var linkSubMap = global.treeMap[? obj_panelPane.functionTree_treeLinkSelected];

var sourceEntry = linkSubMap[? "source"];
var goalEntry = linkSubMap[? "goal"];

var sourceEntrySubMap = global.treeMap[? sourceEntry];
scr_deleteFromList(sourceEntrySubMap[? "goalLinkList"], obj_panelPane.functionTree_treeLinkSelected);

var goalEntrySubMap = global.treeMap[? goalEntry];
goalEntrySubMap[? "sourceLink"] = "";
goalEntrySubMap[? "level"] = 0;


scr_deleteFromList(treeSubMap[? "linkIDList"],obj_panelPane.functionTree_treeLinkSelected);
ds_map_delete(global.treeMap, obj_panelPane.functionTree_treeLinkSelected);	
ds_map_destroy(linkSubMap);

scr_treeRefresh(treeSubMap);

}
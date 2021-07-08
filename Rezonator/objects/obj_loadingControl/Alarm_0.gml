/// @description Insert description here
// You can write your code in this editor
alarm[0] = fps;
var nodeMapSize = ds_map_size(global.nodeMap);
nodesPerSec = nodeMapSize - prevNodeMapSize;
prevNodeMapSize = nodeMapSize;
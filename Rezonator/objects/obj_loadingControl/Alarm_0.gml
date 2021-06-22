alarm[0] = fps;
var nodeMapSize = ds_map_size(global.nodeMap);
nodesPerSec = nodeMapSize - prevNodeMapSize;
prevNodeMapSize = nodeMapSize;
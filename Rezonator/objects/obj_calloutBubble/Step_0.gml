/// @description Insert description here
// You can write your code in this editor

if (followWordID < 0 or followWordID >= ds_grid_height(obj_control.dynamicWordGrid)) {
	exit;
}

var followWordPixelXTemp = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colPixelX, followWordID - 1);
if(followWordPixelXTemp == undefined) {
	instance_destroy();
	exit;
}
followWordUnit = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, followWordID - 1);
followWordRowInLineGrid = ds_grid_value_y(obj_control.currentActiveLineGrid, obj_control.lineGrid_colUnitID, 0, obj_control.lineGrid_colUnitID, ds_grid_height(obj_control.currentActiveLineGrid), followWordUnit);
if (followWordRowInLineGrid >= 0 and followWordRowInLineGrid < ds_grid_height(obj_control.currentActiveLineGrid)) {
	followWordPixelY = ds_grid_get(obj_control.currentActiveLineGrid, obj_control.lineGrid_colPixelY, followWordRowInLineGrid);
}
followWordString = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, followWordID - 1);

switch (currentBubbleDir) {
	case bubbleDirUp:
		followWordPixelX = followWordPixelXTemp + (followWordStringWidth / 2);
		x = followWordPixelX;
		y = followWordPixelY + arrowLength;
		break;
	case bubbleDirDown:
		followWordPixelX = followWordPixelXTemp + (followWordStringWidth / 2);
		x = followWordPixelX;
		y = followWordPixelY - arrowLength;
		break;
	case bubbleDirLeft:
		followWordPixelX = followWordPixelXTemp;
		x = followWordPixelX + arrowLength + bubbleWidth;
		y = followWordPixelY;
		break;
	case bubbleDirRight:
		followWordPixelX = followWordPixelXTemp + followWordStringWidth;
		x = followWordPixelX - arrowLength - bubbleWidth;
		y = followWordPixelY;
		break;
	default:
		break;
}



switch (destroyMethod) {
	case 0:
		if (ds_grid_get(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colFocused, followWordID - 1)) {
			show_debug_message("CALLOUT BUBBLE DESTROYED");
			instance_destroy();
		}
		break;
	default:
		break;
}
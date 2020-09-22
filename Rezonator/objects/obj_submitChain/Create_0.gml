/// @description Insert description here
// You can write your code in this editor
submitChainRectX1 = (camera_get_view_width(camera_get_active())/2) - 95;
submitChainRectY1 = camera_get_view_height(camera_get_active()) - 100;
submitChainRectX2 = (camera_get_view_width(camera_get_active())/2) + 95;
submitChainRectY2 = camera_get_view_height(camera_get_active());

submitChainButtonX1 = submitChainRectX1 + 10;
submitChainButtonY1 = (submitChainRectY2 / 2);
submitChainButtonX2 = submitChainRectX2 - 10;
submitChainButtonY2 = submitChainRectY2 - 10;

draw_set_font(fnt_main);
var standardHeight = string_height("A");
draw_set_font(global.fontMain);
var largeHeight = string_height("A");
var spriteRatio = largeHeight/standardHeight;
var spriteSize = 2 * spriteRatio;

var spriteWidth = sprite_get_width(spr_backArrow) * spriteSize;
var spriteHeight = sprite_get_height(spr_backArrow) * spriteSize;


var backArrowX = spriteWidth / 2;
var backArrowY = camera_get_view_height(view_camera[0]) - spriteHeight / 3;
//show_message("arrow");
draw_sprite_ext(spr_backArrow, 0, backArrowX, backArrowY, spriteSize, spriteSize, 0, global.colorThemeBorders, 1);

var backArrowRectX1 = backArrowX - spriteWidth / 2;
var backArrowRectY1 = backArrowY - spriteHeight / 2;
var backArrowRectX2 = backArrowRectX1 + spriteWidth;
var backArrowRectY2 = backArrowRectY1 + spriteHeight;

draw_set_colour(global.colorThemeBG);
draw_set_halign(fa_center);
draw_text((backArrowRectX1 + backArrowRectX2)/2, (backArrowRectY1 + backArrowRectY2)/2, "Back");


if (point_in_rectangle(mouse_x, mouse_y, backArrowRectX1, backArrowRectY1, backArrowRectX2, backArrowRectY2)) {
	
	draw_set_color(global.colorThemeBorders);
	draw_set_alpha(1);
	draw_rectangle(backArrowRectX1, backArrowRectY1, backArrowRectX2, backArrowRectY2, true);
	obj_control.mouseoverPanelPane = true;
	
	if (mouse_check_button_released(mb_left)) {
		if (obj_control.gridView) {
			obj_control.gridView = false;
		}
		// If we're not in grid view and there is a search, switch between the main and search screen
		else if (ds_grid_height(obj_control.searchGrid) > 0 and !obj_control.gridView) {
			with(obj_control) {
				// Switch back to either main or filter grids
				if(currentActiveLineGrid == searchGrid) { 
					searchGridActive = false;
		
					// Check to see which grid we're switching back into
					if(preSwitchLineGrid == filterGrid) {
						scr_renderFilter(); // Thankfully this script does a lot of work for us
					}
					else {
						currentActiveLineGrid = lineGrid;
					}
					preSwitchSearchDisplayRow = obj_control.scrollPlusYDest;//currentCenterDisplayRow;
		
					// Make sure we don't try to render a line that doesn't exist
					if(highlightedSearchRow > 0 && ds_grid_value_exists(preSwitchLineGrid, 0, 0, 0, ds_grid_height(preSwitchLineGrid), highlightedSearchRow)){
						var linePixelY = ds_grid_get(obj_control.lineGrid, obj_control.lineGrid_colPixelYOriginal, highlightedSearchRow);
						preSwitchDisplayRow = -linePixelY + (camera_get_view_height(view_camera[0]) / 2) - 100;
					}
					//currentCenterDisplayRow = preSwitchDisplayRow;
					obj_control.scrollPlusYDest = preSwitchDisplayRow;
		
					//wordLeftMarginDest = 170;
					with (obj_alarm) {
						alarm[0] = 5;
					}
				}
				// Give the user another way to leave the filter view
				else if(currentActiveLineGrid == filterGrid) { 
					// Exit the stackShow
					if(stackShowActive) {
						obj_control.currentStackShowListPosition = ds_list_size(obj_control.stackShowList)-1;
						scr_stackShow();
					}
					// Exit the plain filter
					else {
						// Remember the user's place
						if(obj_control.currentCenterDisplayRow >= 0 and obj_control.currentCenterDisplayRow < ds_grid_height(obj_control.filterGrid)) {
							obj_control.scrollPlusYDest = obj_control.prevCenterYDest;
						}
			
						// Switch to active grid
						obj_control.filterGridActive = false;
						obj_control.currentActiveLineGrid = obj_control.lineGrid
					}
		
					with (obj_alarm) {
						alarm[1] = 5;
					}
				}
			}
		}
		else if(obj_control.currentActiveLineGrid == obj_control.filterGrid) { 
			with(obj_control) {
				// Exit the stackShow
				if(stackShowActive) {
					obj_control.currentStackShowListPosition = ds_list_size(obj_control.stackShowList)-1;
					scr_stackShow();
				}
				// Exit the plain filter
				else {
					// Remember the user's place
					if(obj_control.currentCenterDisplayRow >= 0 and obj_control.currentCenterDisplayRow < ds_grid_height(obj_control.filterGrid)) {
						obj_control.scrollPlusYDest = obj_control.prevCenterYDest;
					}
			
					// Switch to active grid
					obj_control.filterGridActive = false;
					obj_control.currentActiveLineGrid = obj_control.lineGrid
				}
	
				with (obj_alarm) {
					alarm[1] = 5;
				}
			}
		}
	}
}
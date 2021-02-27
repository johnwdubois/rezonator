/// @description Insert description here
// You can write your code in this editor
var camWidth = camera_get_view_width(camera_get_active());

//scr_dropShadow(-10, 0, camWidth, menuHeight);

draw_set_alpha(1);
var firstheaderString = ds_grid_get(menuBarGrid, menuBarGrid_colString, 0);
scr_adaptFont(scr_get_translation(firstheaderString),"M");
menuHeight = string_height("0") * 1.35;

// draw menu bar
draw_set_colour(global.colorThemeBG);
draw_rectangle(0, 0, camWidth, menuHeight, false);
draw_set_colour(global.colorThemeBorders);
draw_rectangle(-1, -1, camWidth + 1, menuHeight, true);
mouseoverMenuBar = point_in_rectangle(mouse_x, mouse_y, -1, -1, camera_get_view_width(camera_get_active()) + 1, menuHeight);

	
//draw text fore boxes
draw_set_colour(global.colorThemeText);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
var xBuffer = 0;
var prevXBuffer = 0;


for (var menuHeaderLoop = 0; menuHeaderLoop < menuBarGridHeight; menuHeaderLoop++) {
	var headerString = ds_grid_get(menuBarGrid, menuBarGrid_colString, menuHeaderLoop);
	scr_adaptFont(scr_get_translation(headerString),"M");
	menuWidth = string_width(scr_get_translation(headerString))*1.5;
	prevXBuffer = xBuffer;
	xBuffer+= menuWidth;
	
	var menuHeaderRectX1 = prevXBuffer;
	var menuHeaderRectY1 = 0;
	var menuHeaderRectX2 = xBuffer;
	var menuHeaderRectY2 = menuHeight;
	
	if (point_in_rectangle(mouse_x, mouse_y, menuHeaderRectX1, menuHeaderRectY1, menuHeaderRectX2, menuHeaderRectY2)) {
		
		// draw hover rectangle
		var roundedRectBuffer = 4;
		draw_set_color(global.colorThemeSelected1);
		draw_set_alpha(1);
		draw_roundrect(menuHeaderRectX1 + roundedRectBuffer, menuHeaderRectY1 + roundedRectBuffer/2, menuHeaderRectX2 - roundedRectBuffer, menuHeaderRectY2 - roundedRectBuffer, false);
		
		obj_control.mouseoverPanelPane = true;		
		instance_destroy(obj_dropDown);
		
		if(mouse_check_button_released(mb_left) and menuClickedIn){
			menuClickedIn = false;
		}
		else if(mouse_check_button_released(mb_left) or menuClickedIn){
			menuClickedIn = true;
			
			ds_grid_set_region(menuBarGrid, menuBarGrid_colMouseOver, 0, menuBarGrid_colMouseOver, menuBarGridHeight, false);
			ds_grid_set(menuBarGrid, menuBarGrid_colMouseOver, menuHeaderLoop, true);
			
			var dropDownOptionList = ds_grid_get(menuBarGrid, menuBarGrid_colOptionList, menuHeaderLoop);
			if (ds_list_size(dropDownOptionList) > 0) {
				/*var dropDownInst = instance_create_depth(menuWidth * menuHeaderLoop, menuHeight, -999, obj_dropDown);
				dropDownInst.optionList = dropDownOptionList;
				dropDownInst.optionListType = ds_grid_get(menuBarGrid, menuBarGrid_colOptionListType, menuHeaderLoop);
					
				obj_control.ableToCreateDropDown = false;
				obj_control.alarm[0] = 2;*/
				scr_createDropDown(menuHeaderRectX1, menuHeight, dropDownOptionList, ds_grid_get(menuBarGrid, menuBarGrid_colOptionListType, menuHeaderLoop), true);
			}
		}
	}
	
	
	if (ds_grid_get(menuBarGrid, menuBarGrid_colMouseOver, menuHeaderLoop)) {
		draw_set_colour(global.colorThemeOutOfBounds);
		//draw_rectangle((menuWidth * menuHeaderLoop) - 1, -1, menuWidth * (menuHeaderLoop + 1), menuHeight, false);
		draw_rectangle(menuHeaderRectX1, menuHeaderRectY1, menuHeaderRectX2, menuHeaderRectY2, false);
		draw_set_colour(global.colorThemeText);
	}
	
	//draw_text(floor(mean(menuWidth * (menuHeaderLoop), menuWidth * (menuHeaderLoop + 1))), floor(mean(y, y + menuHeight)), headerString);
	draw_set_colour(global.colorThemeText);
	draw_text(floor(mean(menuHeaderRectX1, menuHeaderRectX2)), floor(mean(menuHeaderRectY1, menuHeaderRectY2)), scr_get_translation(headerString));
}

	
var fpsTextX = camera_get_view_width(camera_get_active()) - string_width("000");
var fpsTextY = menuHeight / 2;	
var spriteScale = 0.4;
var sizeOfSave = sprite_get_width(spr_saveWarning)*spriteScale;


var saveIconX1 = fpsTextX - (sizeOfSave/2);
var saveIconY1 = fpsTextY - (sizeOfSave/2);
var saveIconX2 =  fpsTextX + (sizeOfSave/2);
var saveIconY2 = fpsTextY + (sizeOfSave/2);
	
	
if (obj_control.showFPS) {
	if(obj_control.allSaved){
		fpsTextX = saveIconX1 - string_width("000");
	}
	draw_set_halign(fa_right);
	draw_set_valign(fa_middle);
	draw_text(fpsTextX, fpsTextY, "FPS: " + string(fps));
}



// show unsaved warning

draw_set_halign(fa_right);
draw_set_valign(fa_middle);


if(obj_control.allSaved){
	saveTextAlpha -= 0.01;
	saveTextAlpha = clamp(saveTextAlpha,0 ,1);
	draw_set_alpha(saveTextAlpha);	
	draw_text(fpsTextX,fpsTextY, "Saved!");
}
else{
	if (point_in_rectangle(mouse_x, mouse_y,saveIconX1,saveIconY1,saveIconX2,saveIconY2 )) {
		scr_createTooltip(saveIconX1 ,fpsTextY, "Unsaved Changes!", obj_tooltip.arrowFaceRight);
	}
	draw_sprite_ext(spr_saveWarning,0,fpsTextX,fpsTextY,spriteScale,spriteScale, 0,global.colorThemeText , 1)
	saveTextAlpha = 1;	
}

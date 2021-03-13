/// @description Insert description here
// You can write your code in this editor
var camWidth = camera_get_view_width(camera_get_active());

//scr_dropShadow(-10, 0, camWidth, menuHeight);

draw_set_alpha(1);
var firstheaderString = ds_grid_get(menuBarGrid, menuBarGrid_colString, 0);
scr_adaptFont(scr_get_translation(firstheaderString),"M");
menuHeight = string_height("0") * 1.35;

// draw menu bar
draw_set_colour(global.colorThemeRezPurple);
draw_rectangle(0, 0, camWidth, menuHeight, false);
mouseoverMenuBar = point_in_rectangle(mouse_x, mouse_y, -1, -1, camera_get_view_width(camera_get_active()) + 1, menuHeight);

	
//draw text fore boxes
draw_set_colour(global.colorThemeBG);
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
		draw_roundrect(menuHeaderRectX1 + roundedRectBuffer, menuHeaderRectY1 + roundedRectBuffer/2-20, menuHeaderRectX2 - roundedRectBuffer, menuHeaderRectY2 - roundedRectBuffer, false);
		
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
	
	draw_set_colour(c_white);
	if (ds_grid_get(menuBarGrid, menuBarGrid_colMouseOver, menuHeaderLoop)) {
		draw_set_colour(global.colorThemeBG);
		//draw_rectangle((menuWidth * menuHeaderLoop) - 1, -1, menuWidth * (menuHeaderLoop + 1), menuHeight, false);
		draw_rectangle(menuHeaderRectX1, menuHeaderRectY1-20, menuHeaderRectX2, menuHeaderRectY2, false);
		draw_set_colour(global.colorThemeText);
	}
	
	
	draw_text(floor(mean(menuHeaderRectX1, menuHeaderRectX2)), floor(mean(menuHeaderRectY1, menuHeaderRectY2)), scr_get_translation(headerString));
}


draw_set_halign(fa_center);
draw_set_valign(fa_middle);


var sizeOfButtons = menuHeight * 0.6

var maximizeX2 =  camera_get_view_width(camera_get_active()) - string_width("0");
var maximizeX1 = maximizeX2 - sizeOfButtons;
var maximizeY2 = y + menuHeight *.66  +sizeOfButtons/2;
var maximizeY1 = maximizeY2 - sizeOfButtons;


draw_set_color(c_white);

var mouseOverMax = point_in_circle(mouse_x, mouse_y,floor(mean(maximizeX1, maximizeX2)),floor(mean(maximizeY1, maximizeY2)),sizeOfButtons/2 );

draw_circle(floor(mean(maximizeX1, maximizeX2)),floor(mean(maximizeY1, maximizeY2)), sizeOfButtons/2 , true);

if(mouseOverMax){
	draw_circle(floor(mean(maximizeX1, maximizeX2)),floor(mean(maximizeY1, maximizeY2)), sizeOfButtons/2 , false);
	draw_set_color(global.colorThemeText);
	scr_createTooltip(floor(mean(maximizeX1, maximizeX2)), maximizeY2, "Maximize", obj_tooltip.arrowFaceUp);
	
	if(mouse_check_button_released(mb_left)){
		obj_panelPane.showNav = true;
		obj_panelPane.showNavRight = true;
		obj_panelPane.showNavLeft = true;
	}
}


scr_drawRectWidth(maximizeX1 +sizeOfButtons/4,maximizeY1+sizeOfButtons/4,maximizeX2 - sizeOfButtons/4, maximizeY2-sizeOfButtons/4, 2)




var minimizeY1 = maximizeY1
var minimizeX2 =  maximizeX1 - sizeOfButtons/2;
var minimizeX1 = minimizeX2 - sizeOfButtons
var minimizeY2 = maximizeY2

draw_set_color(c_white);

var mouseOverMin = point_in_circle(mouse_x, mouse_y,floor(mean(minimizeX1, minimizeX2)),floor(mean(minimizeY1, minimizeY2)),sizeOfButtons/2 );

draw_circle(floor(mean(minimizeX1, minimizeX2)),floor(mean(minimizeY1, minimizeY2)), sizeOfButtons/2, true);

if(mouseOverMin){
	draw_circle(floor(mean(minimizeX1, minimizeX2)),floor(mean(minimizeY1, minimizeY2)), sizeOfButtons/2 , false);
	draw_set_color(global.colorThemeText);
	scr_createTooltip(floor(mean(minimizeX1, minimizeX2)), minimizeY2, "Minimize", obj_tooltip.arrowFaceUp);
	if(mouse_check_button_released(mb_left)){
		obj_panelPane.showNav = false;
		obj_panelPane.showNavRight = false;
		obj_panelPane.showNavLeft = false;
	}
}

draw_text(floor(mean(minimizeX1, minimizeX2)),floor(mean(minimizeY1, minimizeY2) - menuHeight *.05), "-");


var spriteScale = 0.4;
var sizeOfSave = sprite_get_width(spr_saveWarning)*spriteScale;
var fpsTextY = y+ menuHeight *.66 ;	


var saveIconX2 =  minimizeX1- sizeOfButtons/2;
var saveIconX1 = saveIconX2 - sizeOfSave;
var saveIconY1 = fpsTextY - (sizeOfSave/2);
var saveIconY2 = fpsTextY + (sizeOfSave/2);



var fpsTextX = minimizeX1- sizeOfButtons;


draw_set_color(c_white);

if (obj_control.showFPS) {
	if(!obj_control.allSaved){
		fpsTextX = saveIconX1 - string_width("0");
	}
	draw_set_halign(fa_right);
	draw_set_valign(fa_middle);
	draw_text(saveIconX1, fpsTextY, "FPS: " + string(fps));
}






// show unsaved warning
draw_set_halign(fa_right);
draw_set_valign(fa_middle);

if(obj_control.allSaved){
	saveTextAlpha -= 0.01;
	saveTextAlpha = clamp(saveTextAlpha,0 ,1);
	draw_set_alpha(saveTextAlpha);	
	draw_text(saveIconX2,fpsTextY, "Saved!");
}
else{
	if (point_in_rectangle(mouse_x, mouse_y,saveIconX1,saveIconY1,saveIconX2,saveIconY2 )) {
		scr_createTooltip(saveIconX1,fpsTextY, "Unsaved Changes!", obj_tooltip.arrowFaceRight);
	}
	draw_sprite_ext(spr_saveWarning,0,floor(mean(saveIconX1, saveIconX2)) ,fpsTextY,spriteScale,spriteScale, 0,c_white , 1)
	saveTextAlpha = 1;	
}

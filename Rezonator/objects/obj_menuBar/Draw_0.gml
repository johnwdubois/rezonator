var camWidth = camera_get_view_width(camera_get_active());

// draw drop shadow if both nav windows are hidden
var drawDropShadow = true;
if (instance_exists(obj_panelPane)) {
	drawDropShadow = !obj_panelPane.showNav || (!obj_panelPane.showNavLeft && !obj_panelPane.showNavRight);
}
if (instance_exists(obj_control)) {
	if (drawDropShadow) scr_dropShadow(-10, 0, camWidth - global.toolPaneWidth, menuHeight);
}
else {
	if (drawDropShadow) scr_dropShadow(-10, 0, camWidth, menuHeight);
}

draw_set_alpha(1);
var firstheaderString = ds_grid_get(menuBarGrid, menuBarGrid_colString, 0);
scr_adaptFont(scr_get_translation(firstheaderString),"M");
menuHeight = string_height("0") * 1.35;

// draw menu bar
//draw_set_colour(global.colorThemeRezPurple);
draw_set_colour(make_color_rgb(125, 125, 128));
draw_rectangle(0, 0, camWidth, menuHeight, false);
mouseoverMenuBar = point_in_rectangle(mouse_x, mouse_y, -1, -1, camera_get_view_width(camera_get_active()) + 1, menuHeight);

	
//draw text fore boxes
draw_set_colour(global.colorThemeBG);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
var xBuffer = (global.userLangRTL) ? camWidth : 0;
var prevXBuffer = (global.userLangRTL) ? camWidth : 0;



for (var menuHeaderLoop = 0; menuHeaderLoop < menuBarGridHeight; menuHeaderLoop++) {
	var headerString = ds_grid_get(menuBarGrid, menuBarGrid_colString, menuHeaderLoop);
	scr_adaptFont(scr_get_translation(headerString),"M");
	menuWidth = string_width(scr_get_translation(headerString))*1.5;
	prevXBuffer = xBuffer;
	if (global.userLangRTL) {
		xBuffer -= menuWidth;
	}else {
		xBuffer += menuWidth;
	}
	var currentOptionListType = ds_grid_get(menuBarGrid, menuBarGrid_colOptionListType, menuHeaderLoop);
	
	var menuHeaderRectX1 = (global.userLangRTL) ? xBuffer : prevXBuffer;
	var menuHeaderRectY1 = 0;
	var menuHeaderRectX2 = (global.userLangRTL) ? prevXBuffer : xBuffer;
	var menuHeaderRectY2 = menuHeight;
	if (point_in_rectangle(mouse_x, mouse_y, menuHeaderRectX1, menuHeaderRectY1, menuHeaderRectX2, menuHeaderRectY2)) {
		var dropDownOptionList = ds_grid_get(menuBarGrid, menuBarGrid_colOptionList, menuHeaderLoop);
		// draw hover rectangle
		var roundedRectBuffer = 4;
		draw_set_color(global.colorThemeSelected1);
		draw_set_alpha(1);
		draw_roundrect(menuHeaderRectX1 + roundedRectBuffer, menuHeaderRectY1 + roundedRectBuffer/2-20, menuHeaderRectX2 - roundedRectBuffer, menuHeaderRectY2 - roundedRectBuffer, false);

		with (obj_control) {
			mouseoverPanelPane = true;	
		}

		
		with (obj_dropDown) {
			if (dropDownOptionList != optionList) {
				instance_destroy();	
			}
		}
		if (mouse_check_button_released(mb_left) and menuClickedIn) {
			menuClickedIn = false;
		}
		else if (mouse_check_button_released(mb_left) or menuClickedIn) {
			menuClickedIn = true;
			
			ds_grid_set_region(menuBarGrid, menuBarGrid_colMouseOver, 0, menuBarGrid_colMouseOver, menuBarGridHeight, false);
			ds_grid_set(menuBarGrid, menuBarGrid_colMouseOver, menuHeaderLoop, true);
			
			
			if (ds_list_size(dropDownOptionList) > 0 and instance_number(obj_dropDown) == 0) {
				if (global.userLangRTL) {
					scr_createDropDown(menuHeaderRectX2, menuHeight, dropDownOptionList, currentOptionListType, true);
				}
				else {
					scr_createDropDown(menuHeaderRectX1, menuHeight, dropDownOptionList, currentOptionListType, true);
				}
			}
		}
	}
	
	draw_set_colour(c_white);
	if (ds_grid_get(menuBarGrid, menuBarGrid_colMouseOver, menuHeaderLoop)) {
		draw_set_colour(global.colorThemeBG);
		draw_rectangle(menuHeaderRectX1, menuHeaderRectY1-20, menuHeaderRectX2, menuHeaderRectY2, false);
		draw_set_colour(global.colorThemeText);
	}
	
	if (!instance_exists(obj_dropDown)) {
		ds_grid_set(menuBarGrid, menuBarGrid_colMouseOver, menuHeaderLoop, false);
	}
	
	draw_text(floor(mean(menuHeaderRectX1, menuHeaderRectX2)), floor(mean(menuHeaderRectY1, menuHeaderRectY2)), scr_get_translation(headerString));
}


draw_set_halign(fa_center);
draw_set_valign(fa_middle);


var sizeOfButtons = menuHeight * 0.6

	var maximizeX2 = (global.userLangRTL) ? string_width("0") : camera_get_view_width(camera_get_active()) - string_width("0");
	var maximizeX1 = (global.userLangRTL) ? maximizeX2 + sizeOfButtons :  maximizeX2 - sizeOfButtons;
	var maximizeY2 = y + menuHeight *.66  +sizeOfButtons/2;
	var maximizeY1 = maximizeY2 - sizeOfButtons;


if (instance_exists(obj_control)) {
	draw_set_color(c_white);


	var mouseOverMax = point_in_circle(mouse_x, mouse_y,floor(mean(maximizeX1, maximizeX2)),floor(mean(maximizeY1, maximizeY2)),sizeOfButtons/2);

	draw_circle(floor(mean(maximizeX1, maximizeX2)),floor(mean(maximizeY1, maximizeY2)), sizeOfButtons/2 , true);

	if (mouseOverMax) {
		draw_circle(floor(mean(maximizeX1, maximizeX2)),floor(mean(maximizeY1, maximizeY2)), sizeOfButtons/2 , false);
		draw_set_color(global.colorThemeText);
		scr_createTooltip(floor(mean(maximizeX1, maximizeX2)), maximizeY2, scr_get_translation("option_maximize"), TOOLTIP_DIR_UP);
	
		if (mouse_check_button_released(mb_left)) {
			with (obj_panelPane) {
				showNav = true;
				showNavRight = true;
				showNavLeft = true;
			}
		}
	}

	if (global.userLangRTL) {
		scr_drawRectWidth(maximizeX1 - sizeOfButtons/4,maximizeY1+sizeOfButtons/4,maximizeX2 + sizeOfButtons/4, maximizeY2-sizeOfButtons/4, 2 , false)
	}else {
		scr_drawRectWidth(maximizeX1 +sizeOfButtons/4,maximizeY1+sizeOfButtons/4,maximizeX2 - sizeOfButtons/4, maximizeY2-sizeOfButtons/4, 2 , false)
	}

}


var minimizeY1 = maximizeY1;
var minimizeX2 = (global.userLangRTL) ? maximizeX1 + sizeOfButtons/2 : maximizeX1 - sizeOfButtons/2;
var minimizeX1 = (global.userLangRTL) ? minimizeX2 + sizeOfButtons : minimizeX2 - sizeOfButtons;
var minimizeY2 = maximizeY2;

if (instance_exists(obj_control)) {
	draw_set_color(c_white);

	var mouseOverMin = point_in_circle(mouse_x, mouse_y,floor(mean(minimizeX1, minimizeX2)),floor(mean(minimizeY1, minimizeY2)),sizeOfButtons/2);

	draw_circle(floor(mean(minimizeX1, minimizeX2)),floor(mean(minimizeY1, minimizeY2)), sizeOfButtons/2, true);

	if (mouseOverMin) {
		draw_circle(floor(mean(minimizeX1, minimizeX2)),floor(mean(minimizeY1, minimizeY2)), sizeOfButtons/2 , false);
		draw_set_color(global.colorThemeText);
		scr_createTooltip(floor(mean(minimizeX1, minimizeX2)), minimizeY2, scr_get_translation("option_minimize"), TOOLTIP_DIR_UP);
		if (mouse_check_button_released(mb_left)) {
			with (obj_panelPane) {
				showNav = false;
				showNavRight = false;
				showNavLeft = false;
			}
		}
	}

	draw_text(floor(mean(minimizeX1, minimizeX2)),floor(mean(minimizeY1, minimizeY2) - menuHeight *.05), "-");
}
var spriteScale = 0.4;
var sizeOfSave = sprite_get_width(spr_saveWarning)*spriteScale;


//lang button
var langString = string(global.lang_codes[|global.lang_index]);
var widthOfLang = string_width(langString);
var fpsTextY = y+ menuHeight *.66 ;	


var langTextX2 = (global.userLangRTL) ?  minimizeX1 + sizeOfButtons/2 : minimizeX1 - sizeOfButtons/2;
var langTextX1 = (global.userLangRTL) ? langTextX2 + widthOfLang : langTextX2 - widthOfLang;
var langTextY1 = fpsTextY - (sizeOfSave/2);
var langTextY2 = fpsTextY + (sizeOfSave/2);
draw_set_color(c_white);
var mouseOverLang = (global.userLangRTL) ? point_in_rectangle(mouse_x,mouse_y,langTextX2,langTextY1,langTextX1,langTextY2) : point_in_rectangle(mouse_x,mouse_y,langTextX1,langTextY1,langTextX2,langTextY2);
if (instance_exists(obj_dropDown)) mouseOverLang = false;
if (mouseOverLang) {
	//draw_set_color(global.colorThemeText);
	if (global.userLangRTL) {
		scr_createTooltip(langTextX2, mean(langTextY1,langTextY2), scr_get_translation("menu_language"),TOOLTIP_DIR_LEFT);
	}else {
		scr_createTooltip(langTextX1, mean(langTextY1,langTextY2), scr_get_translation("menu_language"),TOOLTIP_DIR_RIGHT);
	}
	if (mouse_check_button_released(mb_left)) {
		var dropDownOptionList = ds_list_create();
		ds_list_add(dropDownOptionList, "menu_language-en", "menu_language-ca", "menu_language-es", "menu_language-gu", "menu_language-he", "menu_language-hy", "menu_language-it", "menu_language-ja", "menu_language-kk", "menu_language-ru", "menu_language-vi", "menu_language-zh");
						
		if (ds_list_size(dropDownOptionList) > 0) {
			if (global.userLangRTL) {
				scr_createDropDown(langTextX2, langTextY2, dropDownOptionList, global.optionListTypeLanguage);
			}
			else {
				scr_createDropDown(langTextX1, langTextY2, dropDownOptionList, global.optionListTypeLanguage);
			}
		}
	}
}


draw_text(floor(mean(langTextX1, langTextX2)),floor(mean(langTextY1, langTextY2) - menuHeight *.05), string_upper(langString));




var saveIconX2 = (global.userLangRTL) ? langTextX1 + sizeOfButtons/2 : langTextX1- sizeOfButtons/2;
var saveIconX1 = (global.userLangRTL) ? saveIconX2 + sizeOfSave : saveIconX2 - sizeOfSave;
var saveIconY1 = fpsTextY - (sizeOfSave/2);
var saveIconY2 = fpsTextY + (sizeOfSave/2);





draw_set_color(c_white);
if (instance_exists(obj_control)) {
	if (obj_control.showFPS) {
		var fpsTextX = minimizeX1 - (sizeOfButtons * 8);
		draw_set_halign(fa_right);
		draw_set_valign(fa_middle);
		draw_text(fpsTextX, fpsTextY, "FPS: " + string(fps));
	}

	// show unsaved warning
	draw_set_halign(fa_right);
	draw_set_valign(fa_middle);


	if (obj_control.allSaved) {
		saveTextAlpha -= 0.01;
		saveTextAlpha = clamp(saveTextAlpha,0 ,1);
		draw_set_alpha(saveTextAlpha);	
		if (global.userLangRTL) {
			draw_text(saveIconX1 + string_width("0"), fpsTextY, scr_get_translation("Saved!"));   // felt too close to lang button, so I added string_width("0")
		}else {
			draw_text(saveIconX2,fpsTextY, scr_get_translation("Saved!"));
		}
	}
	else {
		if (global.userLangRTL) and point_in_rectangle(mouse_x, mouse_y,saveIconX2,saveIconY1,saveIconX1,saveIconY2 ) {
			scr_createTooltip(saveIconX1,fpsTextY, scr_get_translation("Unsaved Changes!"), TOOLTIP_DIR_LEFT);
		}else if (point_in_rectangle(mouse_x, mouse_y,saveIconX1,saveIconY1,saveIconX2,saveIconY2 )) {
			scr_createTooltip(saveIconX1,fpsTextY, scr_get_translation("Unsaved Changes!"), TOOLTIP_DIR_RIGHT);
		}
		draw_sprite_ext(spr_saveWarning,0,floor(mean(saveIconX1, saveIconX2)) ,fpsTextY,spriteScale,spriteScale, 0,c_white , 1)
		saveTextAlpha = 1;	
	}

	// draw filename if in browser
	if (BUILDTYPE == "Web") {
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		draw_set_color(c_white);
		draw_set_alpha(1);
		draw_text(floor(camWidth / 2), floor(mean(menuHeaderRectY1, menuHeaderRectY2)), string(global.html5RezFile));
	}
}

// size slider button
if (room != rm_aiChat) {
	var sizeIconX2 = saveIconX1 - (sizeOfButtons / 2);
	var sizeIconX1 = sizeIconX2 - sizeOfButtons;
	draw_set_alpha(1);
	draw_set_color(c_white);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text(floor(mean(sizeIconX1, sizeIconX2)), floor(mean(saveIconY1, saveIconY2)), "Aa");
	var mouseoverSizeIcon = point_in_rectangle(mouse_x, mouse_y, sizeIconX1, saveIconY1, sizeIconX2, saveIconY2);
	if (mouseoverSizeIcon) {
		scr_createTooltip(sizeIconX1, floor(mean(saveIconY1, saveIconY2)), scr_get_translation("msg_size-slider"), TOOLTIP_DIR_RIGHT);
		if (mouse_check_button_released(mb_left)) {
			if (!instance_exists(obj_sizeWindow)) {
				instance_create_layer(0, 0, "InstancesDialogue", obj_sizeWindow);
			}
		}
	}
}


// draw border if nav is collapsed
if (drawDropShadow) {
	draw_set_alpha(1);
	draw_set_color(global.colorThemeBorders);
	if (instance_exists(obj_control)) {
		draw_line(0, menuHeight, camWidth - global.toolPaneWidth, menuHeight);
	}
	else {
		draw_line(0, menuHeight, camWidth, menuHeight);
	}
}
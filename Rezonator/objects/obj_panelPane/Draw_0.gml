/*
	obj_panelPane: Draw
	
	Last Updated: 2019-02-14
	
	Called from: Every frame of the game
	
	Purpose: Create the visuals of the panel pane
	
	Mechanism: Draw the outlines, call the drawing functions of each window, and check for user's mouse in the panel pane
	
	Author: Terry DuBois
*/



if (obj_control.gridView and currentFunction != functionHelp) {
	exit;
}
if (not showAdvancedNav) {
	if(currentFunction == functionClique || currentFunction == functionGraphStats) {
		exit;	
	}
}
if (obj_control.hideAll) {
	exit;
}


// Set the original height as the file loads
/*if(current_time - obj_control.sessionStartTime < 2000) {
	originalWindowHeight = y;
}*/
// Allow hiding the Nav Window via setting each window's height to 2000
if(currentFunction != functionHelp) {
	if(showNav) {
		y = originalWindowHeight;	
	} 
}

//draw_set_alpha(1);
//draw_set_color(global.colorThemePaneBG);
//draw_rectangle(x, y, x + windowWidth, y + windowHeight, false);

switch (currentFunction) {
	case functionChainList:
		if(showNavLeft){
			draw_set_alpha(1);
			draw_set_color(global.colorThemePaneBG);
			draw_rectangle(x, y, x + windowWidth, y + windowHeight, false);

			scr_panelPane_drawChainListLoopClipped();
			scr_panelPane_drawChainTabs();
			if (device_mouse_check_button_released(0, mb_left) and point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + windowHeight)) {
				clickedIn = true;
			}
			if (device_mouse_check_button_released(0, mb_left) and not point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + windowHeight)) {
				clickedIn = false;
			}
			if(clickedIn) {
				draw_set_alpha(1);
				draw_set_color(global.colorThemeBorders);
				draw_rectangle(x+1, y+1, x + windowWidth-1, y + windowHeight-1, true);
				draw_rectangle(x+1, y+1, x + windowWidth-1, y + windowHeight-2, true);
			}
		}
		break;
	case functionChainContents:
		if(showNavRight){
			draw_set_alpha(1);
			draw_set_color(global.colorThemeBG);
			draw_rectangle(x, y, x + windowWidth, y + windowHeight, false);
			if (typeof(functionChainContents_BGColor) == "number") {
				if (functionChainContents_BGColor != global.colorThemeBG) {
					draw_set_alpha(0.1);
					draw_set_color(functionChainContents_BGColor);
					draw_rectangle(x, y, x + windowWidth, y + windowHeight, false);
				}
			}
			else {
				functionChainContents_BGColor = global.colorThemeBG;
			}
		
			if (!chainViewOneToMany && functionChainList_currentTab == functionChainList_tabStackBrush) {
				scr_panelPane_drawChainsOneToOne();
			}
			else {
				scr_panelPane_drawChainContentsLoopClipped();
			}
		
		
			// one-to-one or one-to-many
			if (functionChainList_currentTab == functionChainList_tabStackBrush) {
				
				draw_set_font(global.fontMain);
				draw_set_color(global.colorThemeText);
				draw_set_alpha(1);
				draw_set_halign(fa_right);
				draw_set_valign(fa_middle);
			
				var oneToManyRectX1 = x + windowWidth - 20 - sprite_get_width(spr_oneToOne);
				var oneToManyRectY1 = y + 4;
				var oneToManyRectX2 = x + windowWidth - 10;
				var oneToManyRectY2 = y + functionChainList_tabHeight - 4;
				var mouseoverOneToManyRect = scr_pointInRectangleClippedWindow(mouse_x, mouse_y, oneToManyRectX1, oneToManyRectY1, oneToManyRectX2, oneToManyRectY2);
				
				if (mouseoverOneToManyRect) {
					scr_createTooltip(mean(oneToManyRectX1, oneToManyRectX2), oneToManyRectY2, (chainViewOneToMany) ? "1-to-many" : "1-to-1", obj_tooltip.arrowFaceUp);
					draw_set_color(global.colorThemeSelected1);
					draw_rectangle(oneToManyRectX1, oneToManyRectY1, oneToManyRectX2, oneToManyRectY2, false);
					draw_set_color(global.colorThemeBorders);
					draw_rectangle(oneToManyRectX1, oneToManyRectY1, oneToManyRectX2, oneToManyRectY2, true);
					if (mouse_check_button_released(mb_left)) {
						with (obj_panelPane) {
							chainViewOneToMany = !chainViewOneToMany;
						}
					}
			
				}
				draw_sprite_ext(spr_oneToOne, (chainViewOneToMany) ? 0 : 1, floor(mean(oneToManyRectX1, oneToManyRectX2)), floor(mean(oneToManyRectY1, oneToManyRectY2)), 1, 1, 0, c_white, 1);
		
		
		
		
				if (device_mouse_check_button_released(0, mb_left) and point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + windowHeight)) {
					clickedIn = true;
				}
				if (device_mouse_check_button_released(0, mb_left) and not point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + windowHeight)) {
					clickedIn = false;
				}
				if (clickedIn) {
					draw_set_alpha(1);
					draw_set_color(global.colorThemeBorders);
					draw_rectangle(x+1, y+1, x + windowWidth-1, y + windowHeight-1, true);
					draw_rectangle(x+1, y+1, x + windowWidth-1, y + windowHeight-2, true);
				}
			}
		}
		break;
	case functionFilter:
		if(showNavLeft){
			draw_set_alpha(1);
			draw_set_color(global.colorThemePaneBG);
			draw_rectangle(x, y, x + windowWidth, y + windowHeight, false);

			scr_panelPane_drawFilter();
		}
		break;
	case functionSort:
			x = camera_get_view_width(camera_get_active())/2 - 100;
			y = camera_get_view_height(camera_get_active())/2 - 91;
		if (obj_menuBar.sortPaneOpen) {
			draw_set_alpha(1);
			draw_set_color(global.colorThemePaneBG);

			draw_rectangle(x, y, x + windowWidth, y + windowHeight, false);

			scr_panelPane_drawSort();
		}
		break;
	case functionSearch:
		draw_set_alpha(1);
		draw_set_color(global.colorThemePaneBG);
		draw_rectangle(x, y, x + windowWidth, y + windowHeight, false);

		scr_panelPane_drawSearch();
		break;
	case functionClique:
		if (showAdvancedNav) {
			draw_set_alpha(1);
			draw_set_color(global.colorThemePaneBG);
			draw_rectangle(x, y, x + windowWidth, y + windowHeight, false);

			scr_panelPane_drawClique();
		}
		break;
	case functionHelp:
		if(obj_panelPane.showNav) {
			if (obj_toolPane.showTool){
			
			draw_set_alpha(1);
			draw_set_color(global.colorThemePaneBG);
			draw_rectangle(x, y, x + windowWidth, y + windowHeight, false);

			scr_panelPane_drawHelp();
			}
		}
		if(not obj_control.scrollBarHolding) {
			alarm[6] = 1;	
		}
		else {
			scrollBarClickLock = true;	
		}
		if(obj_control.stackShowActive){
			scr_panelPane_drawTracker();
		}
		break;
	case functionGoToLine:
		draw_set_alpha(1);
		draw_set_color(global.colorThemePaneBG);
		

		x = camera_get_view_x(camera_get_active()) + (camera_get_view_width(camera_get_active()) / 2) - (windowWidth / 2);
		y = camera_get_view_y(camera_get_active()) + (camera_get_view_height(camera_get_active()) / 2) - (windowHeight / 2);
		draw_rectangle(x, y, x + windowWidth, y + windowHeight, false);

		scr_panelPane_drawGoToLine();
		break;
	case functionGraphStats:
		if (showAdvancedNav) {
			draw_set_alpha(1);
			draw_set_color(global.colorThemePaneBG);
			draw_rectangle(x, y, x + windowWidth, y + windowHeight, false);

			scr_panelPane_drawGraphStats();
		}
		break;
	case functionAudio:
		if (keyboard_check(vk_alt) and keyboard_check(vk_shift) and keyboard_check_pressed(ord("A"))) {
			//var audioFile = get_open_filename_ext("audio file|*.ogg", "", working_directory, "Open a discourse audio OGG file");
			//if (file_exists(audioFile)) {
			//	scr_setAllValuesInCol(obj_control.unitGrid, obj_control.unitGrid_colAudioFile, audioFile);
			//}
			functionAudio_show = !functionAudio_show;
		}
	
		windowWidth = camera_get_view_width(camera_get_active()) - global.scrollBarWidth;
		windowHeight = 84;
		x = 0;
		y = functionAudio_show ? camera_get_view_height(camera_get_active()) - windowHeight : camera_get_view_height(camera_get_active());
		draw_set_alpha(1);
		draw_set_color(global.colorThemePaneBG);
		draw_rectangle(x, y, x + windowWidth, y + windowHeight, false);
		if (y < camera_get_view_height(camera_get_active())) {
			scr_panelPane_drawAudio();
		}
		break;
	default:
		break;
}


if(obj_panelPane.showNav){

		draw_set_alpha(1);
		draw_set_color(global.colorThemeBorders);
		//if(currentFunction == functionSort && !obj_menuBar.sortPaneOpen){
	
		//}
		if(currentFunction == functionChainContents && !obj_panelPane.showNavRight){
	
		}
		else if(currentFunction == functionHelp && !obj_toolPane.showTool){
	
		}
		else if((currentFunction == functionChainList or currentFunction == functionFilter) && !obj_panelPane.showNavLeft){
	
		}
		else {
			
				
			draw_rectangle(x, y, x + windowWidth, y + windowHeight, true);
		}
}


var mouseover = false;// Checks mouseover for all panelPane windows
if (point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + windowHeight)) {
	mouseover = true;
}




if (device_mouse_check_button_released(0, mb_left) and mouseover
and not obj_control.gridView and not currentFunction == functionChainList and not currentFunction == functionChainContents)
{
	with (obj_chain)
	{
		scr_chainDeselect();
	}
}
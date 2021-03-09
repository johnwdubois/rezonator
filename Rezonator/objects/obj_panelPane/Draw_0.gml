/*
	Purpose: Create the visuals of the panel pane

*/

if (!obj_control.mouseoverPanelPane) {
	unitTagsHighlightRow = -1;
}
if (currentFunction != functionChainList) {
	if (point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + windowHeight)) {
		if (currentFunction == functionChainContents) {
			if (!obj_control.showUnitTags) {
				with (obj_panelPane) {
					unitTagsHighlightRow = -1;
				}
			}
		}
		else {
			with (obj_panelPane) {
				unitTagsHighlightRow = -1;
			}
		}
	}
}





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

var camWidth = camera_get_view_width(camera_get_active());
var camHeight = camera_get_view_height(camera_get_active());


switch (currentFunction) {
	case functionChainList:
		if(showNavLeft){
			draw_set_alpha(1);
			draw_set_color(global.colorThemePaneBG);
			draw_rectangle(x, y, x + windowWidth, y + windowHeight, false);
			
			scr_panelPane_drawChainListLoopClipped();
			
			clickedIn = point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + windowHeight);
			
			/*
			if(clickedIn) {
				draw_set_alpha(1);
				draw_set_color(global.colorThemeBorders);
				draw_rectangle(x+1, y+1, x + windowWidth-1, y + windowHeight-1, true);
				draw_rectangle(x+1, y+1, x + windowWidth-1, y + windowHeight-2, true);
			}
			*/
		}
		if(not obj_control.scrollBarHolding and not chainListPane.scrollBarHolding) {
			alarm[6] = 1;	
		}
		else {
			scrollBarClickLock = true;	
		}
		break;
	case functionChainContents:
		if (showNavRight) {
			draw_set_alpha(1);
			draw_set_color(global.colorThemeBG);
			draw_rectangle(x, y, x + windowWidth, y + windowHeight, false);
			if (is_numeric(functionChainContents_BGColor)) {
				// if we are on the line tab, set the BG color to be regular
				if (functionChainList_currentTab == functionChainList_tabLine) {
					functionChainContents_BGColor = global.colorThemeBG;
				}
				// if the BG color is not regular, draw a rectangle with the color of the corresponding chain
				if (functionChainContents_BGColor != global.colorThemeBG) {
					draw_set_alpha(1);
					draw_set_color(merge_color(functionChainContents_BGColor, global.colorThemeBG, 0.9));
					draw_rectangle(x, y, x + windowWidth, y + windowHeight, false);
				}
			}
			else {
				functionChainContents_BGColor = global.colorThemeBG;
			}
		
			if (!chainViewOneToMany && functionChainList_currentTab != functionChainList_tabLine) {
				scr_panelPane_drawChains1To1();
			}
			else {
				scr_panelPane_drawChains1ToMany();
			}
			
			
			clickedIn = point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + windowHeight);
			/*
			if (clickedIn) {
				draw_set_alpha(1);
				draw_set_color(global.colorThemeBorders);
				draw_rectangle(x+1, y+1, x + windowWidth-1, y + windowHeight-1, true);
				draw_rectangle(x+1, y+1, x + windowWidth-1, y + windowHeight-2, true);
			}
			*/
			
			
		}
		if(not obj_control.scrollBarHolding and not scrollBarHolding) {
			alarm[6] = 1;	
		}
		else {
			scrollBarClickLock = true;	
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
				
				/*
				draw_set_alpha(1);
				draw_set_color(global.colorThemePaneBG);
				draw_rectangle(x, y, x + windowWidth, y + windowHeight, false);
				*/
				scr_panelPane_drawHelp();
				
			}
		}
		if(not obj_control.scrollBarHolding and not scrollBarHolding) {
			alarm[6] = 1;	
		}
		else {
			scrollBarClickLock = true;	
		}
		if(obj_control.stackShowActive){
			scr_panelPane_drawTracker();
		}
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
		if (keyboard_check(vk_control) and keyboard_check_pressed(ord("A"))) {
			//var audioFile = get_open_filename_ext("audio file|*.ogg", "", working_directory, "Open a discourse audio OGG file");
			//if (file_exists(audioFile)) {
			//	scr_setAllValuesInCol(obj_control.unitGrid, obj_control.unitGrid_colAudioFile, audioFile);
			//}
			functionAudio_show = !functionAudio_show;
		}
	
		windowWidth = camWidth - global.scrollBarWidth;
		windowHeight = 84;
		x = 0;
		y = functionAudio_show ? camHeight - windowHeight : camHeight;
		draw_set_alpha(1);
		draw_set_color(global.colorThemePaneBG);
		draw_rectangle(x, y, x + windowWidth, y + windowHeight, false);
		if (y < camHeight) {
			scr_panelPane_drawAudio();
		}
		break;
	case functionTabs:
	
		draw_set_color(global.colorThemeBG);
		draw_rectangle(x, y, x + windowWidth, y + windowHeight, false);
		
		windowWidth = camWidth;
		windowHeight = (functionTabs_tabHeight * 2);
		scr_panelPane_drawTabs();
		
		break;
	default:
		break;
}


if(obj_panelPane.showNav){

	draw_set_alpha(1);
	draw_set_color(global.colorThemeBorders);
	
	var showBorder = !((currentFunction == functionChainContents && !obj_panelPane.showNavRight)
					|| (currentFunction == functionHelp)
					|| ((currentFunction == functionChainList or currentFunction == functionFilter) && !obj_panelPane.showNavLeft));

	if (showBorder) {
		draw_rectangle(x, y, x + windowWidth, y + windowHeight, true);
	}
}


// Checks mouseover for all panelPane windows
var mouseover = point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + windowHeight);


if (device_mouse_check_button_released(0, mb_left) and mouseover
and not obj_control.gridView and not currentFunction == functionChainList and not currentFunction == functionChainContents)
{
	with (obj_chain)
	{
		scr_chainDeselect();
	}
}
/*
	obj_panelPane: Draw
	
	Last Updated: 2019-02-14
	
	Called from: Every frame of the game
	
	Purpose: Create the visuals of the panel pane
	
	Mechanism: Draw the outlines, call the drawing functions of each window, and check for user's mouse in the panel pane
	
	Author: Terry DuBois
*/

if (obj_control.gridView) {
	exit;
}


// Set the original height as the file loads
if(current_time - obj_control.sessionStartTime < 2000) {
	originalWindowHeight = y;
}
// Allow hiding the Nav Window via setting each window's height to 2000
else if(currentFunction != functionHelp) {
	if(showNav) {
		y = originalWindowHeight;	
	} 
	else {
		y = collapsedWindowHeight;	
	}
}

//draw_set_alpha(1);
//draw_set_color(global.colorThemePaneBG);
//draw_rectangle(x, y, x + windowWidth, y + windowHeight, false);

switch (currentFunction) {
	case functionChainList:
		draw_set_alpha(1);
		draw_set_color(global.colorThemePaneBG);
		draw_rectangle(x, y, x + windowWidth, y + windowHeight, false);

		scr_panelPane_drawChainListLoopClipped();
		scr_panelPane_drawChainTabs();
		if (mouse_check_button_pressed(mb_left) and point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + windowHeight)) {
			clickedIn = true;
		}
		if (mouse_check_button_pressed(mb_left) and not point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + windowHeight)) {
			clickedIn = false;
		}
		if(clickedIn) {
			draw_set_alpha(1);
			draw_set_color(global.colorThemeBorders);
			draw_rectangle(x+1, y+1, x + windowWidth-1, y + windowHeight-1, true);
			draw_rectangle(x+1, y+1, x + windowWidth-1, y + windowHeight-2, true);
		}
		break;
	case functionChainContents:
		draw_set_alpha(1);
		draw_set_color(global.colorThemePaneBG);
		draw_rectangle(x, y, x + windowWidth, y + windowHeight, false);

		scr_panelPane_drawChainContentsLoopClipped();
		if (mouse_check_button_pressed(mb_left) and point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + windowHeight)) {
			clickedIn = true;
		}
		if (mouse_check_button_pressed(mb_left) and not point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + windowHeight)) {
			clickedIn = false;
		}
		if (clickedIn) {
			draw_set_alpha(1);
			draw_set_color(global.colorThemeBorders);
			draw_rectangle(x+1, y+1, x + windowWidth-1, y + windowHeight-1, true);
			draw_rectangle(x+1, y+1, x + windowWidth-1, y + windowHeight-2, true);
		}
		break;
	case functionFilter:
		draw_set_alpha(1);
		draw_set_color(global.colorThemePaneBG);
		draw_rectangle(x, y, x + windowWidth, y + windowHeight, false);

		scr_panelPane_drawFilter();
		break;
	case functionSort:
		if (showAdvancedNav) {
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
		draw_set_alpha(1);
		draw_set_color(global.colorThemePaneBG);
		draw_rectangle(x, y, x + windowWidth, y + windowHeight, false);

		scr_panelPane_drawHelp();
		if(obj_control.stackShowActive){
			scr_panelPane_drawTracker();
		}
		break;
	case functionGoToLine:
		draw_set_alpha(1);
		draw_set_color(global.colorThemePaneBG);
		

		x = camera_get_view_x(view_camera[0]) + (camera_get_view_width(view_camera[0]) / 2) - (windowWidth / 2);
		y = camera_get_view_y(view_camera[0]) + (camera_get_view_height(view_camera[0]) / 2) - (windowHeight / 2);
		draw_rectangle(x, y, x + windowWidth, y + windowHeight, false);

		scr_panelPane_drawGoToLine();
		break;
	case functionGraphStats:
		draw_set_alpha(1);
		draw_set_color(global.colorThemePaneBG);
		draw_rectangle(x, y, x + windowWidth, y + windowHeight, false);

		scr_panelPane_drawGraphStats();
		break;
	default:
		break;
}





draw_set_alpha(1);
draw_set_color(global.colorThemeBorders);
draw_rectangle(x, y, x + windowWidth, y + windowHeight, true);



var mouseover = false;// Checks mouseover for all panelPane windows
if (point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + windowHeight))
{
	mouseover = true;
}




if (mouse_check_button_pressed(mb_left) and mouseover
and not obj_control.gridView and not currentFunction == functionChainList and not currentFunction == functionChainContents)
{
	with (obj_chain)
	{
		scr_chainDeselect();
	}
}
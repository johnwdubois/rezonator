
/*
	scr_panelPane_drawTracker();
	
	Last Updated: 2019-07-06
	
	Called from: obj_panelPane
	
	Purpose: alllows user to access time taken and moves used information
	
	Mechanism: draws a clickable rectangle that will expand upwards from the bottom corner of the screen
	displaying the movecounter and time taken as well as a reset button.
				
	Author: Brady Moore
*/

var Xdistance = 100;
var Ydistance = 30;
var newYheight = 80;
var newYheightText1 = 95;
var newYheightText2 = 75;
var newYheightText3 = 50;
var resetX1val = 80;
var resetX2val = 20;
var resetY1val = 60;
var resetY2val = 40;

var Yheightbuffer = 10;
var oldYheight = 0;

//convert seconds into displayable seconds
var displaySeconds = string(timerSecs); 
var displayMinutes = string(timerMins);

if(string_length(displaySeconds)<2){
	 displaySeconds = string_insert("0",displaySeconds, 0);
}
if (showTracker) {
	
	draw_set_alpha(1);
	//if(not isTrackerOpen) {draw_set_alpha(0);}
	// draw hidden stuff first y value will be changed if clicked on
	draw_set_halign(fa_left);
	draw_set_colour(global.colorThemeBG);
	draw_rectangle(camera_get_view_width(view_camera[0]) - Xdistance, camera_get_view_height(view_camera[0]) - Ydistance  - currentYheight, camera_get_view_width(view_camera[0]), camera_get_view_height(view_camera[0]), false);
	draw_set_colour(global.colorThemeBorders);
	draw_rectangle(camera_get_view_width(view_camera[0]) - Xdistance, camera_get_view_height(view_camera[0]) - Ydistance  - currentYheight, camera_get_view_width(view_camera[0]), camera_get_view_height(view_camera[0]), true);

	// move counter text
	draw_set_font(fnt_panelTab);
	draw_set_color(global.colorThemeText);
	draw_text(camera_get_view_width(view_camera[0]) - Xdistance + 5, camera_get_view_height(view_camera[0]) - currentYheightCounterText, "Move Counter: "+ string(obj_control.moveCounter) +"");
	
	// timer text
	draw_set_font(fnt_panelTab);
	draw_set_color(global.colorThemeText);
	draw_text(camera_get_view_width(view_camera[0]) - Xdistance + 5, camera_get_view_height(view_camera[0]) - currentYheightTimerText, "Time Taken: "+ displayMinutes + ":"+ displaySeconds );
	

	// reset button
	draw_set_halign(fa_left);
	draw_set_colour(global.colorThemeBG);
	draw_rectangle(camera_get_view_width(view_camera[0]) - resetX1val, camera_get_view_height(view_camera[0]) - currentResetY1value, camera_get_view_width(view_camera[0]) - resetX2val, camera_get_view_height(view_camera[0]) - currentResetY2value, false);
	draw_set_colour(global.colorThemeBorders);
	draw_rectangle(camera_get_view_width(view_camera[0]) - resetX1val, camera_get_view_height(view_camera[0]) - currentResetY1value, camera_get_view_width(view_camera[0]) - resetX2val, camera_get_view_height(view_camera[0]) - currentResetY2value, true);

	// reset text
	draw_set_font(fnt_mainBold);
	draw_set_color(global.colorThemeText);
	draw_text(camera_get_view_width(view_camera[0]) - resetX1val + 7, camera_get_view_height(view_camera[0]) - currentYheightResetText, "RESET");
	


	//now draw reztracker box
	draw_set_halign(fa_left);
	draw_set_alpha(1);
	
	var mouseOverTrackerButton = false;
	// Check for mouse location over "RezTracker" button and check for open/close button
	if (point_in_rectangle(mouse_x, mouse_y, camera_get_view_width(view_camera[0]) - Xdistance, camera_get_view_height(view_camera[0]) - Ydistance, camera_get_view_width(view_camera[0]), camera_get_view_height(view_camera[0]))) {
		mouseOverTrackerButton = true;
		if (mouse_check_button_pressed(mb_left)) {
			isTrackerOpen = !isTrackerOpen ;
		}
	}

	draw_set_colour(global.colorThemePaneBG);
	
	if(mouseOverTrackerButton){
		draw_set_colour(c_gray);
	}
	draw_rectangle(camera_get_view_width(view_camera[0]) - Xdistance, camera_get_view_height(view_camera[0]) - Ydistance, camera_get_view_width(view_camera[0]), camera_get_view_height(view_camera[0]), false);
	draw_set_alpha(1);
	draw_set_colour(global.colorThemeBorders);
	draw_rectangle(camera_get_view_width(view_camera[0]) - Xdistance, camera_get_view_height(view_camera[0]) - Ydistance, camera_get_view_width(view_camera[0]), camera_get_view_height(view_camera[0]), true);


	draw_set_font(fnt_mainBold);


	draw_set_colour(global.colorThemeText);
	
	draw_text(camera_get_view_width(view_camera[0]) - Xdistance + 5, camera_get_view_height(view_camera[0]) - Ydistance +15, "Rez Tracker");
	


	// bring up background interface
	if (isTrackerOpen) {
		// Slide background up
		if (currentYheight < newYheight) {
			currentYheight += 10;
		}
	
		//slide in the move counter text
		if (currentYheightCounterText < newYheightText1) {
			if (currentYheightCounterText < newYheightText1 - Yheightbuffer) {
				currentYheightCounterText += 10;
			}
			else {
				currentYheightCounterText += 1;
			}
		}
		
		//slide out the timer text
		if (currentYheightTimerText < newYheightText2) {
			if (currentYheightTimerText < newYheightText2 - Yheightbuffer) {
				currentYheightTimerText += 10;
			}
			else {
				currentYheightTimerText += 1;
			}
		}
	
		//slide out the reset text
		if (currentYheightResetText < newYheightText3) {
			if (currentYheightResetText < newYheightText3 - Yheightbuffer) {
				currentYheightResetText += 10;
			}
			else {
				currentYheightResetText += 1;
			}
		}
			//slide out the reset box height val 1
		if (currentResetY1value < resetY1val) {
			if (currentResetY1value < resetY1val - Yheightbuffer) {
				currentResetY1value += 12;
			}
			else {
				currentResetY1value += 1;
			}
		}
				//slide out the reset box height val 2
		if (currentResetY2value < resetY2val) {
			if (currentResetY2value < resetY2val - Yheightbuffer) {
				currentResetY2value += 8;
			}
			else {
				currentResetY2value += 1;
			}
		}
	
	
		//check for reset button pressed
		if (point_in_rectangle(mouse_x, mouse_y, camera_get_view_width(view_camera[0]) - resetX1val, camera_get_view_height(view_camera[0]) - resetY1val, camera_get_view_width(view_camera[0]) - resetX2val, camera_get_view_height(view_camera[0]) - resetY2val) and mouse_check_button_pressed(mb_left)) {
			obj_control.moveCounter = 0;
			alarm[5] = -1;
			timerMins = 0;
			timerSecs = 0;
			alarm[5] = 60;
		}
	}

	//slide interface back down
	else {
		// move outside borders
		if (currentYheight > oldYheight) {
			currentYheight -= 10;
		}
	
		//slide out the move counter text
		if (currentYheightCounterText > oldYheight) {
			currentYheightCounterText -= 10;
		}
	
		//slide out the timer text
		if (currentYheightTimerText > oldYheight) {
			currentYheightTimerText -= 10;
		}
	
	
		//slide out the reset text
		if (currentYheightResetText > oldYheight) {
			currentYheightResetText -= 10;
		}
	
		//slide out the reset box height val 1
		if (currentResetY1value > oldYheight) {
				currentResetY1value -= 12;
		}
	
		//slide out the reset box height val 2
		if (currentResetY2value > oldYheight) {
				currentResetY2value -= 8;
		}

	}
	
	var mouseOverEndButton = false;
	if (point_in_rectangle(mouse_x, mouse_y,0, camera_get_view_height(view_camera[0]) - Ydistance, 140, camera_get_view_height(view_camera[0]))) {
		mouseOverEndButton = true;
		if (mouse_check_button_pressed(mb_left)) {
			obj_control.currentStackShowListPosition = ds_list_size(obj_control.stackShowList);
			scr_stackShow();
		}
	}

	//draw end show button
	if(mouseOverEndButton) {
		// Draw the button as grey is being hovered over
		draw_set_alpha(1);
		draw_set_colour(c_gray);
	}
	else {
		draw_set_colour(global.colorThemePaneBG);
	}
	draw_rectangle(0, camera_get_view_height(view_camera[0]) - Ydistance, 140, camera_get_view_height(view_camera[0]), false);
	draw_set_alpha(1);
	draw_set_colour(global.colorThemeBorders);
	draw_rectangle(0, camera_get_view_height(view_camera[0]) - Ydistance, 140, camera_get_view_height(view_camera[0]), true);

	//draw end show text
	draw_set_font(fnt_mainBold);
	draw_set_halign(fa_left);
	draw_set_colour(global.colorThemeText);
	draw_text(0 + 5, camera_get_view_height(view_camera[0]) - Ydistance +15, "End Stack Show");


	var currentListChainID = ds_list_find_value(obj_control.stackShowList, obj_control.currentStackShowListPosition - 1);
	var currentRowinStack = ds_grid_value_y(obj_chain.stackChainGrid, obj_chain.chainGrid_colChainID, 0 , obj_chain.chainGrid_colChainID, ds_grid_height(obj_chain.stackChainGrid), currentListChainID );
	var nameOfStack = ds_grid_get(obj_chain.stackChainGrid, obj_chain.chainGrid_colName, currentRowinStack);
	var colorOfStack = ds_grid_get(obj_chain.stackChainGrid, obj_chain.chainGrid_colColor, currentRowinStack);
	
		
	//draw stack name background
	if(colorOfStack == undefined){
		draw_set_colour(global.colorThemeBG);
	}
	else{
	draw_set_colour(colorOfStack);
	}
	draw_rectangle( 140, camera_get_view_height(view_camera[0]) - Ydistance, 280, camera_get_view_height(view_camera[0]), false);
	draw_set_colour(global.colorThemeBorders);
	draw_rectangle( 140, camera_get_view_height(view_camera[0]) - Ydistance, 280, camera_get_view_height(view_camera[0]), true);
	
	//draw stack name text
	draw_set_font(fnt_mainBold);
	draw_set_halign(fa_left);
	draw_set_colour(global.colorThemeText);
	draw_text( 140 + 5, camera_get_view_height(view_camera[0]) - Ydistance +15, nameOfStack);


	//draw stack description background
	draw_set_colour(global.colorThemePaneBG);
	draw_rectangle( 280, camera_get_view_height(view_camera[0]) - Ydistance, camera_get_view_width(view_camera[0]) - Xdistance, camera_get_view_height(view_camera[0]), false);
	draw_set_colour(global.colorThemeBorders);
	draw_rectangle( 280, camera_get_view_height(view_camera[0]) - Ydistance, camera_get_view_width(view_camera[0]) - Xdistance, camera_get_view_height(view_camera[0]), true);

	var captionOfStack = ds_grid_get(obj_chain.stackChainGrid, obj_chain.chainGrid_colCaption, currentRowinStack);
	
	//draw stack caption text
	draw_set_font(fnt_main);
	draw_set_halign(fa_left);
	draw_set_colour(global.colorThemeText);
	draw_text( 280 + 5, camera_get_view_height(view_camera[0]) - Ydistance +15, captionOfStack);


	
	var mouseOverLeftButton = false;
	if (point_in_rectangle(mouse_x, mouse_y,camera_get_view_width(view_camera[0]) - Xdistance - 50, camera_get_view_height(view_camera[0]) - Ydistance, camera_get_view_width(view_camera[0]) - Xdistance - 25, camera_get_view_height(view_camera[0]))) {
		mouseOverLeftButton = true;
		if (mouse_check_button_pressed(mb_left)) {
			obj_control.stackShowBackwards = true;

			if(obj_control.currentStackShowListPosition > 1){
					scr_stackShow();
			}


		}
	}
	obj_control.stackShowBackwards = false;
	var mouseOverRightButton = false;
	if (point_in_rectangle(mouse_x, mouse_y,camera_get_view_width(view_camera[0]) - Xdistance - 25, camera_get_view_height(view_camera[0]) - Ydistance, camera_get_view_width(view_camera[0]) - Xdistance, camera_get_view_height(view_camera[0]))) {
		mouseOverRightButton = true;
		if (mouse_check_button_pressed(mb_left)) {
			/*
			if(obj_control.currentStackShowListPosition < ds_list_size(obj_control.stackShowList)){
				obj_control.currentStackShowListPosition += 1;
			}
			*/
			scr_stackShow();
		}
	}



	//draw selection arrow background left
	if(mouseOverLeftButton){
			draw_set_colour(c_gray);
	}
	else{
			draw_set_colour(global.colorThemePaneBG);
	}
	draw_rectangle( camera_get_view_width(view_camera[0]) - Xdistance - 50, camera_get_view_height(view_camera[0]) - Ydistance, camera_get_view_width(view_camera[0]) - Xdistance - 25, camera_get_view_height(view_camera[0]), false);
	draw_set_colour(global.colorThemeBorders);
	draw_rectangle( camera_get_view_width(view_camera[0]) - Xdistance - 50, camera_get_view_height(view_camera[0]) - Ydistance, camera_get_view_width(view_camera[0]) - Xdistance - 25, camera_get_view_height(view_camera[0]), true);

	//draw selection arrow background right
	if(mouseOverRightButton){
			draw_set_colour(c_gray);
	}
	else{
			draw_set_colour(global.colorThemePaneBG);
	}
	draw_rectangle( camera_get_view_width(view_camera[0]) - Xdistance - 25, camera_get_view_height(view_camera[0]) - Ydistance, camera_get_view_width(view_camera[0]) - Xdistance, camera_get_view_height(view_camera[0]), false);
	draw_set_colour(global.colorThemeBorders);
	draw_rectangle( camera_get_view_width(view_camera[0]) - Xdistance - 25, camera_get_view_height(view_camera[0]) - Ydistance, camera_get_view_width(view_camera[0]) - Xdistance, camera_get_view_height(view_camera[0]), true);

		draw_sprite_ext(spr_ascend, 0, camera_get_view_width(view_camera[0]) - Xdistance - 40, camera_get_view_height(view_camera[0]) - Ydistance +15, 1, 1, 90, c_white, 1);
		draw_sprite_ext(spr_ascend, 0, camera_get_view_width(view_camera[0]) - Xdistance - 10, camera_get_view_height(view_camera[0]) - Ydistance +14, 1, 1, 270, c_white, 1);

}
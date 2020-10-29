/*
	scr_drawCompassRose();
	
	Last Updated: 2020-10-29
	
	Called from: obj_control
	
	Purpose: draw a compass rose within devVars to keep track of flow
	
	Mechanism: While the mouse is bein dragged, draw a circle of triangles around the initial drag point, 
				and highlight the cardinal direction of the dragged mouse.
				
	Author: Georgio Klironomos
*/
function scr_drawCompassRose() {
	draw_set_font(global.fontMain);

	// Keep track of the initial drag point
	if(not mouse_check_button(mb_left)) {
			compassRoseX = mouse_x;
			compassRoseY = mouse_y;
			compassLineX1 = mouse_x;
			compassLineY1 = mouse_y;
			compassLineX2 = mouse_x;
			compassLineY2 = mouse_y;
			// Check of the mouse is within a line of the discourse
			if(lineContainsMouseYPos > -1) { 
				//compassCenterLineY = ds_grid_get(currentActiveLineGrid, lineGrid_colPixelY, lineContainsMouse);
			}
	}
	// Once there is a LeftMouseClick, begin checking for direction and gesture
	else {
		var currentWordX = -1;
	
		// Determine the gesture's starting region
		draw_set_color(global.colorThemeText);
		
		// Within a word
		if(mouseRectBeginInWord > -1) {
			draw_set_color(c_green);
			currentWordX = ds_grid_get(dynamicWordGrid, dynamicWordGrid_colPixelX, mouseRectBeginInWord - 1);
		}
		
		// Between words
		else if(mouseRectBeginBetweenWords > -1) {
			draw_set_color(c_blue);
			currentWordX = ds_grid_get(dynamicWordGrid, dynamicWordGrid_colPixelX, mouseRectBeginBetweenWords- 1);
			var currentWordString = ds_grid_get(dynamicWordGrid, dynamicWordGrid_colDisplayString, mouseRectBeginBetweenWords- 1);
		}
		
		// Outside of wordspace
		else {
			draw_set_color(c_red);
		}
		
		// Draw a line from the rose to the mouse, creating a diagonal across the box
		compassLineX2 = mouse_x;
		compassLineY2 = mouse_y;
		draw_line(compassLineX1, compassLineY1, compassLineX2, compassLineY2);
	
		// Calculate the angle of the mouseDrag
		var compassLineAngle = point_direction(compassLineX1, compassLineY1, compassLineX2, compassLineY2);
		draw_text(camera_get_view_width(camera_get_active()) - 300, 80, "compassLineAngle: " + string(compassLineAngle));

	
		// Use this to create the compass's horizontal and vertical "snapToGrid"
		if(lineContainsMouseYPos > -1) { 
		
			var lineRectX1 = -1;
			var lineRectX2 = -1;
		
			// Use the containing word's x position
			if(mouseRectBeginInWord > -1) {
				lineRectX1 = currentWordX - 2;
				lineRectX2 = currentWordX + gridSpaceHorizontal;
			}
			// Use the first word's x position
			else if(mouseRectBeginBetweenWords > -1) {
				lineRectX1 = currentWordX + string_width(currentWordString) + 4;
				lineRectX2 = lineRectX1 + gridSpaceHorizontal - string_width(currentWordString) - 4;
			}
			else {
				lineRectX1 = compassRoseX;
				lineRectX2 = compassRoseX;
			}
		
			var lineRectY1 = compassCenterLineY - (gridSpaceVertical / 2);
			var lineRectY2 = lineRectY1 + gridSpaceVertical;
	
			// Draw the center grid
			draw_set_alpha(0.8);
			draw_line_width(lineRectX1 - 30, lineRectY1, lineRectX2 + 30, lineRectY1, 3);
			draw_line_width(lineRectX1- 30, lineRectY2, lineRectX2 + 30, lineRectY2, 3);
			draw_line_width(lineRectX1, lineRectY1 - 30, lineRectX1, lineRectY2 + 30, 3);
			draw_line_width(lineRectX2, lineRectY1 - 30, lineRectX2, lineRectY2 + 30, 3);
		
		
			// Draw and highlight the 8 cardinal directions
			draw_set_alpha(0.3);
			// South
			if (point_in_rectangle(mouse_x, mouse_y, lineRectX1, lineRectY2, lineRectX2, camera_get_view_height(camera_get_active()))) {
				draw_rectangle(lineRectX1, lineRectY2, lineRectX2, lineRectY2 + 50, false);
			}
			// North
			if (point_in_rectangle(mouse_x, mouse_y, lineRectX1, 0, lineRectX2, lineRectY1)) {
				draw_rectangle(lineRectX1, lineRectY1 - 50, lineRectX2, lineRectY1, false);
			}
		
			// West
			if (point_in_rectangle(mouse_x, mouse_y, 0, lineRectY1, lineRectX1, lineRectY2)) {
				draw_rectangle(lineRectX1 - 50, lineRectY1, lineRectX1, lineRectY2, false);
			}
			// East
			if (point_in_rectangle(mouse_x, mouse_y, lineRectX2, lineRectY1, camera_get_view_width(camera_get_active()), lineRectY2)) {
				draw_rectangle(lineRectX2, lineRectY1, lineRectX2 + 50, lineRectY2, false);
			}
			// NorthEast
			if (point_in_rectangle(mouse_x, mouse_y, lineRectX2, 0, camera_get_view_width(camera_get_active()), lineRectY1)) {
				draw_rectangle(lineRectX2, lineRectY1 - 50, lineRectX2 + 50, lineRectY1, false);
			}
			// NorthWest
			if (point_in_rectangle(mouse_x, mouse_y, 0, 0, lineRectX1, lineRectY1)) {
				draw_rectangle(lineRectX1 - 50, lineRectY1 - 50, lineRectX1, lineRectY1, false);
			}
			// SouthWest
			if (point_in_rectangle(mouse_x, mouse_y, 0, lineRectY2, lineRectX1, camera_get_view_height(camera_get_active()))) {
				draw_rectangle(lineRectX1 - 50, lineRectY2, lineRectX1, lineRectY2 + 50, false);
			}
			// SouthEast
			if (point_in_rectangle(mouse_x, mouse_y, lineRectX2, lineRectY2, camera_get_view_width(camera_get_active()), camera_get_view_height(camera_get_active()))) {
				draw_rectangle(lineRectX2, lineRectY2, lineRectX2 + 50, lineRectY2 + 50, false);
			}
		
			draw_set_alpha(1);
		}
	}
}

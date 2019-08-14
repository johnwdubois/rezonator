/*
	scr_drawCompassRose();
	
	Last Updated: 2019-08-13
	
	Called from: obj_control
	
	Purpose: draw a compass rose within devVars to keep track of flow
	
	Mechanism: While the mouse is bein dragged, draw a circle of triangles around the initial drag point, 
				and highlight the cardinal direction 0f the dragged mouse.
				
	Author: Georgio Klironomos
*/

// Keep track of the initial drag point
if(not mouse_check_button(mb_left)) {
		compassRoseX = mouse_x;
		compassRoseY = mouse_y;
		compassLineX1 = mouse_x;
		compassLineY1 = mouse_y;
		compassLineX2 = mouse_x;
		compassLineY2 = mouse_y;
}
else {
	
	// Dtermine the gesture's starting region
	draw_set_color(global.colorThemeText);
	if(mouseRectBeginInWord) {
		draw_set_color(c_green);
	}
	else if(mouseRectBeginBetweenWords) {
		draw_set_color(c_blue);
	}
	else {
		draw_set_color(c_red);
	}
		
	// Draw a line from the rose to the mouse, creating a diagonal across the box
	compassLineX2 = mouse_x;
	compassLineY2 = mouse_y;
	draw_line(compassLineX1, compassLineY1, compassLineX2, compassLineY2);
	
	// Calculate the angle of the mouseDrag
	var compassLineAngle = point_direction(compassLineX1, compassLineY1, compassLineX2, compassLineY2);
	draw_text(camera_get_view_width(view_camera[0]) - 300, 80, "compassLineAngle: " + string(compassLineAngle));
	var triOffsetX = sin(0.3926991) * 80;
	var triOffsetY = cos(0.3926991) * 80;
	
	// Draw and highlight the 8 cardinal directions
	
	// South
	draw_triangle(compassRoseX, compassRoseY, compassRoseX - triOffsetX, compassRoseY + triOffsetY, compassRoseX + triOffsetX, compassRoseY + triOffsetY, true);
	if (247.5 < compassLineAngle  and compassLineAngle < 292.5) {
		draw_triangle(compassRoseX, compassRoseY, compassRoseX - triOffsetX, compassRoseY + triOffsetY, compassRoseX + triOffsetX, compassRoseY + triOffsetY, false);
	}
	// North
	draw_triangle(compassRoseX, compassRoseY, compassRoseX - triOffsetX, compassRoseY - triOffsetY, compassRoseX + triOffsetX, compassRoseY - triOffsetY, true);
	if (67.5 < compassLineAngle  and compassLineAngle < 112.5) {
		draw_triangle(compassRoseX, compassRoseY, compassRoseX - triOffsetX, compassRoseY - triOffsetY, compassRoseX + triOffsetX, compassRoseY - triOffsetY, false);
	}
	// West
	draw_triangle(compassRoseX, compassRoseY, compassRoseX - triOffsetY, compassRoseY + triOffsetX, compassRoseX - triOffsetY, compassRoseY - triOffsetX, true);
	if (157.5 < compassLineAngle  and compassLineAngle < 202.5) {
		draw_triangle(compassRoseX, compassRoseY, compassRoseX - triOffsetY, compassRoseY + triOffsetX, compassRoseX - triOffsetY, compassRoseY - triOffsetX, false);
	}
	// East
	draw_triangle(compassRoseX, compassRoseY, compassRoseX + triOffsetY, compassRoseY + triOffsetX, compassRoseX + triOffsetY, compassRoseY - triOffsetX, true);
	if ((337.5 < compassLineAngle and compassLineAngle < 360) || (0 < compassLineAngle and compassLineAngle < 22.5)) {
		draw_triangle(compassRoseX, compassRoseY, compassRoseX + triOffsetY, compassRoseY + triOffsetX, compassRoseX + triOffsetY, compassRoseY - triOffsetX, false);
	}
	// NorthEast
	if (22.5 < compassLineAngle and compassLineAngle < 67.5) {
		draw_triangle(compassRoseX, compassRoseY, compassRoseX + triOffsetY, compassRoseY - triOffsetX, compassRoseX + triOffsetX, compassRoseY - triOffsetY, false);
	}
	// NorthWest
	if (112.5 < compassLineAngle and compassLineAngle < 157.5) {
		draw_triangle(compassRoseX, compassRoseY, compassRoseX - triOffsetX, compassRoseY - triOffsetY, compassRoseX - triOffsetY, compassRoseY - triOffsetX, false);
	}
	// SouthWest
	if (202.5 < compassLineAngle and compassLineAngle < 247.5) {
		draw_triangle(compassRoseX, compassRoseY, compassRoseX - triOffsetY, compassRoseY + triOffsetX, compassRoseX - triOffsetX, compassRoseY + triOffsetY, false);
	}
	// SouthEast
	if (292.5 < compassLineAngle and compassLineAngle < 337.5) {
		draw_triangle(compassRoseX, compassRoseY, compassRoseX + triOffsetX, compassRoseY + triOffsetY, compassRoseX + triOffsetY, compassRoseY + triOffsetX, false);
	}
		
	/*	
	draw_triangle(compassRoseX, compassRoseY, compassRoseX - triOffsetX - 1, compassRoseY + triOffsetY+ 1, compassRoseX + triOffsetX+ 1, compassRoseY + triOffsetY+ 1, true);
	draw_triangle(compassRoseX, compassRoseY, compassRoseX - triOffsetX - 1, compassRoseY - triOffsetY- 1, compassRoseX + triOffsetX+ 1, compassRoseY - triOffsetY- 1, true);
	draw_triangle(compassRoseX, compassRoseY, compassRoseX - triOffsetY - 1, compassRoseY + triOffsetX+ 1, compassRoseX - triOffsetY- 1, compassRoseY - triOffsetX- 1, true);
	draw_triangle(compassRoseX, compassRoseY, compassRoseX + triOffsetY + 1, compassRoseY + triOffsetX+ 1, compassRoseX + triOffsetY+ 1, compassRoseY - triOffsetX- 1, true);*/
}
function scr_pointInRectangleClippedWindow(pointX, pointY, rectX1, rectY1, rectX2, rectY2) {
	
	// use this function when trying to do a point_in_rectangle on a window with clipping (i.e. the panel panes) so that the mouseover will only count when
	// the mouse is strictly in range of the clipped window
	
	return (point_in_rectangle(pointX, pointY, rectX1, rectY1, rectX2, rectY2) and point_in_rectangle(pointX, pointY, x, y, x + windowWidth, y + windowHeight));

}

function scr_pointInCircleClippedWindow(pointX, pointY, circleX, circleY, rad) {
	
	// use this function when trying to do a point_in_circle on a window with clipping (i.e. the panel panes) so that the mouseover will only count when
	// the mouse is strictly in range of the clipped window
	
	return (point_in_circle(pointX, pointY, circleX, circleY, rad) and point_in_rectangle(pointX, pointY, x, y, x + windowWidth, y + windowHeight));

}

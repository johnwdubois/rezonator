function scr_pointInRectangleClippedWindow(pointX, pointY, rectX1, rectY1, rectX2, rectY2) {

	return (point_in_rectangle(pointX, pointY, rectX1, rectY1, rectX2, rectY2) and point_in_rectangle(pointX, pointY, x, y, x + windowWidth, y + windowHeight));

}

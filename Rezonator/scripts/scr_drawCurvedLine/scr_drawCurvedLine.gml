function scr_drawCurvedLine(x1, y1, x2, y2, color, width) {
	
	draw_set_color(color);
	draw_set_alpha(1);
	
	var halfwayX = mean(x1, x2);
	var halfwayY = mean(y1, y2);

	var splinePoints = [];
	array_push(splinePoints, x1, y1);
	array_push(splinePoints, x1, mean(y1, halfwayY));
	array_push(splinePoints, mean(x1, halfwayX), mean(halfwayY, y2));
	array_push(splinePoints, halfwayX, halfwayY);
	array_push(splinePoints, mean(x2, halfwayX), mean(halfwayY, y1));
	array_push(splinePoints, x2, mean(y2, halfwayY));
	array_push(splinePoints, x2, y2);

	var spline = CleanSpline(splinePoints, array_length(splinePoints) * 2);
	spline.Thickness(width);
	spline.Draw();


}



function scr_drawRectWidth(x1, y1, x2, y2, width, rounded) {

	for (var i = 0; i < width; i++) {
		if (rounded) {
			draw_roundrect(x1 + i, y1 + i, x2 - i, y2 - i, true);
		}
		else {
			draw_rectangle(x1 + i, y1 + i, x2 - i, y2 - i, true);
		}
	}

}
if (live_call()) return live_result;

showDelay = clamp(showDelay, 0, showDelayFull);
if (!show) {
	alpha = 0;
	showDelay = showDelayFull;
	exit;
}
else {
	showDelay--;
}
if (showDelay > 0) {
	alpha = 0;
	exit;
}


// increase alpha
if (alpha < 1) {
	alpha += 0.05;
}
alpha = clamp(alpha, 0, 0.8);
draw_set_alpha(alpha);

draw_set_font(global.fontMain);

var strWidth = string_width(text + "  ");
var strHeight = string_height(text);

var arrowHeight = -1;
var arrowWidth = -1;
var arrowX1 = -1;
var arrowY1 = -1;
var arrowX2 = -1;
var arrowY2 = -1;
var arrowX3 = -1;
var arrowY3 = -1;
var rectX1 = -1;
var rectY1 = -1;
var rectX2 = -1;
var rectY2 = -1;


if (arrowFacing == arrowFaceUp) {
	
	arrowWidth = 20;
	arrowHeight = 15;
	
	arrowX1 = x;
	arrowY1 = y;
	arrowX2 = arrowX1 - (arrowWidth / 2);
	arrowY2 = arrowY1 + arrowHeight;
	arrowX3 = arrowX1 + (arrowWidth / 2);
	arrowY3 = arrowY1 + arrowHeight;
	
	rectX1 = x - (strWidth / 2);
	rectY1 = y + arrowHeight;
	rectX2 = rectX1 + strWidth;
	rectY2 = rectY1 + strHeight;
}
else if (arrowFacing == arrowFaceLeft) {
	
	arrowWidth = 15;
	arrowHeight = 20;

	arrowX1 = x;
	arrowY1 = y;
	arrowX2 = arrowX1 + arrowWidth;
	arrowY2 = arrowY1 - (arrowHeight / 2);
	arrowX3 = arrowX1 + arrowWidth;
	arrowY3 = arrowY1 + (arrowHeight / 2);
	
	rectX1 = x + arrowWidth;
	rectY1 = y - (strHeight / 2)
	rectX2 = rectX1 + strWidth;
	rectY2 = rectY1 + strHeight;
}
else if (arrowFacing == arrowFaceDown) {
	
	arrowWidth = 20;
	arrowHeight = 15;
	
	arrowX1 = x;
	arrowY1 = y;
	arrowX2 = arrowX1 - (arrowWidth / 2);
	arrowY2 = arrowY1 - arrowHeight;
	arrowX3 = arrowX1 + (arrowWidth / 2);
	arrowY3 = arrowY1 - arrowHeight;
	
	rectX1 = x - (strWidth / 2);
	rectY1 = y - arrowHeight;
	rectX2 = rectX1 + strWidth;
	rectY2 = rectY1 - strHeight;
}
else if (arrowFacing == arrowFaceRight) {
	
	arrowWidth = 15;
	arrowHeight = 20;

	arrowX1 = x;
	arrowY1 = y;
	arrowX2 = arrowX1 - arrowWidth;
	arrowY2 = arrowY1 - (arrowHeight / 2);
	arrowX3 = arrowX1 - arrowWidth;
	arrowY3 = arrowY1 + (arrowHeight / 2);
	
	rectX1 = x - arrowWidth;
	rectY1 = y - (strHeight / 2)
	rectX2 = rectX1 - strWidth;
	rectY2 = rectY1 + strHeight;
}





// make sure tooltip isn't writing off-screen
var camWidth = camera_get_view_width(camera_get_active());
if (rectX1 < 0) {
	rectX1 = 0;
	rectX2 = rectX1 + strWidth;
}
if (rectX2 > camWidth) {
	rectX2 = camWidth;
	rectX1 = rectX2 - strWidth;
}



// draw arrow and rounded rectangle
draw_set_color(global.colorThemeBorders);
draw_triangle(arrowX1, arrowY1, arrowX2, arrowY2, arrowX3, arrowY3, false);
draw_roundrect(rectX1, rectY1, rectX2, rectY2, false);


// draw tooltip text
var textX = floor(mean(rectX1, rectX2));
var textY = floor(mean(rectY1, rectY2));
draw_set_color(global.colorThemeBG);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_alpha(clamp(alpha + 0.2, 0, 1));
draw_text(textX, textY, string(text));
var pointX = argument0;
var pointY = argument1;
var rectX1 = argument2;
var rectY1 = argument3;
var rectX2 = argument4;
var rectY2 = argument5;

return (point_in_rectangle(pointX, pointY, rectX1, rectY1, rectX2, rectY2) and point_in_rectangle(pointX, pointY, x, y, x + windowWidth, y + windowHeight));
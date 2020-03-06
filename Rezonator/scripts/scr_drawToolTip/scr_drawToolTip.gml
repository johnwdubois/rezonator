var posX = argument0;
var posY = argument1;
var tipString = argument2;
var orientation = argument3;
var triangleOffset = 20;
var toolTipBoxX  = string_width(tipString)/2 +15;
var toolTipBoxY  = string_height(tipString)+15;
var innerBuffer = 5;

//show_message("X: " + string(posX) +", Y: " + string(posY) +", String: " + string(tipString));

if( orientation == "top" ){
	
draw_set_color(global.colorThemeBorders);
draw_triangle( posX, posY, posX - triangleOffset, posY + triangleOffset, posX + triangleOffset, posY + triangleOffset, false);
draw_roundrect(posX-toolTipBoxX,  posY + triangleOffset , posX+toolTipBoxX, posY + triangleOffset + toolTipBoxY, false);

draw_set_color(global.colorThemeBG);
draw_triangle( posX, posY+innerBuffer+2, posX - triangleOffset+innerBuffer-2, posY + triangleOffset+innerBuffer, posX + triangleOffset - innerBuffer+2, posY + triangleOffset +innerBuffer, false);
draw_roundrect(posX-toolTipBoxX+innerBuffer,  posY + triangleOffset +innerBuffer , posX+toolTipBoxX-innerBuffer, posY + triangleOffset + toolTipBoxY-innerBuffer, false);
//draw_triangle(50, 50, 200, 50, 50, 200, 0);

draw_set_color(global.colorThemeText);
draw_set_valign(fa_center);
draw_set_halign(fa_center);
draw_text(floor(mean(posX-toolTipBoxX+innerBuffer,posX+toolTipBoxX-innerBuffer)), floor(mean(posY + triangleOffset +innerBuffer,posY + triangleOffset + toolTipBoxY-innerBuffer))+2 , tipString);

}
else if( orientation == "left" ){
	
		
draw_set_color(global.colorThemeBorders);
draw_triangle( posX, posY, posX + triangleOffset, posY + triangleOffset, posX + triangleOffset, posY - triangleOffset, false);
draw_roundrect(posX + triangleOffset-4,  posY - triangleOffset , posX + triangleOffset + toolTipBoxX*2 +5, posY + triangleOffset, false);

draw_set_color(global.colorThemeBG);
draw_triangle( posX+innerBuffer+2, posY, posX + triangleOffset+2, posY + triangleOffset-innerBuffer, posX + triangleOffset+2, posY - triangleOffset +innerBuffer, false);
draw_roundrect(posX + triangleOffset-5+innerBuffer,  posY - triangleOffset+innerBuffer , posX + triangleOffset + toolTipBoxX*2 -innerBuffer +5, posY + triangleOffset -innerBuffer, false);
//draw_triangle( posX, posY+innerBuffer+2, posX + triangleOffset+innerBuffer-2, posY + triangleOffset+innerBuffer, posX + triangleOffset - innerBuffer+2, posY - triangleOffset +innerBuffer, false);
//draw_roundrect(posX-toolTipBoxX+innerBuffer,  posY + triangleOffset +innerBuffer , posX+toolTipBoxX-innerBuffer, posY + triangleOffset + toolTipBoxY-innerBuffer, false);
//draw_triangle(50, 50, 200, 50, 50, 200, 0);

draw_set_color(global.colorThemeText);
draw_set_font(global.fontMainBold);
draw_set_valign(fa_center);
draw_set_halign(fa_center);
draw_text(floor(mean(posX + triangleOffset-5+innerBuffer-5 ,  posX + triangleOffset + toolTipBoxX*2 -innerBuffer +5)), floor(mean( posY + triangleOffset -innerBuffer,   posY - triangleOffset+innerBuffer )) , tipString);

	
}

//show_message("X: " + string(posX) +", Y: " + string(posY) +", String: " + string(tipString));
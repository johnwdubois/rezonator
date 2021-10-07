/// @description Insert description here
// You can write your code in this editor
//if (mouseoverNeutralSpace) {
if (inDrag) {
	inDrag = false;
	flickVelY = event_data[?"diffY"];
	//if (extraTokenX) flickVelX = event_data[?"diffX"];
	mouseHoldRectX1 = 0; 
	mouseHoldRectX2 = 0; 
	mouseHoldRectY1 = 0; 
	mouseHoldRectY2 = 0; 
}
/// @description Insert description here
// You can write your code in this editor
if(tracksOnlyStackShow && obj_control.stackShowActive) {
	currentMode = modeTrack;
	currentTool = toolTrackBrush;
	alarm[3] = 2;
}
else if(rezOnlyStackShow && obj_control.stackShowActive) {
	currentMode = modeRez;
	currentTool = toolRezBrush;
	alarm[3] = 2;
}

// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_getCurrentSessionTime(){
	
	with (obj_control) {
		currentSessionLength = current_time - sessionStartTime;
		fullSessionLength = loadSessionLength + currentSessionLength;
	}
	
	return obj_control.fullSessionLength;

}
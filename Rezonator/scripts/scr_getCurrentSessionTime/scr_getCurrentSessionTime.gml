

function scr_getCurrentSessionTime() {
	
	with (obj_control) {
		currentSessionLength = current_time - sessionStartTime;
		fullSessionLength = loadSessionLength + currentSessionLength;
	}
	
	return obj_control.fullSessionLength;

}
function scr_printTime() {
	var currentMin = string(current_minute);
	var currentSec = string(current_second);
	if (string_length(currentMin) < 2) { currentMin = "0" + string(current_minute); }
	if (string_length(currentSec) < 2) { currentSec = "0" + string(current_second); }

	return "... The time is " + string(current_hour) + ":" + currentMin + "." + currentSec;


}

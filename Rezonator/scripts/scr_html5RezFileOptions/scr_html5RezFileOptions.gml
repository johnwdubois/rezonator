function scr_html5RezFileOptions(optionSelected){
	
	global.html5RezFile = optionSelected;
	if (room == rm_mainScreen) {
		room_restart();
	}
	
}
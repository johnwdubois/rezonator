

function scr_jumpToUnitDoubleClick(unitID) {

	with (obj_control) {
		if (doubleClickTimer > -1) {
			// scroll to focused unit if the user double clicks
			scr_jumpToUnitTop(unitID);
		}
		else {
			doubleClickTimer = 0;
		}
	}

}
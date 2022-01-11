// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_jumpToUnitDoubleClick(unitID){

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
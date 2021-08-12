// Save a Rez file containing the collection of lines within the selected Stack
function scr_clipFromStack(selectedStackID) {
	
	// gather the beginning and the end of the Stack
	var unitIDList = scr_getChainTempList(selectedStackID, false);

	
	scr_miniClipFile(unitIDList)

}

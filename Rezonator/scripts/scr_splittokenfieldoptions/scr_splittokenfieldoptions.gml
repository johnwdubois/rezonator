function scr_splitTokenFieldOptions(optionSelected){
	
	with (obj_control) {
		splitTokenField = optionSelected;
	}
	
	var splitTokenSubmap = global.nodeMap[? obj_control.rightClickID];
	var splitTokenTagmap = splitTokenSubmap[? "tagMap"];
	var splitTokenText = splitTokenTagmap[? obj_control.splitTokenField];
	
	with (obj_inputBox) {
		str = string(splitTokenText);
		cursorIndex = string_length(str);
		highlightIndex = cursorIndex;
	}
	

}


function scr_strToColor(str) {
	
	if (!is_string(str)) {str = "";}

	if (ds_map_exists(global.colorMap, str)) {
        return global.colorMap[? str];
    }
	var col = make_color_hsv(obj_chain.chainHue, random_range(125, 255), random_range(200, 255));
	obj_chain.chainHue += random_range(50, 200);
	if (obj_chain.chainHue > 255) {
		obj_chain.chainHue -= 255;
	}
	while ( obj_chain.chainHue > 30 && obj_chain.chainHue < 70) {
		obj_chain.chainHue = random_range(0, 255);
	}
	col = merge_color(col, c_white, 0.5);
	ds_map_add(global.colorMap, str, col);
	return col;

}

function scr_findHash(str,key) {
	
	var stringLength = string_length(str);
	var totalOrd = 0;
	for (var i = 1; i <= stringLength; i++) {
		var char = string_char_at(str,i);
		var charValue = ord(string_upper(char));
		totalOrd = totalOrd+charValue; 	
	}
	var hashedResult = totalOrd*key;
	hashedResult = floor(hashedResult/255);
	
	return hashedResult;
}

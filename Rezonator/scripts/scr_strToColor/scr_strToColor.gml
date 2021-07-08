// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_strToColor(str){
	if(!is_string(str)){str = "";}
	/*
 // terry's colors
    if (ds_map_exists(global.colorMap, str)) {
        return global.colorMap[? str];
    }



    var val = 0;
    var i = 1;
    repeat(string_length(str)) {
        val += power(ord(string_char_at(str, i)), 5);
        i++;
    }

    var r = (val & 0xFF0000) >> 16;
    var g = (val & 0x00FF00) >> 8;
    var b = val & 0x0000FF;
    var color = make_color_rgb(r, g, b);


    ds_map_add(global.colorMap, str, color);
    return color;
}
*/

	// BORFY'S colors
	if (ds_map_exists(global.colorMap, str)) {
        return global.colorMap[? str];
    }
	// create unique key values
	var rHashKey = 3512;
	var gHashKey = 8748;
	var bHashKey = 5132;
	
	// create default color values
	var rValue = 0;
	var gValue = 0;
	var bValue = 0;
	
	//find unique value using string and key
	rValue = scr_findHash(str, rHashKey);
	gValue = scr_findHash(str, gHashKey);
	bValue = scr_findHash(str, bHashKey);

	// create new color
	var color = make_color_rgb(rValue,gValue,bValue);
	ds_map_add(global.colorMap, str, color);
	return color;
}

function scr_findHash(str,key){
	
	var stringLength = string_length(str);
	var totalOrd = 0;
	for(var i = 1; i <= stringLength; i ++){
		var char = string_char_at(str,i);
		var charValue = ord(string_upper(char));
		totalOrd = totalOrd+charValue; 	
	}
	var hashedResult = totalOrd*key;
	hashedResult = floor(hashedResult/255);
	
	return hashedResult;
}

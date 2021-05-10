// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
// Credit to xot: https://gmlscripts.github.io/script/base_convert.html
function scr_baseConvert(number, oldbase, newbase) {
	
	// catch errors
	if (!is_numeric(number) && !is_string(number)) {
		show_debug_message("scr_baseConvert() ... number is neither numeric or string");
		exit;
	}
	if (argument_count < 3) {
		show_debug_message("scr_baseConvert() ... not enough arguments provided");
		exit;
	}
	
	// convert base
    var out = "";
    number = string_upper(number);
 
    var len, tab;
    len = string_length(number);
    tab = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
 
    var i, num;
    for (i=0; i<len; i+=1) {
        num[i] = string_pos(string_char_at(number, i+1), tab) - 1;
    }
 
    do {
        var divide, newlen;
        divide = 0;
        newlen = 0;
        for (i=0; i<len; i+=1) {
            divide = divide * oldbase + num[i];
            if (divide >= newbase) {
                num[newlen] = divide div newbase;
                newlen += 1;
                divide = divide mod newbase;
            } else if (newlen  > 0) {
                num[newlen] = 0;
                newlen += 1;
            }
        }
        len = newlen;
        out = string_char_at(tab, divide+1) + out;
    } until (len == 0);
	
    return out;
}
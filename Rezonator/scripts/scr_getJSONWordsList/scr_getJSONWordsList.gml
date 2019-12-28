// Convert a string from a JSON into a List data type

var str = argument0;
var list = ds_list_create();

var charAt = 1;
while (string_char_at(str, charAt) != "[" and charAt < string_length(str)) {
	charAt++;
}
var relevantStrStart = charAt + 1;
var relevantStrLength = 0;
while (string_char_at(str, charAt) != "]" and charAt < string_length(str)) {
	charAt++;
	relevantStrLength++;
}
relevantStrLength--;

var relevantStr = string_copy(str, relevantStrStart, relevantStrLength);

var currentTokenStart = -1;
var currentTokenLength = 0;
charAt = 1;
while (charAt < string_length(relevantStr)) {
	
	if (string_char_at(relevantStr, charAt) == "\"") {
		if (currentTokenStart < 0) {
			currentTokenStart = charAt + 1;
		}
		else {
			var newToken = string_copy(relevantStr, currentTokenStart, currentTokenLength);
			ds_list_add(list, newToken);
			currentTokenStart = -1;
			currentTokenLength = 0;
		}
	}
	else if (currentTokenStart > -1) {
		currentTokenLength++;
	}
	
	charAt++;
}

return list;
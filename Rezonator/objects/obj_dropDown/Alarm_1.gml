draw_set_font(fnt_dropDown);
var optionListSize = ds_list_size(optionList);
var maxStrWidth = windowWidth;
for (var i = 0; i < optionListSize; i++) {
	var currentOptionStr = string(ds_list_find_value(optionList, i));
	var currentOptionStrWidth = string_width(currentOptionStr) + (textBuffer * 2);
	if (currentOptionStrWidth > maxStrWidth) {
		maxStrWidth = currentOptionStrWidth;
	}
}
windowWidth = maxStrWidth;
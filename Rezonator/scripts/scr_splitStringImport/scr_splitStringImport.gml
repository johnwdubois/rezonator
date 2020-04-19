var listUntrimmed = scr_splitString(argument0, " ");
var listTrimmed = ds_list_create();
	
var listUntrimmedSize = ds_list_size(listUntrimmed);
for (var j = 0; j < listUntrimmedSize; j++) {
	if (string_length(string(ds_list_find_value(listUntrimmed, j))) > 0) {
		ds_list_add(listTrimmed, string(ds_list_find_value(listUntrimmed, j)));
	}
}
	
ds_list_destroy(listUntrimmed);

return listTrimmed;
// Convert the data of a list into a readable string format

var list = argument0;
var str = "{";

if !ds_list_empty(list){
	var listSize = ds_list_size(list);
	
	for (var i = 0; i < listSize; i++) {
		str += string(ds_list_find_value(list, i));
	
		if (i < listSize - 1) {
			str += ", ";
		}
	}

}

str += "}";

return str;
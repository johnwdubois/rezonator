// Convert the data of a list into a readable string format

var list = argument0;
var str = "{";

if !ds_list_empty(list){
	
	for (var i = 0; i < ds_list_size(list); i++) {
		str += string(ds_list_find_value(list, i));
	
		if (i < ds_list_size(list) - 1) {
			str += ", ";
		}
	}

}

str += "}";

return str;
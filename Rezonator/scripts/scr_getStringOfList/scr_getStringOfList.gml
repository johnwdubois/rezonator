var list = argument0;
var str = "{";

for (var i = 0; i < ds_list_size(list); i++) {
	str += string(ds_list_find_value(list, i));
	
	if (i < ds_list_size(list) - 1) {
		str += ", ";
	}
}

str += "}";

return str;
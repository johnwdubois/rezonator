var list1 = argument0;
var list2 = argument1;

if (ds_list_size(list1) != ds_list_size(list2)) {
	return false;
}

for (var i = 0; i < ds_list_size(list1); i++) {
	if (ds_list_find_value(list1, i) != ds_list_find_value(list2, i)) {
		return false;
	}
}

return true;
var list = argument0;
var ascending = argument1;

var prevItem = undefined;
for (var i = 0; i < ds_list_size(list); i++) {
	
	var currentItem = ds_list_find_value(list, i);
	
	if (typeof(prevItem) == "number" and typeof(currentItem) == "number") {
		if (ascending) {
			if (currentItem <= prevItem) {
				return false;
			}
		}
		else {
			if (currentItem >= prevItem) {
				return false;
			}
		}
	}
	
	prevItem = currentItem;
}

return true;
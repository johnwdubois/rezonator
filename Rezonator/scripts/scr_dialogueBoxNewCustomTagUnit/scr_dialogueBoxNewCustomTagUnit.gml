var mapKey = ds_list_find_value(global.unitImportColNameList, obj_control.unitImportColToChange);
var tempList = ds_map_find_value(global.unitImportTagMap, mapKey);
ds_list_add(tempList, obj_control.inputText);
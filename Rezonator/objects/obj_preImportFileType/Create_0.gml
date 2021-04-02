scr_scrollBarInit();

importTypeMouseover = -1;

// set a default map for currentPreImportMap (this will be changed)
currentPreImportMap = ds_map_find_value(global.preImportMap, global.importType_PlainText);


importTypeSelected = global.importType_TabDelimited;
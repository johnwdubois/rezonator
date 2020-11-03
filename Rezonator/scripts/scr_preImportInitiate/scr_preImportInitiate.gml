// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_preImportInitiate(){

// preImport map will have a node for every type of import
global.preImportMap = ds_map_create();
var importTypeListSize = ds_list_size(importTypeList);
for (var i = 0; i < importTypeListSize; i++) {
	
	var importTypeStr = ds_list_find_value(importTypeList, i);
	var currentImportTypeMap = ds_map_create();
	
	// figure out what example/description/links to put for each type of import
	var exampleList = ds_list_create();
	var descriptionList = ds_list_create();
	var linksList = ds_list_create();
	if (importTypeStr == "Plain text") {
		// example
		ds_list_add(exampleList, "We shall overcome,","We shall overcome,","We shall overcome, some day.","","Oh, deep in my heart,","I do believe","We shall overcome, some day.","","We'll walk hand in hand,","We'll walk hand in hand,","We'll walk hand in hand, some day.","","Oh, deep in my heart,","","We shall live in peace,","We shall live in peace,","We shall live in peace, some day.","","Oh, deep in my heart,","","We shall all be free,","We shall all be free,","We shall all be free, some day.","","Oh, deep in my heart,","","We are not afraid,","We are not afraid,","We are not afraid, TODAY","","Oh, deep in my heart,","","We shall overcome,","We shall overcome,","We shall overcome, some day.","","Oh, deep in my heart,","I do believe","We shall overcome, some day.");
		
		// description
		ds_list_add(descriptionList, "file extension: *.txt");
		ds_list_add(descriptionList, "songs, poems, etc.");
		ds_list_add(descriptionList, "short meaningful lines");
		
		// links
		ds_list_add(linksList, "https://rezonator.com");
		ds_list_add(linksList, "https://genius.com");
	}
	else if (importTypeStr == "Tab delimited") {
		// example
		ds_list_add(exampleList, "LENORE;    0.0    9.21    … So you don't need to go … borrow equipment from anybody,","LENORE;        9.21    9.52    to —","LENORE;        9.52    14.1    … to do the feet?","LENORE;        14.1    15.78    … [Do the hooves]?","LENORE;        56.94    57.79    [Did they train you-] —","LENORE;        58.34    59.29    [2Did] they train you that — ","LENORE;        59.29    60.06    #[3#]*","LENORE;        60.73    61.8    ‥ [So you have your] own equipment,","LENORE;        61.8    62.05    but,","LENORE;        131.39    131.59    yeah,","LENORE;        131.59    131.93    [I bet].","LENORE;        166.65    167.05    [mhm].","LENORE;        178.23    178.44    [really].","LENORE;        252.54    252.74    [(AHEM)]","LENORE;        254.12    254.64    [2(AHEM)]","LENORE;        265.43    265.73    [farrier]?","LENORE;        297.67    299.69    You sai[d you never] made the horseshoes,","LENORE;        299.69    299.9    but,","LENORE;        352.07    352.57    [So every] —","LENORE;        352.57    353.42    [2every] uh:,","LENORE;        353.42    354.53    horseshoe is made —","LENORE;        354.53    355.62    custom-made for the horse then?","LENORE;        400.94    401.15    [Right].","LENORE;        411.19    411.54    [(AHEM)]","LENORE;        421.78    422.69    [How many have you got].","LENORE;        424.04    424.29    twen[ty].","LENORE;        497.85    498.29    [#What].","LENORE;        516.71    519.309    [I thought] they used the (AHEM) the horsehooves in ‥ for gelatin,","LENORE;        519.309    520.059    That's not so?","LENORE;        636.97    637.34    [Right].","LENORE;        725.31    726.08    … [Yeah].","LENORE;        726.69    726.89    [2#]","LENORE;        737.16    737.44    [Yeah].","LENORE;        873.35    873.76    M[hm],","LENORE;        908.36    909.06    (TSK) Why:.");
		
		// description
		ds_list_add(descriptionList, "s");
		ds_list_add(descriptionList, "s");
		ds_list_add(descriptionList, "s");
		
		// links
		ds_list_add(linksList, "https://rezonator.com");
	}
	else if (importTypeStr == "Interlinear Glossed Text") {
		// example
		ds_list_add(exampleList, "W");
		ds_list_add(exampleList, "W");
		ds_list_add(exampleList, "W");
		ds_list_add(exampleList, "W");
		
		// description
		ds_list_add(descriptionList, "s");
		ds_list_add(descriptionList, "s");
		ds_list_add(descriptionList, "s");
		
		// links
		ds_list_add(linksList, "https://rezonator.com");
	}
	else if (importTypeStr == "CSV") {
		// example
		ds_list_add(exampleList, "W");
		ds_list_add(exampleList, "W");
		ds_list_add(exampleList, "W");
		ds_list_add(exampleList, "W");
		
		// description
		ds_list_add(descriptionList, "s");
		ds_list_add(descriptionList, "s");
		ds_list_add(descriptionList, "s");
		
		// links
		ds_list_add(linksList, "https://rezonator.com");
	}
	else if (importTypeStr == "CoNLL-U") {
		// example
		ds_list_add(exampleList, "W");
		ds_list_add(exampleList, "W");
		ds_list_add(exampleList, "W");
		ds_list_add(exampleList, "W");
		
		// description
		ds_list_add(descriptionList, "s");
		ds_list_add(descriptionList, "s");
		ds_list_add(descriptionList, "s");
		
		// links
		ds_list_add(linksList, "https://rezonator.com");
	}
	
	// add example/description/links to currentImportTypeMap
	ds_map_add_list(currentImportTypeMap, "example", exampleList);
	ds_map_add_list(currentImportTypeMap, "description", descriptionList);
	ds_map_add_list(currentImportTypeMap, "links", linksList);
	
	// add currentImportTypeMap to preImportMap
	ds_map_add_map(global.preImportMap, importTypeStr, currentImportTypeMap);
}
}
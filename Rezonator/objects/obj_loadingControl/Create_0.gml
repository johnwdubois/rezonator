show_debug_message("obj_loadingControl Create! nodeMap size: " + string(ds_map_size(global.nodeMap)) + scr_printTime());


importGridRow = 0;
importGridHeight = ds_grid_height(global.importGrid);
importGridWidth = ds_grid_width(global.importGrid);
c_ltblue = make_color_rgb(183, 183, 255);
finished = false;

// fill node map with default lists
scr_nodeMapDefaultData();

tokenList = ds_list_create();
unitList = ds_list_create();
displayUnitList = ds_list_create();

indexOfDisplayToken = ds_list_find_index(global.importGridColNameList, global.displayTokenField);
indexOfUnitDelim = ds_list_find_index(global.importGridColNameList, global.unitDelimField);
indexOfWordDelim = ds_list_find_index(global.importGridColNameList, global.wordDelimField);
indexOfSpeaker = ds_list_find_index(global.importGridColNameList, global.participantField);


global.tokenFieldList = ds_list_create();
global.unitFieldList = ds_list_create();


//create tag maps
tokenTagMap = ds_map_create();
unitTagMap  = ds_map_create();
scr_linkTagInit();
scr_chainTagInit();



// create corpus node
global.corpusNode = scr_addToNodeMap("corpus");
var corpusSubMap = global.nodeMap[? global.corpusNode];
var discourseList = ds_list_create();
ds_map_add_list(corpusSubMap, "docList", discourseList);

// create discourse node
global.discourseNode = scr_addToNodeMap("doc");
var docSubMap = global.nodeMap[? global.discourseNode];
ds_map_add_list(docSubMap, "tokenList", tokenList);
ds_map_add_list(docSubMap, "unitList", unitList);
ds_map_add_list(docSubMap, "displayUnitList", displayUnitList);
ds_list_add(discourseList, global.discourseNode);
var docTagMap = ds_map_create();
ds_map_add_map(docSubMap, "tagMap", docTagMap);

// if we are importing ai chat, we want to save all chat data
if (global.importType == IMPORTTYPE_AICHAT) {
	
	var aiChatDataList = ds_list_create();
	show_debug_message("saving chat data...");
	var _msgList = global.aiChatMsgList;
	var _msgListSize = ds_list_size(_msgList);
	for (var i = 0; i < _msgListSize; i++) {
		// get current message map
		var _msgMap = _msgList[| i];
		if (!scr_isNumericAndExists(_msgMap, ds_type_map)) continue;
		var _selected = _msgMap[? "selected"];
		
		// if this message is selected, let's get its original message data
		if (_selected) {
			var _msgOriginal = _msgMap[? "msgOriginal"];
			if (is_struct(_msgOriginal)) {
				ds_list_add(aiChatDataList, _msgOriginal);
			}
		}
	}
	
	// if we found any message data, we save it to the doc node
	if (ds_list_size(aiChatDataList) >= 1) {
		ds_map_add_list(docSubMap, "aiChat", aiChatDataList);
	}
	else {
		ds_list_destroy(aiChatDataList);
	}
}


currentUnitID = "";
currentEntryList = -1;


prevNodeMapSize = 0;
nodesPerSec = 0;
alarm[0] = fps;

prevFieldMap = ds_map_create();

global.RTLFound =  false;
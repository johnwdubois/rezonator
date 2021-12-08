// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_chainTagInit(){
	
	// initialize chain/entry field map
	global.chainFieldMap = ds_map_create();
	global.entryFieldMap = ds_map_create();
	
	global.chainFieldMap[?"type"] =  "map";
	global.entryFieldMap[?"type"] =  "map";
	
	ds_map_add_map(global.nodeMap,"chainTagMap",global.chainFieldMap);
	ds_map_add_map(global.nodeMap,"entryTagMap",global.entryFieldMap);
	
	ds_list_add(global.nodeMap[?"nodeList"], "chainTagMap", "entryTagMap");
	
	// list of all of the chain/entry level fields
	global.chainFieldList = ds_list_create();
	global.chainEntryFieldList = ds_list_create();
	
	/*
	// entityType (chain-level)
	var entityTypeTagSet = ds_list_create();
	var entityTypeShortcutSet = ds_list_create();
	ds_list_add(entityTypeTagSet, "person", "location", "organization", "thing", "event", "abstract", "substance", "quantity", "number", "date/time", "animal", "plant");
	ds_list_add(entityTypeShortcutSet, "P", "L", "O", "T", "E", "A", "S", "Q", "N", "D", "M", "");
	scr_addToChainFieldMap(global.chainFieldMap, "entityType", entityTypeTagSet, entityTypeShortcutSet, true, true, true);
	
	// chainSize (chain-level)
	scr_addToChainFieldMap(global.chainFieldMap, "chainSize", undefined, undefined, true, true, true);

	// gapUnits (entry-level)
	scr_addToChainFieldMap(global.entryFieldMap, "gapUnits", undefined, undefined, true, true, true);
	
	// gapWords (entry-level)
	scr_addToChainFieldMap(global.entryFieldMap, "gapWords", undefined, undefined, true, true, false);
	
	// tokenCount (entry-level)
	scr_addToChainFieldMap(global.entryFieldMap, "tokenCount", undefined, undefined, true, true, false);
	
	// charCount (entry-level)
	scr_addToChainFieldMap(global.entryFieldMap, "charCount", undefined, undefined, true, true, false);
	
	// person tags (entry-level)
	var personTagSet = ds_list_create();
	ds_list_add(personTagSet, "1", "2", "3");
	scr_addToChainFieldMap(global.entryFieldMap, "person", personTagSet, undefined, true, true, true);
	
	// number tags (entry-level)
	var numberTagSet = ds_list_create();
	var numberShortcutSet = ds_list_create();
	ds_list_add(numberTagSet, "sing", "plural", "dual", "paucal", "collective");
	ds_list_add(numberShortcutSet, "S", "P", "D", "F", "C");
	scr_addToChainFieldMap(global.entryFieldMap, "number", numberTagSet, numberShortcutSet, true, true, true);

	// gender tags (entry-level)
	var genderTagSet = ds_list_create();
	var genderShortcutSet = ds_list_create();
	ds_list_add(genderTagSet, "fem", "masc", "neuter");
	ds_list_add(genderShortcutSet, "F", "M", "N");
	scr_addToChainFieldMap(global.entryFieldMap, "gender", genderTagSet, genderShortcutSet, true, true, false);
	
	// definite tags (entry-level)
	var definiteTagSet = ds_list_create();
	var definiteShortcutSet = ds_list_create();
	ds_list_add(definiteTagSet, "definite", "indefinite", "neutral");
	ds_list_add(definiteShortcutSet, "D", "I", "N");
	scr_addToChainFieldMap(global.entryFieldMap, "definite", definiteTagSet, definiteShortcutSet, true, true, true);

	// pronType tags (entry-level)
	var pronTypeTagSet = ds_list_create();
	var pronTypeShortcutSet = ds_list_create();
	ds_list_add(pronTypeTagSet, "personal", "other");
	ds_list_add(pronTypeShortcutSet, "P", "O");
	scr_addToChainFieldMap(global.entryFieldMap, "pronType", pronTypeTagSet, pronTypeShortcutSet, true, true, false);
	
	// possessor tags (entry-level)
	var possessorTagSet = ds_list_create();
	var possessorShortcutSet = ds_list_create();
	ds_list_add(possessorTagSet, "possessor");
	ds_list_add(possessorShortcutSet, "P");
	scr_addToChainFieldMap(global.entryFieldMap, "possessor", possessorTagSet, possessorShortcutSet, true, true, true);
	
	// reflexive tags (entry-level)
	var reflexiveTagSet = ds_list_create();
	var reflexiveShortcutSet = ds_list_create();
	ds_list_add(reflexiveTagSet, "reflexive");
	ds_list_add(reflexiveShortcutSet, "R");
	scr_addToChainFieldMap(global.entryFieldMap, "reflexive", reflexiveTagSet, reflexiveShortcutSet, true, true, true);
	
	// numType tags (entry-level)
	var numTypeTagSet = ds_list_create();
	var numTypeShortcutSet = ds_list_create();
	ds_list_add(numTypeTagSet, "cardinal", "ordinal");
	ds_list_add(numTypeShortcutSet, "C", "O");
	scr_addToChainFieldMap(global.entryFieldMap, "numType", numTypeTagSet, numTypeShortcutSet, true, true, true);
	
	// lexicality tags (entry-level)
	var lexicalityTagSet = ds_list_create();
	var lexicalityShortcutSet = ds_list_create();
	ds_list_add(lexicalityTagSet, "cardinal", "ordinal");
	ds_list_add(lexicalityShortcutSet, "C", "O");
	scr_addToChainFieldMap(global.entryFieldMap, "lexicality", lexicalityTagSet, lexicalityShortcutSet, true, true, true);
	
	// agreement tags (entry-level)
	var agreementTagSet = ds_list_create();
	var agreementShortcutSet = ds_list_create();
	ds_list_add(agreementTagSet, "concord", "index", "opaque-index");
	ds_list_add(agreementShortcutSet, "C", "I", "O");
	scr_addToChainFieldMap(global.entryFieldMap, "agreement", agreementTagSet, agreementShortcutSet, true, true, true);
	
	// markCount tags (entry-level)
	var markCountTagSet = ds_list_create();
	var markCountShortcutSet = ds_list_create();
	ds_list_add(markCountTagSet, "0", "1", "2");
	ds_list_add(markCountShortcutSet, "0", "1", "2");
	scr_addToChainFieldMap(global.entryFieldMap, "markCount", markCountTagSet, markCountShortcutSet, true, true, true);
	*/

}
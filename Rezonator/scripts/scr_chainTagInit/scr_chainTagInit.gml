// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_chainTagInit(){
	
	// initialize entry field map
	global.entryFieldMap = ds_map_create();
	
	// list of all of the entry level fields
	global.chainEntryFieldList = ds_list_create();

	// gapUnits
	scr_addToEntryFieldMap("gapUnits", undefined, undefined, true, true, true);
	
	// gapWords
	scr_addToEntryFieldMap("gapWords", undefined, undefined, true, true, false);
	
	// tokenCount
	scr_addToEntryFieldMap("tokenCount", undefined, undefined, true, true, false);
	
	// charCount
	scr_addToEntryFieldMap("charCount", undefined, undefined, true, true, false);
	
	// person tags
	var personTagSet = ds_list_create();
	ds_list_add(personTagSet, "1", "2", "3");
	scr_addToEntryFieldMap("person", personTagSet, undefined, true, true, true);
	
	// number tags
	var numberTagSet = ds_list_create();
	var numberShortcutSet = ds_list_create();
	ds_list_add(numberTagSet, "sing", "plural", "dual", "paucal", "collective");
	ds_list_add(numberShortcutSet, "S", "P", "D", "F", "C");
	scr_addToEntryFieldMap("number", numberTagSet, numberShortcutSet, true, true, true);

	// gender tags
	var genderTagSet = ds_list_create();
	var genderShortcutSet = ds_list_create();
	ds_list_add(genderTagSet, "fem", "masc", "neuter");
	ds_list_add(genderShortcutSet, "F", "M", "N");
	scr_addToEntryFieldMap("gender", genderTagSet, genderShortcutSet, true, true, false);
	
	// definite tags
	var definiteTagSet = ds_list_create();
	var definiteShortcutSet = ds_list_create();
	ds_list_add(definiteTagSet, "definite", "indefinite", "neutral");
	ds_list_add(definiteShortcutSet, "D", "I", "N");
	scr_addToEntryFieldMap("definite", definiteTagSet, definiteShortcutSet, true, true, true);

	// pronType tags
	var pronTypeTagSet = ds_list_create();
	var pronTypeShortcutSet = ds_list_create();
	ds_list_add(pronTypeTagSet, "personal", "other");
	ds_list_add(pronTypeShortcutSet, "P", "O");
	scr_addToEntryFieldMap("pronType", pronTypeTagSet, pronTypeShortcutSet, true, true, false);
	
	// possessor tags
	var possessorTagSet = ds_list_create();
	var possessorShortcutSet = ds_list_create();
	ds_list_add(possessorTagSet, "possessor");
	ds_list_add(possessorShortcutSet, "P");
	scr_addToEntryFieldMap("possessor", possessorTagSet, possessorShortcutSet, true, true, true);
	
	// reflexive tags
	var reflexiveTagSet = ds_list_create();
	var reflexiveShortcutSet = ds_list_create();
	ds_list_add(reflexiveTagSet, "reflexive");
	ds_list_add(reflexiveShortcutSet, "R");
	scr_addToEntryFieldMap("reflexive", reflexiveTagSet, reflexiveShortcutSet, true, true, true);
	
	// numType tags
	var numTypeTagSet = ds_list_create();
	var numTypeShortcutSet = ds_list_create();
	ds_list_add(numTypeTagSet, "cardinal", "ordinal");
	ds_list_add(numTypeShortcutSet, "C", "O");
	scr_addToEntryFieldMap("numType", numTypeTagSet, numTypeShortcutSet, true, true, true);
	
	// lexicality tags
	var lexicalityTagSet = ds_list_create();
	var lexicalityShortcutSet = ds_list_create();
	ds_list_add(lexicalityTagSet, "cardinal", "ordinal");
	ds_list_add(lexicalityShortcutSet, "C", "O");
	scr_addToEntryFieldMap("lexicality", lexicalityTagSet, lexicalityShortcutSet, true, true, true);
	
	// agreement tags
	var agreementTagSet = ds_list_create();
	var agreementShortcutSet = ds_list_create();
	ds_list_add(agreementTagSet, "concord", "index", "opaque-index");
	ds_list_add(agreementShortcutSet, "C", "I", "O");
	scr_addToEntryFieldMap("agreement", agreementTagSet, agreementShortcutSet, true, true, true);
	
	// markCount tags
	var markCountTagSet = ds_list_create();
	var markCountShortcutSet = ds_list_create();
	ds_list_add(markCountTagSet, "0", "1", "2");
	ds_list_add(markCountShortcutSet, "0", "1", "2");
	scr_addToEntryFieldMap("markCount", markCountTagSet, markCountShortcutSet, true, true, true);
	

}
// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_importGridOptions(optionSelected){
	switch(optionSelected){
		
		case "Field Info":
			obj_importMapping.currentGridName = "Field Info";
			obj_importMappingTagInfo.gridViewing = global.tagInfoGrid;
		break;
		
		case "Import Source":
			obj_importMapping.currentGridName = "Import Source";	
			obj_importMappingTagInfo.gridViewing = global.importTXTLineGrid;
		break;	
		
		case "Block Type":
			obj_importMapping.currentGridName = "Block Type";
			obj_importMappingTagInfo.gridViewing = global.blockTypeGrid;
		break;	
		
		case "Blocks":
			obj_importMapping.currentGridName = "Blocks";
			obj_importMappingTagInfo.gridViewing = global.blockGrid;
		break;
		
		case "Field Relations":
			obj_importMapping.currentGridName = "Field Relations";	
			obj_importMappingTagInfo.gridViewing = global.fieldRelationHelperGrid;
		break;		

		
	}
}
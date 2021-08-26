// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_importGridOptions(optionSelected){
	switch(optionSelected){
		
		case "import_field-info":
			obj_importMapping.currentGridName = "import_field-info";
			obj_importMappingTagInfo.gridViewing = global.tagInfoGrid;

		break;
		
		case "import_source":
			obj_importMapping.currentGridName = "import_source";	
			obj_importMappingTagInfo.gridViewing = global.importTXTLineGrid;

		break;	
		
		case "import_block-type":
			obj_importMapping.currentGridName = "import_block-type";
			obj_importMappingTagInfo.gridViewing = global.blockTypeGrid;

		break;	
		
		case "import_blocks":
			obj_importMapping.currentGridName = "import_blocks";
			obj_importMappingTagInfo.gridViewing = global.blockGrid;

		break;
		
		case "import_field-relations":
			obj_importMapping.currentGridName = "import_field-relations";	
			obj_importMappingTagInfo.gridViewing = global.fieldRelationHelperGrid;
		break;		

		
	}
	

}
pickwhippedRow = -1;

showDevVars = false;


pickwhipColorNormal = c_blue;
pickwhipColorRequired = c_red;

continueButtonActive = false;







rezInfoGridSelectedRow = -1;
tagInfoGridSelectedRow = -1;



tagColorList = ds_list_create();
ds_list_add(tagColorList, c_red, c_blue, c_green, c_yellow, c_purple, c_olive, c_orange);
ds_list_add(tagColorList, c_teal, c_fuchsia, c_lime);




tagInfoGridWidth = 7;
tagInfoGrid_colTag = 0;
tagInfoGrid_colExample = 1;
tagInfoGrid_colConsistency = 2;
tagInfoGrid_colGroup = 3;
tagInfoGrid_colConstPerCluster = 4;
tagInfoGrid_colMapped = 5;
tagInfoGrid_colColor = 6;
tagInfoGrid = ds_grid_create(tagInfoGridWidth, 0);

scr_importInfoGrid();

if(global.plainText){	
	instance_create(0,0,obj_importPlainTextInfo);
}
else{
	instance_create(0,0,obj_importMappingRezInfo);
	instance_create(0,0,obj_importMappingTagInfo);
}


//scr_importMappingGroups();
scr_markAutoExceptions();


scr_importTXTExceptions();
scr_importInfoGrid();
		
//instance_create(0, 0, obj_importMappingRezInfo);
instance_create(0, 0, obj_importMappingTagInfo);
instance_create(0, 0, obj_exceptionsWindow);



instance_destroy();
//scr_importTXTExceptions();
show_debug_message("obj_importException Alarm 0");
scr_importInfoGrid();


instance_create_layer(0, 0, "InstancesDialogue", obj_importMappingTagInfo);
instance_create_layer(0, 0, "InstancesDialogue", obj_exceptionsWindow);
instance_create_layer(0, 0, "InstancesDialogue", obj_summaryWindow);


instance_destroy();
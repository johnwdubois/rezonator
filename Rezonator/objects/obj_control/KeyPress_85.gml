//if (keyboard_check(vk_control)) {
//	hideAll = !hideAll;
	
//	if (hideAll) {
//		instance_create_layer(0, 0, "InstancesDialogue", obj_exportWindowGridList);
//		instance_create_layer(0, 0, "InstancesDialogue", obj_exportWindowGridContents);
//	}
//}

if (!shortcutsEnabled || dialogueBoxActive) {
	exit;
}


obj_control.showUnitTags = !obj_control.showUnitTags;
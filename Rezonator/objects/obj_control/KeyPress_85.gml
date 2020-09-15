//if (keyboard_check(vk_control)) {
//	hideAll = !hideAll;
	
//	if (hideAll) {
//		instance_create(0, 0, obj_exportWindowGridList);
//		instance_create(0, 0, obj_exportWindowGridContents);
//	}
//}

if (!shortcutsEnabled || dialogueBoxActive) {
	exit;
}


obj_control.showUnitTags = !obj_control.showUnitTags;
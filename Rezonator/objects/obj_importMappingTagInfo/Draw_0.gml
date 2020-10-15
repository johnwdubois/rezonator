if (gridViewing == global.tagInfoGrid) {
	scr_importMappingTagInfo();
}
else {
	scr_importDebugGridDraw();
}

if (keyboard_check(vk_control) and keyboard_check_released(ord("G"))) {
	if (gridViewing == global.tagInfoGrid) {
		gridViewing = global.importTXTLineGrid;
	}
	else if (gridViewing == global.importTXTLineGrid) {
		gridViewing = global.blockTypeGrid;
	}
	else if (gridViewing == global.blockTypeGrid) {
		gridViewing = global.blockGrid;
	}
	else if (gridViewing == global.blockGrid) {
		gridViewing = global.fieldRelationGrid;
	}
	else if (gridViewing == global.fieldRelationGrid) {
		gridViewing = global.tagInfoGrid;
	}
}
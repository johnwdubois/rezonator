function scr_jumpToTime(timeStr) {
	
	if (timeStr == "") {
		exit;
	}
	
	if (!scr_isStrNumeric(timeStr)) {
		
		var inst = instance_create_layer(0, 0, "InstancesDialogue", obj_dialogueBox);
		inst.alertWindowActive = true;
		obj_control.insertAnyNumber = true;
		exit;
	}

	var timeStrReal = real(timeStr);
	var discourseSubMap = global.nodeMap[?global.discourseNode];
	var unitList = discourseSubMap[? "unitList"];
	
	var unitListSize = ds_list_size(unitList);
	
	for (var i = 0; i < unitListSize; i++) {
	
		var currentUnit = unitList[|i];
		var currentUnitSubMap = global.nodeMap[?currentUnit];
		
		var currentUnitStart = string(currentUnitSubMap[? "unitStart"]);
		var currentUnitEnd = string(currentUnitSubMap[? "unitEnd"]);
		
		if (scr_isStrNumeric(currentUnitStart) && scr_isStrNumeric(currentUnitEnd)) {
			currentUnitStart = real(currentUnitStart);
			currentUnitEnd = real(currentUnitEnd);
			if (currentUnitStart < timeStrReal && timeStrReal < currentUnitEnd) {
				scr_jumpToUnitTop(currentUnit);
				exit;
			}
		}
	}
	
}

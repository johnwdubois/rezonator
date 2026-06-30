/// @description Secondary accent

// alexluu: https://github.com/johnwdubois/rezonator/issues/1526
// with Ctrl
// prepose "`" in the field "transcript" of the word token that is hovered over
// e.g. "feet" -> "`feet"
// references: Key Press - Z, obj_inputBox - Destroy

if (!obj_control.dialogueBoxActive) {
	if (is_string(obj_control.hoverTokenID) && obj_control.hoverTokenID != "") {
		// https://manual.gamemaker.io/monthly/en/#t=GameMaker_Language%2FGML_Reference%2FGame_Input%2FKeyboard_Input%2FKeyboard_Input.htm
		// also see scr_ctrlHold - Key Press F/O: if (global.ctrlHold) {...}
		if (keyboard_check(vk_control)) {
			tokenID = obj_control.hoverTokenID;
			field = "transcript";
			var idSubMap = global.nodeMap[? tokenID];
			var tagMap = idSubMap[? "tagMap"];
			tagMap[? field] = "`" + tagMap[? field];			
		}
	}
}
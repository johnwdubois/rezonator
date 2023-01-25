

function scr_removeFieldTagQuestionPrompt(fieldOrTag, unitOrChain, oneManyOrOneOne, optionSelected) {
	
	show_debug_message("scr_removeFieldTagQuestionPromp... fieldOrTag: " + string(fieldOrTag) + ", unitOrChain: " + string(unitOrChain) + ", oneManyOrOneOne: " + string(oneManyOrOneOne) + ", optionSelected: " + string(optionSelected));

	if (!instance_exists(obj_dialogueBox)) {
		instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
		obj_dialogueBox.stringToBeRemoved = optionSelected;
		obj_dialogueBox.questionWindowActive = true;
	}
	
	
	// remove tags
	if (fieldOrTag == "tag") {
		if (unitOrChain == "unit") {
			if (oneManyOrOneOne == "1toMany") obj_dialogueBox.removeTagToken = true;
			else if (oneManyOrOneOne == "1to1") obj_dialogueBox.removeTagUnit = true;
		}
		else if (unitOrChain == "chain") {
			if (oneManyOrOneOne == "1toMany") obj_dialogueBox.removeTagEntry = true;
			else if (oneManyOrOneOne == "1to1") obj_dialogueBox.removeTagChain = true;
		}
		else if (unitOrChain == "chunk") {
			obj_dialogueBox.removeTagChunk = true;
		}
		else if (unitOrChain == "link") {
			obj_dialogueBox.removeTagLink = true;
		}
	}
	// remove fields
	else if (fieldOrTag == "field") {
		if (unitOrChain == "unit") {
			if (oneManyOrOneOne == "1toMany") obj_dialogueBox.removeFieldToken = true;
			else if (oneManyOrOneOne == "1to1") obj_dialogueBox.removeFieldUnit = true;
		}
		else if (unitOrChain == "chain") {
			if (oneManyOrOneOne == "1toMany") obj_dialogueBox.removeFieldEntry = true;
			else if (oneManyOrOneOne == "1to1") obj_dialogueBox.removeFieldChain = true;
		}
		else if (unitOrChain == "chunk") {
			obj_dialogueBox.removeFieldChunk = true;
		}
		else if (unitOrChain == "link") {
			obj_dialogueBox.removeFieldLink = true;
		}
	}
	
	
	
	
}

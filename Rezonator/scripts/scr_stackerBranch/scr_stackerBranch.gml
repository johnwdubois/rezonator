

function scr_stackerBranch(){
	with (obj_stacker) {
		if (createStacksRandom) {
			splitSave = true;
			alarm[1] = 1;
		}
		else if (createStacksTurn) {
			splitSave = true;
			alarm[4] = 1;
		}
		else if (createStacksSentence) {
			alarm[6] = 1;
		}
		else if (createStacksClique) {
			alarm[9] = 1;
		}
		else if (createStacksClique) {
			alarm[9] = 1;
		}
		createStacksRandom = false;
		createStacksTurn = false;
		createStacksSentence = false;
		confirmStackCreate = false;
		createStacksClique = false;
		createStacksPsent = false;
	}
}
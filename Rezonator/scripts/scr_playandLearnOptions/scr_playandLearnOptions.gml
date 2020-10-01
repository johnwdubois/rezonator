// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_playandLearnOptions(optionSelected){
	

	switch (optionSelected)
	{
		case "Where's Elmo":
						
			global.skipToPlayandLearn = true;
			room_goto(rm_openingScreen);
		break;
	}
	instance_destroy();
}

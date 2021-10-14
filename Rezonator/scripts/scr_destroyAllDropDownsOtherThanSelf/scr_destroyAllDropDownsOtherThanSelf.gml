// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_destroyAllDropDownsOtherThanSelf(){
	var selfID = self;
	var myLevel = level;
	with (obj_dropDown) {
		if(level > myLevel){

			instance_destroy();

		}
	}
}
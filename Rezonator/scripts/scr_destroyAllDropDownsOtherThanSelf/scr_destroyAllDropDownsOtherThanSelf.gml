

function scr_destroyAllDropDownsOtherThanSelf() {
	var selfID = self;
	var myLevel = level;
	with (obj_dropDown) {
		if (level > myLevel) {

			instance_destroy();

		}
	}
}
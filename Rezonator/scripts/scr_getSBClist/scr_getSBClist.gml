function scr_getSBClist() {
	
	var sbclist = ds_list_create();
	for (var i = 1; i <= 10; i++) {
		var numStrPrepend = i == 10 ? "0" : "00";
		ds_list_add(sbclist, "sbc" + numStrPrepend + string(i));
	}
	ds_list_add(sbclist, "sbc043");
	
	return sbclist;
}
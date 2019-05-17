windowWidth = 300;
windowHeight = 300;

clipSurface = -1;

clipX = 50;
clipY = 50;






valueList = ds_list_create();
for (var i = 0; i < 20; i++) {
	ds_list_add(valueList, "blah " + string(i));
}


scrollBarWidth = 20;
scrollBarHeight = 0;
scrollPlusY = 0;
scrollBarPlusY = 0;
windowResizeYHolding = false;
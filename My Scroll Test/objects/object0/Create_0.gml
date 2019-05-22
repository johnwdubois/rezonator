windowWidth = 300;
windowHeight = 300;

clipSurface = -1;

clipX = 50;
clipY = 50;






valueList = ds_list_create();
for (var i = 0; i < 20; i++) {
	ds_list_add(valueList, "blah " + string(i));
}
valueSelected = 0;



// scrollbar variables
scrollBarHolding = false;
scrollBarUpButtonHeld = false;
scrollBarDownButtonHeld = false;
scrollBarWidth = 20;
scrollBarHeight = 0;
scrollPlusY = 0;
scrollPlusYDest = 0;
scrollBarPlusY = 0;

windowResizeXHolding = false;
windowResizeYHolding = false;

font = fnt_size1;
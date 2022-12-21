

function scr_randomChainColor(){

	obj_chain.chainHue += random_range(50, 100);
	if (obj_chain.chainHue > 255) {
		obj_chain.chainHue -= 255;
	}
	while( obj_chain.chainHue > 30 && obj_chain.chainHue < 70){
		obj_chain.chainHue = random_range(0, 255);
	}

	return make_color_hsv(obj_chain.chainHue, random_range(125, 255), random_range(200, 255));

}
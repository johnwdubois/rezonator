scale = random_range(0.1, 30);
angle = random(360);
alarm[0] = irandom_range(20, 200);


x = random(camera_get_view_width(view_camera[0]));
y = random(camera_get_view_height(view_camera[0]));

col = make_color_hsv(obj_chain.chainHue, random_range(125, 255), random_range(200, 255));
obj_chain.chainHue += random_range(50, 200);
if (obj_chain.chainHue > 255) {
	obj_chain.chainHue -= 255;
}
while( obj_chain.chainHue > 30 && obj_chain.chainHue < 70) {
	obj_chain.chainHue = random_range(0, 255);
}

var snd = audio_play_sound(choose(snd_buh1, snd_buh2), 10, false);
audio_sound_gain(snd, random(1), 0);
audio_sound_pitch(snd, random_range(0.2, 2));


direction = random(360);
speed = random(5);
spinSpeed = random_range(-3, 3);
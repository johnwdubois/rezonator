windowWidth = 100;
windowHeight = 100;

scr_adaptFont("", "M", false);

sizeWindowFont = draw_get_font();

windowWidth = string_width(" ") * 40;
windowHeight = string_height("0") * 10;

// set size window coordinates
var camWidth = camera_get_view_width(camera_get_active());
x = camWidth - (windowWidth * 1.05);
y = (obj_menuBar.menuHeight * 1.3);

fontSliderHolding = false;
colSliderHolding = false;
rowSliderHolding = false;
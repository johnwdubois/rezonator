windowWidth = 100;
windowHeight = 100;

scr_adaptFont("", "M", false);

sizeWindowFont = draw_get_font();

windowWidth = string_width(" ") * 40;
windowHeight = room == rm_openingScreen || room == rm_aiChat ? string_height("0") * 4 : string_height("0") * 12;

// set size window coordinates
var camWidth = camera_get_view_width(camera_get_active());
x = camWidth - (windowWidth * 1.05);
y = (obj_menuBar.menuHeight * 1.3);

fontSliderHolding = false;
colWidthSliderHolding = false;
proseWidthSliderHolding = false;
rowHeightSliderHolding = false;
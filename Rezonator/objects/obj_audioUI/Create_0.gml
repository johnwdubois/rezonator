windowWidth = camera_get_view_width(view_camera[0]) - global.scrollBarWidth;
windowHeight = 100;
x = 0;
y = camera_get_view_height(view_camera[0]) - windowHeight;
visible = false;

windowResizeYHolding = false;



seekBarWidth = 500;
seekBarHeight = 3;
seekBarX1 = 0;
seekBarY1 = 0;
seekBarX2 = 0;
seekBarY2 = 0;

playheadX = 0;
playheadY = 0;
playheadRadBig = 10;
playheadRadSmall = 6;
playheadRad = playheadRadSmall;
playheadRadDest = playheadRadSmall;
playheadHolding = false;

audioFile = "";
audioStream = -1;
audioSound = -1;
audioLength = 0;
audioPos = 0;
audioPosTemp = 0;

audioPaused = true;

audioJumpOnWordClick = true;
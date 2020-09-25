windowWidth = camera_get_view_width(camera_get_active()) - global.scrollBarWidth;
windowHeight = 100;
x = 0;
y = camera_get_view_height(camera_get_active()) - windowHeight;
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
mouseOverAudioUI = false;
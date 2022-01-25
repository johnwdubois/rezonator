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

volumeSliderX = 0;
volumeSliderY = 0;

playheadRadBig = 10;
playheadRadSmall = 6;
playheadRad = playheadRadSmall;
playheadRadDest = playheadRadSmall;
volumeRad = playheadRadSmall;
volumeDest = playheadRadSmall;
playheadHolding = false;
volumeHolding = false;

audioFile = "";
audioStream = -1;
audioSound = -1;
audioLength = 0;
audioPos = 0;
audioPosTemp = 0;
audioVolume = 1;

bookmarkX = 0;
bookmarkY = 0;
endmarkX = 0;
endmarkY = 0;

audioPaused = true;

audioJumpOnWordClick = false;
mouseOverAudioUI = false;

bookmarkStartTime = -1;
bookmarkEndTime = -1;


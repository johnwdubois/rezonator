x = camera_get_view_width(camera_get_active()) / 2;
y = camera_get_view_height(camera_get_active()) / 2;
camWidth = camera_get_view_width(camera_get_active());
camHeight = camera_get_view_height(camera_get_active());

myAlpha = 1;
alphaDrop = false;
if (room != rm_openingScreen) alarm[0] = 8;

loadRatio = 0;
loadRatioDest = 0;
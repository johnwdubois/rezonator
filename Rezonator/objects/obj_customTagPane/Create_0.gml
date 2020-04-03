windowWidth = camera_get_view_width(view_camera[0]) / 2;
windowHeight = camera_get_view_height(view_camera[0]) / 2;

subPaneBufferX = 20;
subPaneBufferY = 60;

instance_create_depth(x, y, -9999, obj_customTag_labelPane);
instance_create_depth(x, y, -9999, obj_customTag_tagListPane);

selectedLabel = 0;
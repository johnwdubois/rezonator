windowWidth = camera_get_view_width(camera_get_active()) / 2;
windowHeight = camera_get_view_height(camera_get_active()) / 2;

subPaneBufferX = 20;
subPaneBufferY = 60;

instance_create_depth(x, y, -9999, obj_customTag_labelPane);
instance_create_depth(x, y, -9999, obj_customTag_tagListPane);

selectedLabel = 0;
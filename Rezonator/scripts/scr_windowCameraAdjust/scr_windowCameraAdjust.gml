function scr_windowCameraAdjust() {
	
	if (global.html5 && os_type != os_linux) {
		
		var base = browser_width;
		var browserWidth = browser_width;
		var browserHeight = browser_height;
		
		view_wport[0] = browserWidth;
		view_hport[0] = browserHeight;
		
		window_set_size(browserWidth, browserHeight);
		window_center();
		
		var aspect = browserWidth / browserHeight;
		var viewWidth = 0;
		var viewHeight = 0;
		if (aspect < 1) {
			viewWidth = base * aspect;
			viewHeight = base;
		}
		else {
			viewWidth = base;
			viewHeight = base / aspect;
		}
		
		camera_set_view_size(view_camera[0], viewWidth, viewHeight);
		surface_resize(application_surface, view_wport[0], view_hport[0]);
		
		exit;
	}
	
	
	var windowWidth = window_get_width();
	var windowHeight = window_get_height();

	if (windowWidth < 1 or windowHeight < 1) {
		exit;
	}

	view_hport[0] = windowHeight;
	view_wport[0] = windowWidth;

	surface_resize(application_surface, windowWidth, windowHeight);

	camera_set_view_size(camera_get_active(), windowWidth, windowHeight);


}

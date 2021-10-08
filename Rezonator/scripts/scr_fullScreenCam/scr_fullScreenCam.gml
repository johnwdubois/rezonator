// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_fullScreenCam(){
	
	scr_windowCameraAdjust();
	exit;
	
	var base = browser_width;
	var _bw = browser_width;
	var _bh = browser_height;

	view_wport[0] = _bw;
	view_hport[0] = _bh;

	window_set_size(_bw, _bh);
	window_center();

	var _aspect = (_bw / _bh);
	if (_aspect < 1)
	    {
		var _vw = base * _aspect;
		var _vh = base;
	    }
	else
	    {
	    _vw = base;
	    _vh = base / _aspect;
	    }
	
	camera_set_view_size(view_camera[0], _vw, _vh);
	surface_resize(application_surface, view_wport[0], view_hport[0]);

}
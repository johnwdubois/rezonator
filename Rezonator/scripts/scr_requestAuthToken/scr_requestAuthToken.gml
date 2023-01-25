function scr_requestAuthToken() {
show_debug_message("scr_requestAuthToken called!~");

//body
var _body_map = ds_map_create();
ds_map_add(_body_map,"returnSecureToken","true");
var _body = json_encode(_body_map);

//header
var _header_map = ds_map_create();
ds_map_add(_header_map,"Content-Type", "application/json");


//request
var _auth_request_id = http_request(auth_location_, "POST", _header_map,_body);
ds_map_replace(request_ids_, REQUEST_TYPE.auth, _auth_request_id);
show_debug_message("request_ids_ map size: " + string(ds_map_size(request_ids_)));
var _timeout = date_get_second_of_year(date_current_datetime()) + timeout_limit_;
ds_map_replace(timeout_timers_,REQUEST_TYPE.auth,_timeout);

//cleanup
ds_map_destroy(_body_map);
ds_map_destroy(_header_map);

}
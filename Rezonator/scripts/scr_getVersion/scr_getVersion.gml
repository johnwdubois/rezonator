function scr_getVersion() {
	show_debug_message("scr_getVersion!~");

	var _body = "";

	var _header_map = ds_map_create();

	var url = database_url_ + ".json";

	//request
	var _table_get_id = http_request(url,"GET",_header_map,_body);
	ds_map_replace(request_ids_,REQUEST_TYPE.update,_table_get_id);
	var _timeout = date_get_second_of_year(date_current_datetime())+timeout_limit_;

	ds_map_replace(timeout_timers_,REQUEST_TYPE.update,_timeout);

	//cleanup
	ds_map_destroy(_header_map);
}
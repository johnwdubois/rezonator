// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_sendNodeMap(){

show_debug_message("scr_submitScore called!~");

var _body_map = ds_map_create();
//_body_map = json_decode(json_encode(global.nodeMap));
var _body = json_encode(_body_map);


var _header_map = ds_map_create();

var url = database_url_ + ".json?auth="+auth_token_;

//request
var _table_get_id = http_request(url,"PUT",_header_map,_body);

//show_debug_message(string(ds_map_size(_table_get_id)));
ds_map_replace(request_ids_,REQUEST_TYPE.submit,_table_get_id);
var _timeout = date_get_second_of_year(date_current_datetime())+timeout_limit_;

ds_map_replace(timeout_timers_,REQUEST_TYPE.submit,_timeout);

//cleanup
ds_map_destroy(_body_map);
ds_map_destroy(_header_map);

}

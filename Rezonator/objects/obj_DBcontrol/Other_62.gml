/// @description Insert description here
// You can write your code in this editor
/// @description Insert description here
// You can write your code in this editor
var _packet_id = async_load[? "id"];
var _status = async_load[? "status"];

if (_status == 0) {
	
	var _result = async_load[? "result"];
	var _http_status = string_digits(string(async_load[? "http_status"]));
	
	var _size = ds_map_size(request_ids_);
	var _key = ds_map_find_first(request_ids_);
	for (var i = 0; i < _size; i++) {
		if (request_ids_[? _key] == _packet_id) {
			var _packet_type = real(_key);
			continue;
		}
		_key = ds_map_find_next(timeout_timers_, _key);
	}
	
	show_debug_message("_packet_type: " + string(_packet_type));
	if (is_undefined(_packet_type)) exit;
}
else {
	exit;
}

// http status 200 is OK, 401 is ok but failed because you did somethin wrong
switch(_packet_type) {
	case REQUEST_TYPE.auth:
	#region Authorization request
	show_debug_message("REQUEST_TYPE.auth, _result: " + string(_result) + ", _http_status: " + string(_http_status));
	if (_http_status == "200") {
		if (_result == "null") {
			show_debug_message("Authentication failed, probs request denied due to server rules :(");
		}
		else {
			show_debug_message("Authentication successful, probably :o");
			var _result_map = json_decode(_result);
			auth_token_ = _result_map[? "idToken"];
			refresh_token_ = _result_map[? "refreshToken"];
			uid_ = _result_map[? "localId"];
			session_refresh_time_ = date_get_second_of_year(date_current_datetime()) + session_ttl_;
			if (session_refresh_time_ >= 31557600) session_refresh_time_ -= 31557600; // for year rollover
			show_debug_message("Auth-Token: " + auth_token_);
			show_debug_message("UID: " + uid_);
			ds_map_destroy(_result_map);
			
			scr_submitScore();
		}
		
		ds_map_delete(request_ids_, _packet_type);
		ds_map_delete(timeout_timers_, _packet_type);
	}
	else if (_http_status == "401") {
		
		show_debug_message("Authentication failed!!!!! HTTP401 >:(");
		ds_map_delete(request_ids_, _packet_type);
		ds_map_delete(timeout_timers_, _packet_type);
		
	}
	#endregion
	break;
	

	case REQUEST_TYPE.submit:
	#region Submit high score
	show_debug_message("REQUEST_TYPE.submit");
	if (_http_status == "200") {
		show_debug_message("Score submitted successfully :) HTTP200");
		
		ds_map_delete(request_ids_, _packet_type);
		ds_map_delete(timeout_timers_, _packet_type);
		
		scr_updateHighscore();
		exit;
	}
	else if (_status == "401") {
		show_debug_message("Write attempt denied, HTTP401");
		
		ds_map_delete(request_ids_, _packet_type);
		ds_map_delete(timeout_timers_, _packet_type);
		exit;
	}
	#endregion
	break;

	case REQUEST_TYPE.get:
	#region Get current high score
	show_debug_message("REQUEST_TYPE.get");
	if (_http_status == "200") {
		
		show_debug_message("Current high score get request successful!");
		
		if (_result == "null") {
			show_debug_message("No result while trying to get previous high score, probably didn't have one somehow");
		}
		else {
			var _saved_score = real(_result);
			
			if (score_ > _saved_score) {
				show_debug_message("Submitting new high score");
				scr_submitScore();
			}
			else {
				show_debug_message("low score, not bothering to submit you idiot");
			}
		}
		
		ds_map_delete(request_ids_, _packet_type);
		ds_map_delete(timeout_timers_, _packet_type);
	}
	else if (_http_status == "401") {
		show_debug_message("CURRENT HIGH SCORE GET REQUEST DENIED HTTP401 FUCK YOU FUCK YOU");
		
		ds_map_delete(request_ids_, _packet_type);
		ds_map_delete(timeout_timers_, _packet_type);
	}
	#endregion
	break;
	
	case REQUEST_TYPE.update:
	#region Update high score table
	show_debug_message("REQUEST_TYPE.update   , _http_status : " + string(_http_status));
	if (_http_status == "200") {
		show_debug_message("version number update request successful");
		
		if (_result == "null") {
			show_debug_message("Something happened, you got no results hahaha");
		}
		else {
			#region Convert JSON to sortable grid and save it
			show_debug_message(_result)
			var _result_map = json_decode(_result);
			var _size = ds_map_size(_result_map);
			var _key = ds_map_find_first(_result_map);
			newestVersionNum = _result_map[?_key];

			
			//cleanup

			ds_map_destroy(_result_map);
			#endregion
			
			if(is_string(newestVersionNum)){
				if(string_length(newestVersionNum) > 0 ){
				var newVersionString = "Version " + string(newestVersionNum);
				show_debug_message("global.versionString: " + string(global.versionString) + " , newestVersionNum: " + newVersionString); 
				
					if(newVersionString != global.versionString){
						//reccomend downloading new version
						show_message("GETT THE NEW ONE DUMMY");
					}
				
				}
			}
			
			ds_map_delete(request_ids_, _packet_type);
			ds_map_delete(timeout_timers_, _packet_type);
		}
	}
	else if (_http_status == "401") {
		
		show_debug_message("high score update request denied! HTTP401");
		
		ds_map_delete(request_ids_, _packet_type);
		ds_map_delete(timeout_timers_, _packet_type);
	}
	#endregion
	break;
	
	case REQUEST_TYPE.refresh:
	show_debug_message("REQUEST_TYPE.refresh");
	#region Refresh session
	if (_http_status == "200") {
		if (_result == "null") {
			show_debug_message("Authentication failed, probably reuqest denied due to server rules");
		}
		else {
			show_debug_message("Refresh successful, probably");
			var _result_map = json_decode(_result);
			auth_token_ = _result_map[? "id_token"];
			refresh_token_ = _result_map[? "refresh_token"];
			session_refresh_time_ = date_get_second_of_year(date_current_datetime()) + session_ttl_;
			if (session_refresh_time_ >= 31557600) session_refresh_time_ -= 31557600;
			show_debug_message("Auth-Token: " + auth_token_);
			show_debug_message("Refresh-Token: " + refresh_token_);
			ds_map_destroy(_result_map);
		}
		
		ds_map_delete(request_ids_, _packet_type);
		ds_map_delete(timeout_timers_, _packet_type);
	}
	else if (_http_status == "401") {
		show_debug_message("refresh denied, HTTP401");
		
		ds_map_delete(request_ids_, _packet_type);
		ds_map_delete(timeout_timers_, _packet_type);
	}
	#endregion
	break;
	
	default:
		show_debug_message("ERROR: UNKNOWN PACKET TYPE");
		show_debug_message("ID#: " + string(_packet_type));
		show_debug_message("HTTP Status: " + string(_http_status));
		show_debug_message("Result: " + string(_result));
	break;
}
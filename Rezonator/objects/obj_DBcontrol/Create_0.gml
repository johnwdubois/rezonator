/// @description Insert description here
// You can write your code in this editor

enum REQUEST_TYPE {
	auth,
	submit,
	get,
	update,
	refresh
}

//HTTP setup
request_ids_ = ds_map_create();
timeout_timers_ = ds_map_create();
database_url_ = "https://rezonator-13b47-default-rtdb.firebaseio.com/";
api_key_ = "AIzaSyAKlxe-4nMfRprg6rRkxWQs9IcSPcWQ1T8";
auth_location_ = "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=" + api_key_;
refresh_location_ = "https://securetoken.googleapis.com/v1/token?key=" + api_key_ ;


//ID SETUP
auth_token_ = noone;
refresh_token_ = noone;
uid_ = noone;
session_ttl_ = 3540;
session_refresh_time_ = noone;

//general setup
highscore_array_ = noone;
timeout_limit_ = 5;
retrieval_limit_ = 10;

//
randomize();
score_ = irandom_range(1,1000000);
name_ = "GML USER: " + string(irandom_range(1,1000000));

newestVersionNum = "";
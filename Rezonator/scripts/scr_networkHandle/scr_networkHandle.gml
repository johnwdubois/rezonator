// Credit to Suspendee Studios

if (ds_map_find_value(async_load, "type") == network_type_data)
{
	var tempbuf = ds_map_find_value(async_load,"buffer");
	var tempstr = buffer_read(tempbuf,buffer_text);

	buffer_delete(tempbuf);
	while (string_pos(global.splitter,tempstr))
	{
		var otherstr = string_copy(tempstr,0,string_pos(global.splitter,tempstr)-1);
		otherstr = json_decode(otherstr);
		tempstr = string_delete(tempstr,1,string_pos(global.splitter,tempstr)+string_length(global.splitter)-1);
    
		if (ds_map_exists(global.listener,otherstr[? "identify"]))
		{
			var currentdata = otherstr[? otherstr[? "identify"]];
			script_execute(global.listener[? otherstr[? "identify"]],otherstr[? "identify"],currentdata);
			
			if (typeof(currentdata) == "number") {
				if (ds_exists(currentdata,ds_type_map))
				{
					ds_map_destroy(currentdata);
				}
			}
		}
		ds_map_destroy(otherstr);
	}

}
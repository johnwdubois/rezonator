var buffer = argument[0];
var socket = argument[1]; 
var msgid = buffer_read(buffer,buffer_u8);//read first byte
    switch( msgid ) 
    { 
        case 1://new user
            global.max_players+=1;
            var name=buffer_read(buffer,buffer_string);
            show_debug_message(name)
            DataGrid[#0,global.max_players]=socket;
            DataGrid[#1,global.max_players]=name;
            DataGrid[#2,global.max_players]=global.max_players;
            buffer_seek(Buffer,buffer_seek_start,0);
            buffer_write(Buffer,buffer_u8,1);
            buffer_write(Buffer,buffer_u16,global.max_players);
            network_send_raw(socket,Buffer,buffer_get_size(Buffer));
            break; 
    }

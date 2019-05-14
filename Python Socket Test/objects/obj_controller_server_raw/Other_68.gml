var type_event = ds_map_find_value(async_load,"type");
switch( type_event ) 
{ 
   case network_type_connect:
      var socket = ds_map_find_value(async_load,"socket");
      ds_list_add(SocketList,socket);
      global.players+=1;
   break; 
   case network_type_disconnect: 
      var socket = ds_map_find_value(async_load ,"socket"); 
      var findsocket = ds_list_find_index(SocketList,socket);
      for(i=1;i<=global.max_players;i++)
      {
            if DataGrid[#0,i]=socket
            {
                DataGrid[#0,i]="Disconected"
                DataGrid[#1,i]="Disconected"
                //DataGrid[#0,i]="Disonected"
            }           
      }
      if (findsocket>=0) {
         ds_list_delete(SocketList,findsocket);
         global.players-=1;
      } 
   break; 
   case network_type_data:
      var buffer = ds_map_find_value(async_load,"buffer");
      var socket = ds_map_find_value(async_load,"id");
      buffer_seek(buffer,buffer_seek_start,0);
      ReceivedPacketRaw(buffer,socket);
   break; 
}


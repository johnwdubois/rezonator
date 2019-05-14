port = 6510;
Server = network_create_server_raw (network_socket_tcp, port, 32);
while (!Server && port <65535)
     {
     port++
     Server = network_create_server_raw (network_socket_tcp, port, 32)
     }
Buffer=buffer_create(4096,buffer_fixed,1)
SocketList=ds_list_create()
DataGrid=ds_grid_create(5,100)
global.max_players=0
global.players=0


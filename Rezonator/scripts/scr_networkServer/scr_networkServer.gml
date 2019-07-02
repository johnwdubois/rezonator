global.socket = network_create_socket(network_socket_tcp);
global.server = network_connect_raw(global.socket,argument0,argument1);
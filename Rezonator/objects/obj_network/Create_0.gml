ip = get_string("Type in IP", "");
port = real(get_string("Type in port", ""));

scr_networkInit();
scr_networkServer(ip, port);
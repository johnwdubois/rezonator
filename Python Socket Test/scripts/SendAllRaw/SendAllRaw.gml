var nosocket=argument0;

for(ii=0;ii<ds_list_size(SocketList);ii++)
{ 
    var sockett=SocketList[|ii]; 
    if(sockett != nosocket)
    {
        network_send_raw(sockett,Buffer,buffer_get_size(Buffer));
    }
} 

draw_text(12,12,string_hash_to_newline("Current Online Users: "+string(global.players)))
draw_text(12,24,string_hash_to_newline("Max Online Users: "+string(global.max_players)))

draw_text(18,36,string_hash_to_newline("Users: "))

for(j=1;j<=global.max_players;j++)
{
if DataGrid[#1,j]!="Disconected"
    if draw_tbutton(18,48+j*12,DataGrid[#1,j],c_black,c_white)
    {
        ///do smth doesnt matter
    }
}



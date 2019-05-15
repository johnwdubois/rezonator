import socket
import struct
import pytogmlnetw
         

def send_message_string(mess,data):
    buffer.clear();
    buffer.write_byte(mess)
    buffer.write_bstring(data)
    s.send(buffer)

def send_message_int(mess,data):
    buffer.clear();
    buffer.write_byte(mess)
    buffer.write_int(data)
    s.send(buffer)


TCP_IP = '192.168.0.101'
TCP_PORT = 5001

print("port " + str(TCP_PORT))
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.connect((TCP_IP, TCP_PORT))
buffer = pytogmlnetw.Buffer();

state="logging"
name="";
result=0;


while True:

    buffer.clear();
    if state=="logging":
        name=input("your name?");
        send_message_string(1,name)
        buffer.clear();
    
    
    msg,(addr,port)=s.recvfrom(4096)
    buffer.clear()
    if msg:
        buffer.load(msg);
        msg_code=buffer.read_ubyte();
    if msg_code==1:
        data=buffer.read_int();
        print("My ID: "+str(data))
        state="chatting"
            


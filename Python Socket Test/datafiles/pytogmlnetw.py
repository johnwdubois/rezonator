import struct
import binascii

class Buffer(bytearray):
    index = 0
    length=0;

   
    
    def __init__(self, message=""):
        self[:] = bytearray()#message.encode()

    def get_readpos(self):
        return self.index

    def set_readpos(self, i):
        self.index = i

    def clear(self):
        self.index = 0
        self[:] = bytearray();
        
    def load(self, message=""):
        self[:] = bytearray(message)
        self.index = 0

    def read_ubyte(self):
        ubyte = self[self.index:self.index+1]
        self.index += 1
        return struct.unpack("!B", bytes(ubyte))[0]

    def read_byte(self):
        byte = self[self.index:self.index+1]
        self.index += 1
        return struct.unpack("!b", bytes(byte))[0]

    def read_ushort(self):
        ushort = self[self.index:self.index+2]
        self.index += 2
        return struct.unpack("!H", bytes(ushort))[0]

    def read_short(self):
        short = self[self.index:self.index+2]
        self.index += 2
        return struct.unpack("!h", bytes(short))[0]

    def read_uint(self):        
        uint = self[self.index:self.index+4]
        print(uint)
        self.index += 4
        #return struct.unpack("!I", bytes(uint))[0]
        i=int.from_bytes(uint, byteorder='big', signed=False)
        print(i)
        return i;

    def read_int(self):
        global length;
        length=0;
        integer = self[self.index:self.index+4]
        for i in integer:
                if i!=0:
                    length+=1;
                    #print(i)
        integer = self[self.index:self.index+length]
        #print(self.index)
        if length==1:
            self.index += 1
            #print(self.index)
            return int.from_bytes(integer, byteorder='big', signed=True)#struct.unpack("h", bytes(integer))[0]
        if length==2:
            self.index += 2
            #print(self.index)
            return struct.unpack("h", bytes(integer))[0]
        if length==3:
            self.index += 3
            #print(self.index)
            return struct.unpack("BH", bytes(integer))[0]
        if length==4:
            self.index += 4
            #print(self.index)
            return struct.unpack("I", bytes(integer))[0]
           
            
            
    def read_float(self):
        fl = self[self.index:self.index+4]
        self.index += 4
        return struct.unpack("!f", str(fl))[0]

    def read_double(self):
        db = self[self.index:self.index+8]
        self.index += 8
        return struct.unpack("!d", str(db))[0]

    def read_string(self, length):
        string = self[self.index:self.index+length]
        self.index += length
        return struct.unpack("!"+str(length)+"s", str(string))[0]

    def read_bstring(self):
        length = struct.unpack("!B",str(self[self.index:self.index+1]))[0]
        self.index += 1
        string = self[self.index:self.index+length]
        self.index += length
        return struct.unpack("!"+str(length)+bytearray("s"), str(string))[0]

    def read_sstring(self):
        length = struct.unpack("!H",str(self[self.index:self.index+2]))[0]
        self.index += 2
        string = self[self.index:self.index+length]
        self.index += length
        return struct.unpack("!"+str(length)+"s", str(string))[0]

    def read_istring(self):
        length = struct.unpack("!I",str(self[self.index:self.index+4]))[0]
        self.index += 4
        string = self[self.index:self.index+length]
        self.index += length
        return struct.unpack("!"+str(length)+"s", str(string))[0]

    def write_ubyte(self, ubyte):
        self += struct.pack("=B", ubyte)
        return len(self)

    def write_byte(self, byte):
        self += struct.pack("=b", byte)
        return len(self)

    def write_ushort(self, ushort):
        self += struct.pack("=H", ushort)
        return len(self)

    def write_short(self, short):
        self += struct.pack("=h", short)
        return len(self)

    def write_uint(self, uint):
        self += struct.pack("=I", uint)
        return len(self)

    def write_int(self, integer):
        self += struct.pack("=i", integer)
        return len(self)

    def write_float(self, fl):
        self += struct.pack("=f", fl)
        return len(self)

    def write_double(self, db):
        self += struct.pack("=d", db)
        return len(self)

    def write_string(self, string):
        self += struct.pack("="+str(len(string))+"s", str(string))
        return len(self)

    def write_bstring(self, string):
        string=bytes(string,encoding='utf-8')
        self += struct.pack("="+str(len(string))+"s",string)
        return len(self)

    def write_sstring(self, string):
        self += struct.pack("=H", len(string))
        self += struct.pack("="+str(len(string))+"s", str(string))
        return len(self)

    def write_istring(self, string):
        self += struct.pack("=I", len(string))
        self += struct.pack("="+str(len(string))+"s", str(string))
        return len(self)


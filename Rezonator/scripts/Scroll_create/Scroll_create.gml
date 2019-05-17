/// @function Script_Scroll_create(X,Y,depth,width,height,list,VorH,HolderStep,sep)
/// @description 

/// @param {real} x
/// @param {real} y
/// @param {real} depth
/// @param {real} width
/// @param {real} heigth

/// @param {string} list<Ids>
/// @param {string} "V"or"H" 
/// @param {real} HolderStep
/// @param {real} sep

var X = argument0
var Y = argument1
var Depth = argument2
var width = argument3
var heigth = argument4

var list = argument5
var V_H = argument6
var Holder_step = argument7
var sep = argument8


var ins = instance_create_depth(X,Y,Depth-1,Obj_Scroll)

ins.width = width
ins.heigth = heigth

ins.list = list
ins.V_H = V_H
ins.Holder_step = Holder_step
ins.sep = sep

Scroll_refresh(ins)


return(ins);


/*
	scr_fileLineRipListSearch(firstLine, query, delimitingCharacter, fileLineRipList)
	
	Last Updated: 2018-07-12
	
	Called from: scr_loadUnitGrid
	
	Purpose: Locate string in fileLineRipList
	
	Mechanism: use GML string searching functions to get character position of queried string
*/


var firstLine = argument0;
var query = argument1;
var delimitingChar = argument2;
var fileLineRipList = argument3;

var returnString = "";

//var lineString = ds_list_find_value(global.fileLineRipList, firstLine);
var lineString = ds_list_find_value(fileLineRipList, firstLine);


var startCharAt = string_pos(query, lineString);
var charAt = 0;

if (startCharAt == 0)
{
	return returnString;
}
else
{
	startCharAt += string_length(query);
	charAt = startCharAt;
}


do
{
	if (charAt < string_length(lineString))
	{
		charAt++;
	}
	else
	{
		break;
	}
}
until
	string_char_at(lineString, charAt) == delimitingChar;

var returnStringLength = charAt - startCharAt;

returnString = string_copy(lineString, startCharAt, returnStringLength);

return returnString;

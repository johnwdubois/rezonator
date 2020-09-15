/// @desc csv_to_grid
/// @param file
/// @param [force_strings]
/// @param [cell_delimiter]
/// @param [string_delimiter]
/// @param [mac_newline]
//  
//  CAUTION: Please ensure your files are in UTF-8 encoding.
//  
//  You may pass <undefined> to use the default value for optional arguments.
//  arg0   string   Filename for the source UTF-8 CSV file
//  arg1   bool     Whether to force all cells to be a string. Defaults to false
//  arg2   string   The delimiter used to separate cells. Defaults to a comma
//  arg3   string   The delimiter used to define strings in the CSV file. Defaults to a double-quote
//  arg4   bool     Newline compatibility mode for Mac (0A). Defaults to Windows standard newline (0D,0A)
//  
//  (c) Juju Adams 26th May 2017
//  @jujuadams

//Handle arguments
if ( argument_count < 1 ) or ( argument_count > 5 ) {
	show_error( "Incorrect number of arguments (" + string( argument_count ) + ")", false );
	return undefined;
}

show_debug_message("scr_CSVtoGrid2, STARTING... " + scr_printTime());

var _filename         = argument[0];
var _force_strings    = false;
var _cell_delimiter   = chr(44); //comma
var _string_delimiter = chr(34); //double-quote
var _newline_alt      = false;

if ( argument_count >= 2 ) and ( !is_undefined( argument[1] ) ) _force_strings    = argument[1];
if ( argument_count >= 3 ) and ( !is_undefined( argument[2] ) ) _cell_delimiter   = argument[2];
if ( argument_count >= 4 ) and ( !is_undefined( argument[3] ) ) _string_delimiter = argument[3];
if ( argument_count >= 5 ) and ( !is_undefined( argument[4] ) ) _newline_alt      = argument[4];

//Check for silliness...
if ( string_length( _cell_delimiter ) != 1 ) or ( string_length( _string_delimiter ) != 1 ) {
	show_error( "Delimiters must be one character", false );
	return undefined;
}

//More variables...
var _cell_delimiter_ord  = ord( _cell_delimiter  );
var _string_delimiter_ord = ord( _string_delimiter );

var _sheet_width  = 0;
var _sheet_height = 1;
var _max_width    = 0;

var _prev_val   = 0;
var _val        = 0;
var _str        = "";
var _in_string  = false;
var _is_decimal = !_force_strings;
var _grid       = ds_grid_create( 1, 1 ); _grid[# 0, 0 ] = "";

//Load CSV file as a buffer
var _buffer = buffer_load( _filename );
var _size = buffer_get_size( _buffer );
buffer_seek( _buffer, buffer_seek_start, 0 );

//Handle byte order marks from some UTF-8 encoders (EF BB BF at the start of the file)
var _bom_a = buffer_read( _buffer, buffer_u8 );
var _bom_b = buffer_read( _buffer, buffer_u8 );
var _bom_c = buffer_read( _buffer, buffer_u8 );
if !( ( _bom_a == 239 ) and ( _bom_b == 187 ) and ( _bom_c == 191 ) ) {
	show_debug_message( "CAUTION: csv_to_grid: " + _filename + ": CSV file might not be UTF-8 encoded (no BOM)" );
	buffer_seek( _buffer, buffer_seek_start, 0 );
} else {
	_size -= 3;
}

//Iterate over the buffer
for( var _i = 0; _i < _size; _i++ ) {
	

	_prev_val = _val;
	var _val = buffer_read( _buffer, buffer_u8 );

	//Handle UTF-8 encoding
	if ( ( _val & 224 ) == 192 ) { //two-byte

		_val  = (                              _val & 31 ) <<  6;
		_val += ( buffer_read( _buffer, buffer_u8 ) & 63 );
		_i++;

	} else if ( ( _val & 240 ) == 224 ) { //three-byte

		_val  = (                              _val & 15 ) << 12;
		_val += ( buffer_read( _buffer, buffer_u8 ) & 63 ) <<  6;
		_val +=   buffer_read( _buffer, buffer_u8 ) & 63;
		_i += 2;

	} else if ( ( _val & 248 ) == 240 ) { //four-byte

		_val  = (                              _val &  7 ) << 18;
		_val += ( buffer_read( _buffer, buffer_u8 ) & 63 ) << 12;
		_val += ( buffer_read( _buffer, buffer_u8 ) & 63 ) <<  6;
		_val +=   buffer_read( _buffer, buffer_u8 ) & 63;
		_i += 3;

	}

	//If we've found a string delimiter
	if ( _val == _string_delimiter_ord ) {

		//This definitely isn't a decimal number!
		_is_decimal = false;

		//If we're in a string...
		if ( _in_string ) {

			//If the next character is a string delimiter itself, skip this character
			if ( buffer_peek( _buffer, buffer_tell( _buffer ), buffer_u8 ) == _string_delimiter_ord ) continue;

			//If the previous character is a string delimiter itself, add the string delimiter to the working string
			if ( _prev_val == _string_delimiter_ord ) {
			    _str += _string_delimiter;
			    continue;
			};

		}

		//Toggle "we're in a string" behaviour
		_in_string = !_in_string;
		continue;

	}
    
	if ( _newline_alt ) {
		var _newline = ( _val == 10 );
	} 
	else {
		var _newline = ( _prev_val == 13 ) and ( _val == 10 );
        
		//If we've found a newline and we're in a string, skip over the chr(10) character
		if ( _in_string ) and ( _newline ) continue;
	}

	//If we've found a new cell
	if ( ( _val == _cell_delimiter_ord ) or ( _newline ) ) and ( !_in_string ) {

		_sheet_width++;

		//If this cell is now longer than the maximum width of the grid, expand the grid
		if ( _sheet_width > _max_width ) {

			_max_width = _sheet_width;
			ds_grid_resize( _grid, _max_width, _sheet_height );

			//Clear cells vertically above to overwrite the default 0-value
			if ( _sheet_height >= 2 ) ds_grid_set_region( _grid, _max_width-1, 0, _max_width-1, _sheet_height-2, "" );

		}
		
		//Write the working string to a grid cell
		if ( _is_decimal )
                {
                    if (_str == "") _str = 0; else _str = real( _str );
                }
                
		_grid[# _sheet_width-1, _sheet_height-1 ] = _str;

		_str = "";
		_in_string = false;
		_is_decimal = !_force_strings;

		//A newline outside of a string triggers a new line... unsurprisingly
		if ( _newline ) {
			show_debug_message(string(_sheet_height));
			//Clear cells horizontally to overwrite the default 0-value
			if ( _sheet_width < _max_width ) ds_grid_set_region( _grid, _sheet_width, _sheet_height-1, _max_width-1, _sheet_height-1, "" );

			_sheet_width = 0;
			_sheet_height++;
			ds_grid_resize( _grid, _max_width, _sheet_height );
		}

		continue;

	}

	//Check if we've read a "\n" dual-character
	if ( _prev_val == 92 ) and ( _val == 110 ) {
		_str = string_delete( _str, string_length( _str ), 1 ) + chr(13);
		continue;
	}
    
	//No newlines should appear outside of a string delimited cell
	if ( ( _val == 10 ) or ( _val == 13 ) ) and ( !_in_string ) continue;
    
	//Check if this character is outside valid decimal character range
	if ( _val != 45 ) and ( _val != 46 ) and ( ( _val < 48 ) or ( _val > 57 ) ) _is_decimal = false;

	//Finally add this character to the working string!
	_str += chr( _val );

}

//Catch hanging work string on end-of-file
if ( _str != "" ) {
	
	_sheet_width++;
	
	if ( _sheet_width > _max_width ) {
		_max_width = _sheet_width;
		ds_grid_resize( _grid, _max_width, _sheet_height );
		if ( _sheet_height >= 2 ) ds_grid_set_region( _grid, _max_width-1, 0, _max_width-1, _sheet_height-2, "" );
	}
	
	if ( _is_decimal ) _str = real( _str );
	_grid[# _sheet_width-1, _sheet_height-1 ] = _str;
	
}

//If the last character was a newline then we'll have an erroneous extra row at the bottom
if ( _newline ) ds_grid_resize( _grid, _max_width, _sheet_height-1 );

buffer_delete( _buffer );

show_debug_message("scr_CSVtoGrid2, END... " + scr_printTime());
return _grid;
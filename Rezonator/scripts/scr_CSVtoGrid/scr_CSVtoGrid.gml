///csv_to_grid( file, [cell delimiter], [text delimiter] )
//  
//  Loads a .csv file into a ds_grid that is automatically sized to the data.
//  Useful for translations, dialogue trees, mods etc.
//  
//  January 2016
//  @jujuadams

//Collect the filename. You don't strictly have to do this but it's good practice for larger scripts in case you need to change things around

switch( argument_count ) {
    
    case 1:
        var file = argument[0];
        var cellDelimiter = "";
        var textDelimiter = "";
    break;
    
    case 2:
        var file = argument[0];
        var cellDelimiter = argument[1];
        var textDelimiter = "";
    break;
    
    case 3:
        var file = argument[0];
        var cellDelimiter = argument[1];
        var textDelimiter = argument[2];
    break;
    
    default:
        show_message( "scr_juju_csv_load_to_grid: Error! Unsupported number of arguments" );
        return noone;
    break;
    
}

if ( cellDelimiter == "" ) cellDelimiter = ",";
if ( textDelimiter == "" ) textDelimiter = chr(34);


var cellDelimiterOrd = ord( cellDelimiter );
var textDelimiterOrd = ord( textDelimiter );

//
var buffer = buffer_create( 1, buffer_grow, 1 );
buffer_load_ext( buffer, file, 0 );
buffer_seek( buffer, buffer_seek_start, 0 );

//Initialise width and height of the spreadsheet
var sheetWidth = 0;
var sheetHeight = 1;

var prevVal = 0;
var nextVal = 0;
var val = 0;
var str = "";
var inText = false;
var grid = noone;

var size = buffer_get_size( buffer );
for( var i = 0; i < size; i++ ) {
    
    prevVal = val;
    var val = buffer_read( buffer, buffer_u8 );
    
    if ( val == 13 ) continue;
    
    if ( val == textDelimiterOrd ) {
        
        var nextVal = buffer_peek( buffer, buffer_tell( buffer ), buffer_u8 );
        
        if ( inText ) {
            if ( nextVal == textDelimiterOrd ) continue;
            if ( prevVal == textDelimiterOrd ) {
                str += textDelimiter;
                continue;
            }
        }
        
        inText = !inText;
        continue;
        
    }
    
    if ( inText ) and ( ( prevVal == 13 ) and ( val == 10 ) ) {   
        str += "#";
        continue;
    }
    
    if ( ( val == cellDelimiterOrd ) or ( ( prevVal == 13 ) and ( val == 10 ) ) ) and ( !inText ) {
        
        sheetWidth++;
        if ( grid == noone ) {
            grid = ds_grid_create( max( 1, sheetWidth ), max( 1, sheetHeight ) );
            ds_grid_clear( grid, "" );
        } else ds_grid_resize( grid, max( sheetWidth, ds_grid_width( grid ) ), sheetHeight );
        
        ds_grid_set( grid, sheetWidth - 1, sheetHeight - 1, str );
        str = "";
        inText = false;
        
        if ( val == 10 ) {
            sheetWidth = 0;
            sheetHeight++;
        }
        
        continue;
    }
    
    str += chr( val );
    
}

buffer_delete( buffer );

sheetWidth = ds_grid_width( grid );
sheetHeight = ds_grid_height( grid );
for( var yy = 0; yy < sheetHeight; yy++ ) {
    for( var xx = 0; xx < sheetWidth; xx++ ) {
        var val = ds_grid_get( grid, xx, yy );
        if ( !is_string( val ) ) ds_grid_set( grid, xx, yy, "" );
    }
}

//Return the grid, ready for use elsewhere
return grid;
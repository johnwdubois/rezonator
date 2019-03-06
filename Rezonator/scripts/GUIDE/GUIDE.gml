/*
-----------------------------------------------------------------------------------------------------------------------------------------------------------------

    Thank you for purchasing Text Inputs.
    
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	Before you start:
	
	If you have imported this marketplace asset into a clean project and want to test the examples either move the "Example" folder in the "Rooms"
	resources to the top so it's above all other rooms, or delete the rooms above the folder.

-----------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	If you've imported every resource from the asset, you will now see folders named
    "Text Inputs" and "Example" in your resource tree. The "Text Inputs" folders contain
    resources which are needed for Text Inputs to work. The "Example" folders show what's
    possible with the asset by giving you some examples of how to use the scripts in the
    "Text Inputs" scripts folder. The "Example" folders can be deleted if you only want
    the essential components for the text inputs.
    
    When creating a text input, you can use either input_text_create_singleline,
    input_text_create_singleline_ext, input_text_create_multiline, input_text_create_multiline_ext,
    or input_text_create. input_text_create_singleline offers a simple way to create a singleline
    text input. And input_text_create_multiline offers a simple way to create a multiline text input.
    Adding _ext at the end adds more parameters letting you customize the text inputs a bit further.
    You don't really have to worry about the last input_text_create script. These scripts return 
    the instance id of the text input, much like calling the instance_create function would for other
    objects. Then you can use the other input_text_* scripts together with this id to customize and get
    information from the text input.
    
    To allow a user to type text into text inputs, the text input has to be enabled. A text input is enabled
    by calling the script input_text_set_enabled. This script has two parameters. The first one is the id
    of the text input instance that was returned when you created the text input. The second one is whether
    the text input should be enabled (true) or disabled (false). Enabling a text input will automatically
    disable all other text inputs which are currently enabled.
    
    To get the text that a text input currently contains you can use the input_text_get_text script. This
    will return a string containing the text of the text input specified.
    
    input_text_get_text_width and input_text_get_text_height will return the width and height of the area
    that the text covers on screen. The width and height are in pixels.
    
    To change the text that a text input currently contains you can use the input_text_set_text script.
    
    input_text_set_transformation can be used to change the position, scale, and angle of the text input.
    
    input_text_set_offset can be used to offset the text within the text input. A text input has a
    rectangular area that its drawing is restricted to. This script allows you to offset where the text
    is drawn within that area.

    Lastly, input_text_set_misc offers some additional options letting you customize your text input
    even further.
    
    If you've got any questions, you can send a mail to asbjorn.lystrup@gmail.com, or a message to Dragon47
    in the GameMaker Community (https://forum.yoyogames.com/index.php).
  
-----------------------------------------------------------------------------------------------------------------------------------------------------------------  
*/

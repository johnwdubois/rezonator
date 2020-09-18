/// @function __GMA_BREAKPOINT__
/// @param message The error message about to be displayed
/// @param got The value received by the failing assertion
/// @param expected The value expected by the failing assertion
/// @description A script that runs just before the error popup in a failed assertion. Return true to bypass the error popup, false to allow it.
function __GMA_BREAKPOINT__() {
	{
	  var message = argument[0],
	      got = argument[1],
	      expected = argument[2];
  
	  // Place a breakpoint below
	  var __GMA_MY_BREAKPOINT__ = true;
  
	  /* Additional assertion failure handling behaviours here */
  
	  // Return true to bypass error popup, false otherwise
	  return false;
	}



}

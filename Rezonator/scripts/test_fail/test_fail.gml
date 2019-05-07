/// @param Message
/*
 * Fails a test, printing the message and test info. This is used
 * internally by asserts, but can also be used to manually fail
 * tests if need be.
 */
 var msg = argument0; 
gamatas_info(msg);
gamatas_info("In suite " + global.gamatas_testSuiteName);
gamatas_info(global.gamatas_testSuiteName + " " + global.gamatas_testDescription);

show_error(msg + " in " + global.gamatas_testSuiteName + " " + global.gamatas_testDescription, true);

global.gamatas_testPassed = false;

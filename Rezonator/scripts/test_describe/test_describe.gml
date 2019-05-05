/// @desc Begins a test suite
/// @param {String} systemName
/*
 * example:
 * test_describe("obj_player");
 */

global.gamatas_testPassed = true;
global.gamatas_testCount = 0;
global.gamatas_testSuiteName = argument0;
global.gamatas_testNumber = 0;
global.gamatas_testAssertNumber = 0;
gamatas_info("DESCRIBE: " + argument0);
test_next();

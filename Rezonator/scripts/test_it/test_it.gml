/// @desc Define what the current tested behavior should be
/// @param {String} behaviorDescription
/*
 * Example:
 * test_it("dies when health is 0");
 */
if (global.gamatas_testPassed) {
    global.gamatas_testDescription = argument0;
    global.gamatas_testCount++;
} else {
    game_end();
}

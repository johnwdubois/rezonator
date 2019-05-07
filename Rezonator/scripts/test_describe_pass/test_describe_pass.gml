/// @param {Object} optionalNextTestObject An object to create to begin the next test, or blank to move to the next room
/* 
 * Finishes the test suite and moves on if there are more tests/rooms,
 * otherwise, quits. This should be called by itself in the last user
 * defined action on your test controller object.
 */

var nextTest = -1;

if (argument_count > 0) {
    nextTest = argument[0];
}

gamatas_info("TEST SUITE PASSED: " + global.gamatas_testSuiteName);

if (nextTest != -1) {
    instance_create(0, 0, nextTest);
    instance_destroy();
} else if (room != room_last) {
    room_goto_next();
} else {
    gamatas_info("ALL TESTS PASSING");
    game_end();
}

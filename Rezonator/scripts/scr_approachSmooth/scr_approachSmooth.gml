function scr_approachSmooth(argument0, argument1, argument2) {
	/*
		Have the value approach the destination in incremental steps
	*/

	var value = argument0;
	var valueDest = argument1;
	var divisor = argument2;

	if (value < valueDest) {
		value += abs(value - valueDest) / divisor;
	}
	else if (value > valueDest) {
		value -= abs(value - valueDest) / divisor;
	}

	return value;


}

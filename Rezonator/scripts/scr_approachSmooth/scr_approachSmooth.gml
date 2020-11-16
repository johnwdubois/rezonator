function scr_approachSmooth(value, valueDest, divisor) {
	/*
		Have the value approach the destination in incremental steps
	*/

	if (value < valueDest) {
		value += abs(value - valueDest) / divisor;
	}
	else if (value > valueDest) {
		value -= abs(value - valueDest) / divisor;
	}

	return value;


}

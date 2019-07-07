/// @Rez Tracker Timer
// You can write your code in this editor

if (timerSecs < 59) {
	timerSecs ++;
}

else {
	timerMins ++;
	timerSecs = 0;
}

alarm[5] = 60;
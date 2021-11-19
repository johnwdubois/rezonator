/// @description Blink Cursor
if (!windowFocused) exit;
drawCursor = !drawCursor;
alarm[0] = blinkRate;
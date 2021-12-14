
timeout = UNIT_timeoutCreateAsync();

UNIT_timeoutAppend(timeout, 1000, function() {
	show_message("hello world");
});

UNIT_timeoutAppend(timeout, 5000, function() {
	show_message("hello world 2");
});

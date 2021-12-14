
timeout = UNIT_timeoutCreateAsync();

UNIT_timeoutAppend(timeout, 1000, method_get_index(function() {
	show_message(timeout);
}));

UNIT_timeoutAppend(timeout, 5000, function() {
	show_message("hello world 2");
});


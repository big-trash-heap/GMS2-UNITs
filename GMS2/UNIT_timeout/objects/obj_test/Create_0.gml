
timeout = UNIT_timeoutCreateSync();
name = "hello";

show_message(timeout)

UNIT_timeoutAppend(timeout, 120, method_get_index(function(_timeout, _1, _id) {
	
	UNIT_timeoutAppend(_timeout, 60, function() {
		show_message("hello world");
		
		
	});
}), id);


timeout = UNIT_timeoutCreateAsync();
name = "hello";

show_message(timeout)

UNIT_timeoutAppend(timeout, 1500, method_get_index(function(_0, _1, _id) {
	show_message(other);
	show_message(self);
}), id);

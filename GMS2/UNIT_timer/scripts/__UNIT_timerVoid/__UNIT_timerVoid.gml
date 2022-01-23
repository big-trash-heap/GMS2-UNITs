
function __UNIT_timerVoid() {};

function __UNIT_timerOverride_set_finit(_f) {
	self.__set_f("__finit", _f);
}

function __UNIT_timerOverride_set_ftick(_f) {
	self.__set_f("__ftick", _f);
}

function __UNIT_timerOverride_get_finit() {
	return self.__finit;
}

function __UNIT_timerOverride_get_ftick() {
	return self.__ftick;
}

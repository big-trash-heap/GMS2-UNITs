
function __UNIT_tmVoid() {};

function __UNIT_tmOverride_set_finit(_f) {
	self.__set_f("__finit", _f);
}

function __UNIT_tmOverride_set_ftick(_f) {
	self.__set_f("__ftick", _f);
}

function __UNIT_tmOverride_get_finit() {
	return self.__finit;
}

function __UNIT_tmOverride_get_ftick() {
	return self.__ftick;
}

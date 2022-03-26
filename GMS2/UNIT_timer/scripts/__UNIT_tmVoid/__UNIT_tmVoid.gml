
function __UNIT_tmVoid() {};

function __UNIT_tmSetF(_name, _f) {
	if (is_undefined(_f) || _f == __UNIT_tmVoid) {
		
		variable_struct_remove(self, _name);
		return;
	}
	
	self[$ _name] = _f;
}

function __UNIT_tmOverride_set_finit(_f) {
	__UNIT_tmSetF("__finit", _f);
}

function __UNIT_tmOverride_set_ftick(_f) {
	__UNIT_tmSetF("__ftick", _f);
}

function __UNIT_tmOverride_get_finit() {
	return self.__finit;
}

function __UNIT_tmOverride_get_ftick() {
	return self.__ftick;
}

#macro ____UNIT_TM_SKIP_VOID_TICK \
if (UNIT_PREPROCESSOR_TM_ENABLE_LOG) { \
show_debug_message("UNIT::tm::skip -> " + string(_timer)); \
}

#macro ____UNIT_TM_SKIP_VOID_TICK_LOOP \
if (UNIT_PREPROCESSOR_TM_ENABLE_SKIP_VOID_TICK) { \
if (_timer._get_ftick() == __UNIT_tmVoid) { \
	____UNIT_TM_SKIP_VOID_TICK; \
	return false; \
} \
}

#macro ____UNIT_TM_SKIP_VOID_TICK_TIMELAPSE \
if (UNIT_PREPROCESSOR_TM_ENABLE_SKIP_VOID_TICK) { \
if (_timer._get_ftick() == __UNIT_tmVoid) { \
	____UNIT_TM_SKIP_VOID_TICK; \
	return (_timer.__step == 0); \
} \
}

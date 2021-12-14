
#macro UNIT_TIMEOUT_ERROR	true


function UNIT_timeoutCreateSync() {
	return new __UNIT_Timeout();
}

function UNIT_timeoutCreateAsync() {
	var _timeout = new __UNIT_Timeout();
	_timeout.__tick = __UNIT_timeoutAsync;
	_timeout.__time = current_time;
	return _timeout;
}

/// @function		UNIT_timeoutAppend(timeout, time, f, [data]);
function UNIT_timeoutAppend(_timeout, _time, _f, _data) {
	if (UNIT_TIMEOUT_ERROR) {
	
	if (!UNIT_timeoutExists(_timeout)) show_error(____UNIT_timeout__error, true);
	
	}
	
	ds_priority_add(_timeout.__ds, [_f, _data], _timeout.__time + _time);
}

/// @param			timeout
function UNIT_timeoutClear(_timeout) {
	if (UNIT_TIMEOUT_ERROR) {
	
	if (!UNIT_timeoutExists(_timeout)) show_error(____UNIT_timeout__error, true);
	
	}
	
	_timeout.__time = 0;
	ds_priority_clear(_timeout.__ds);
}

/// @param			timeout
function UNIT_timeoutExecute(_timeout) {
	if (UNIT_TIMEOUT_ERROR) {
	
	if (!UNIT_timeoutExists(_timeout)) show_error(____UNIT_timeout__error, true);
	
	}
	
	_timeout.__time = 0;
	
	var _ds = _timeout.__ds;
	var _min;
	while (not ds_priority_empty(_ds)) {
		
		_min = ds_priority_delete_min(_ds);
		_min[__UNIT_timeout__val.F](_min[__UNIT_timeout__val.DATA]);
	}
}

// @param			timeout
function UNIT_timeoutFree(_timeout) {
	if (UNIT_TIMEOUT_ERROR) {
	
	if (!UNIT_timeoutExists(_timeout)) show_error(____UNIT_timeout__error, true);
	
	}
	
	ds_priority_destroy(_timeout.__ds);
	_timeout.__ds = -1;
}

/// @param			timeout
function UNIT_timeoutTick(_timeout) {
	if (UNIT_TIMEOUT_ERROR) {
	
	if (!UNIT_timeoutExists(_timeout)) show_error(____UNIT_timeout__error, true);
	
	}
	
	_timeout.__tick();
}

/// @param			timeout
function UNIT_timeoutExists(_timeout) {
	return (instanceof(_timeout) == "__UNIT_Timeout" && _timeout.__ds >= 0);
}


#region __private

#macro ____UNIT_timeout__error "UNIT::timeout -> передан не существующий экземпляр"

enum __UNIT_timeout__val { F, DATA };

function UNIT_timeout() {};

function __UNIT_Timeout() constructor {
	
	self.__ds = ds_priority_create();
	self.__time = 0;
	
	static __tick = __UNIT_timeoutSync;
	
	static toString = function() {
		return ("UNIT::timeout" + (self.__tick == __UNIT_timeoutSync ? "Sync" : "Async"));
	}
	
}

function __UNIT_timeoutSync() {
	
	var _ds = self.__ds;
	var _min;
	while (not ds_priority_empty(_ds)) {
		
		_min = ds_priority_find_min(_ds);
		if (ds_priority_find_priority(_ds, _min) < self.__time) {
			
			_min[__UNIT_timeout__val.F](_min[__UNIT_timeout__val.DATA]);
			ds_priority_delete_value(_ds, _min);
		}
		else {
			_ds = -1;
			break;
		}
	}
	
	if (_ds == -1)
		self.__time += 1;
	else
		self.__time = 0;
}

function __UNIT_timeoutAsync() {
	
	self.__time = current_time;
	
	var _ds = self.__ds;
	var _min;
	while (not ds_priority_empty(_ds)) {
		
		_min = ds_priority_find_min(_ds);
		if (ds_priority_find_priority(_ds, _min) < self.__time) {
			
			_min[__UNIT_timeout__val.F](_min[__UNIT_timeout__val.DATA]);
			ds_priority_delete_value(_ds, _min);
		}
		else {
			break;
		}
	}
}

#endregion


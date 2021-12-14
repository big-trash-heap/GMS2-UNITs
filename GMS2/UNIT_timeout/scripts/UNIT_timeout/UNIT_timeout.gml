
#macro UNIT_TIMEOUT_ERROR	true


function UNIT_timeoutCreateSync() {
	return new __UNIT_Timeout(__UNIT_TimeoutSync);
}

function UNIT_timeoutCreateAsync() {
	return new __UNIT_Timeout(__UNIT_TimeoutAsync);
}

//					f = f(timeout, f, data)
/// @function		UNIT_timeoutAppend(timeout, time, f, [data]);
function UNIT_timeoutAppend(_timeout, _time, _f, _data) {
	if (UNIT_TIMEOUT_ERROR) {
	
	if (!UNIT_timeoutExists(_timeout)) show_error(____UNIT_timeout__error, true);
	
	}
	
	with (_timeout.__value) {
	
	ds_priority_add(self.ds, [_f, _data], self.time + _time);
	
	}
	
}

//					f = f(timeout, f, data)
/// @function		UNIT_timeoutAppendLoop(timeout, time, f, [data]);
function UNIT_timeoutAppendLoop(_timeout, _time, _f, _data) {
	var _super = [_time, _f, _data];
	static _append = method_get_index(function(_timeout, _f, _data) {
		_data[1](_timeout, _data[1], _data[2]);
		UNIT_timeoutAppend(_timeout, _data[0], _f, _data);
	});
	UNIT_timeoutAppend(_timeout, _time, _append, _super);
}

/// @param			timeout
function UNIT_timeoutClear(_timeout) {
	if (UNIT_TIMEOUT_ERROR) {
	
	if (!UNIT_timeoutExists(_timeout)) show_error(____UNIT_timeout__error, true);
	
	}
	
	with (_timeout.__value) {
	
	self.clear();
	ds_priority_clear(self.ds);
	
	}
}

/// @param			timeout
function UNIT_timeoutExecute(_timeout) {
	if (UNIT_TIMEOUT_ERROR) {
	
	if (!UNIT_timeoutExists(_timeout)) show_error(____UNIT_timeout__error, true);
	
	}
	
	var _ds, _min;
	with (_timeout.__value) {
	
	_ds = self.ds;
	self.clear();
	
	}
	
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
	
	with (_timeout.__value) {
		
	ds_priority_destroy(self.ds);
	self.ds = -1;
	
	}
}

/// @param			timeout
function UNIT_timeoutTick(_timeout) {
	if (UNIT_TIMEOUT_ERROR) {
	
	if (!UNIT_timeoutExists(_timeout)) show_error(____UNIT_timeout__error, true);
	
	}
	
	_timeout.__value.tick(_timeout, self);
}

/// @param			timeout
function UNIT_timeoutExists(_timeout) {
	return (instanceof(_timeout) == "__UNIT_Timeout" && _timeout.__value.ds >= 0);
}


#region __private

#macro ____UNIT_timeout__error "UNIT::timeout -> передан не существующий экземпляр"

enum __UNIT_timeout__val { F, DATA };

function UNIT_timeout() {};

function __UNIT_Timeout(_constructor) constructor {
	
	self.__value = new _constructor();
	
	static toString = function() {
		return self.__value.toString();	
	}
	
}

function __UNIT_TimeoutSync() constructor {
	
	self.ds = ds_priority_create();
	self.time = 0;
	
	static tick = function(_timeout, _context) {
		
		var _ds   = self.ds;
		var _time = self.time;
		
		with (_context) {
		
		var _min, _f;
		while (not ds_priority_empty(_ds)) {
			
			_min = ds_priority_find_min(_ds);
			if (ds_priority_find_priority(_ds, _min) < _time) {
				
				_f = _min[__UNIT_timeout__val.F];
				_f(_timeout, _f, _min[__UNIT_timeout__val.DATA]);
				ds_priority_delete_value(_ds, _min);
			}
			else {
				_ds = -1;
				break;
			}
		}
		
		}
		
		if (_ds == -1)
			self.time += 1;
		else
			self.time = 0;
	}
	
	static clear = function() {
		self.time = 0;
	}
	
	static toString = function() {
		
		return "UNIT::timeoutSync";
	}
	
}

function __UNIT_TimeoutAsync() constructor {
	
	self.ds = ds_priority_create();
	self.time = current_time;
	
	static tick = function(_timeout, _context) {
		self.time = current_time;
		var _ds   = self.ds;
		var _time = self.time;
		
		with (_context) {
		
		var _min, _f;
		while (not ds_priority_empty(_ds)) {
		
			_min = ds_priority_find_min(_ds);
			if (ds_priority_find_priority(_ds, _min) < _time) {
			
				_f = _min[__UNIT_timeout__val.F];
				_f(_timeout, _f, _min[__UNIT_timeout__val.DATA]);
				ds_priority_delete_value(_ds, _min);
			}
			else {
				break;
			}
		}
		
		}
	}
	
	static clear = function() {
		self.time = current_time;	
	}
	
	static toString = function() {
		
		return "UNIT::timeoutAsync";
	}
	
}

#endregion


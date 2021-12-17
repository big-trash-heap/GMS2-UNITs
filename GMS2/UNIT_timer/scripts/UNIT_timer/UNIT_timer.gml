
function UNIT_Timer() constructor {
	
	#region __private
	
	static __init = UNIT_timer /* handler, timer, arg   */;
	static __tick = UNIT_timer /* handler, timer, super */;
	static __kill = UNIT_timer /* handler, timer        */;
	 
	#endregion
	
	static remove = function() {
		
		return UNIT_timerRemove(self);
	}
	
	static isBind = function() {
		
		return UNIT_timerIsBind(self);
	}
	
	static getHandler = function() {
		
		return UNIT_timerGetHandler(self);
	}
	
	static toString = function() {
		return ("UNIT::Timer::" + instanceof(self));
	}
	
	
	static set = function(_key, _value) {
		self[$ _key] = _value;
		return self;
	}
	
	static impl = function(_struct, _replace=true) {
		
		var _keys = variable_struct_get_names(_struct);
	    var _size = array_length(_keys), _key;
	    while (_size > 0) {
        
	        _key = _keys[--_size];
	        if (!_replace and variable_struct_exists(self, _key)) continue;
	        self[$ _key] = _struct[$ _key];
	    }
		
		return self;
	}
	
}


function UNIT_timerRemove(_timer) {
	static _map = __UNIT_timerHandler();
	var _cell = _map[? _timer];
	if (_cell == undefined) return false;
	
	ds_map_delete(_map, _cell);
	
	var _handler = _cell[UNIT_TIMER_CELL.HANDLER];
	_cell[@ UNIT_TIMER_CELL.HANDLER] = undefined;
	
	with (_handler) {
	
	--self.__count;
	_timer.__kill(self, _timer);
	
	}
	
	return true;
}

function UNIT_timerIsBind(_timer) {
	static _map = __UNIT_timerHandler();
	return ds_map_exists(_map, _timer);
}

function UNIT_timerGetHandler(_timer) {
	static _map = __UNIT_timerHandler();
	var _cell = _map[? _timer];
	if (_cell != undefined) return _cell[UNIT_TIMER_CELL.HANDLER];
}


#region __private

function UNIT_timer() {};

#endregion


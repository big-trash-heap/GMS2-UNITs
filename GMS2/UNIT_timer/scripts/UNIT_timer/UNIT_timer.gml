

// Абстрактный класс
function UNIT_Timer() constructor {
	
	#region __private
	
	static __init = UNIT_timer /* handler, timer, arg   */;
	static __tick = UNIT_timer /* handler, timer, super */;
	static __free = UNIT_timer /* handler, timer        */;
	 
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
	
	
	static _set = function(_key, _value) {
		self[$ _key] = _value;
		return self;
	}
	
	static _ext = function(_struct, _replace=true) {
		
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

/// @param			timer
/// @description	Отвяжет таймер от обработчика 
//					и вернёт true, если таймер был отвязан
function UNIT_timerRemove(_timer) {
	static _map = __UNIT_timerHandler();
	var _cell = _map[? _timer];
	if (_cell == undefined) return false;
	
	ds_map_delete(_map, _timer);
	
	var _handler = _cell[__UNIT_TIMER_CELL._HANDLER];
	_cell[@ __UNIT_TIMER_CELL._HANDLER] = undefined;
	
	with (_handler) {
	
	--self.__count;
	_timer.__free(self, _timer);
	
	}
	
	return true;
}

/// @param			timer
/// @description	Вернёт привязан ли таймер к чему-то
function UNIT_timerIsBind(_timer) {
	static _map = __UNIT_timerHandler();
	return ds_map_exists(_map, _timer);
}

/// @param			timer
/// @description	Вернёт обработчик, к которому привязан таймер
//					Если не привязан вернёт undefined
function UNIT_timerGetHandler(_timer) {
	static _map = __UNIT_timerHandler();
	var _cell = _map[? _timer];
	if (_cell != undefined) return _cell[__UNIT_TIMER_CELL._HANDLER];
}


#region __private

function UNIT_timer() {};

#endregion


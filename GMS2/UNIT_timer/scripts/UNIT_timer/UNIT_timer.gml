
#macro UNIT_PREPROCESSOR_TIMER_TIMER_ENABLE_MARK	false

// Абстрактный класс
function UNIT_Timer() constructor {
	
	#region __private
	
	if (UNIT_PREPROCESSOR_TIMER_TIMER_ENABLE_MARK) {
	
	self.__mark = weak_ref_create(self);
	
	}
	
	static __init = __UNIT_timerVoid /* handler, timer        */;
	static __tick = __UNIT_timerVoid /* handler, timer, super */;
	static __free = __UNIT_timerVoid /* handler, timer        */;
	
	static __copyn_ = function(_struct) {
		if (UNIT_PREPROCESSOR_TIMER_ENABLE_CLONE) {
		
		var _keys = variable_struct_get_names(_struct);
		var _size = array_length(_keys), _key;
		while (_size > 0) {
			
			_key = _keys[--_size];
			if (string_char_at(_key, 1) != "_")
				self[$ _key] = _struct[$ _key];
		}
		
		if (UNIT_PREPROCESSOR_TIMER_ENABLE_LOG) {
		
		if (instanceof(self) == instanceof(_struct) && (
			self._get_ftick() != _struct._get_ftick() ||
			self._get_finit() != _struct._get_finit() ||
			self._get_ffree() != _struct._get_ffree())) {
			
			show_debug_message("UNIT::timer -> вероятно не верная реализация метода _clone в классе " + instanceof(self)
			+ "\n\t; экземпляр, который был клонирован: " + string(_struct)
			+ "\n\t; клон: " + string(self)
			+ "\n\t; callstack: " 
			);
			
			var _callstack = debug_get_callstack();
			var _size = array_length(_callstack);
			for (var _i = 0; _i < _size; ++_i) {
				
				show_debug_message("\n\t;" + string(_callstack[_i]));
			}
			
		}
		
		}
		
		return self;
		
		}
		else {
		
		show_error(____UNIT_TIMER_ERROR_CLONE, true);
		
		}
	}
	
	#endregion
	
	static unbind = function() {
		
		return UNIT_timerUnbind(self);
	}
	
	static isBind = function() {
		
		return UNIT_timerIsBind(self);
	}
	
	static getBind = function() {
		
		return UNIT_timerGetBind(self);
	}
	
	static toString = function() {
		return ("UNIT::timer::" + instanceof(self));
	}
	
	
	static _unbind = function() {
		UNIT_timerUnbind(self);
		return self;
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
	
	
	static _get_finit = function() {
		return self.__init;
	}
	
	static _get_ftick = function() {
		return self.__tick;
	}
	
	static _get_ffree = function() {
		return self.__free;
	}
	
	
	static _clone = function() {
		if (UNIT_PREPROCESSOR_TIMER_ENABLE_CLONE) {
		
		show_error("UNIT::timer -> для класса " + instanceof(self) + " не определён метод _clone", true);
		
		}
		else {
		
		show_error(____UNIT_TIMER_ERROR_CLONE, true);
		
		}
	}
	
	
	static _mark = function() {
		if (UNIT_PREPROCESSOR_TIMER_TIMER_ENABLE_MARK) {
		
		var _cell = __UNIT_timersHandlerMap()[? self];
		if (_cell != undefined) {
			
			if (array_length(_cell) == 2) {
				
				_cell[@ 2] = weak_ref_create(self);
			}
			
			return _cell[2];
		}
		return self.__mark;
		
		}
		else {
		
		show_error("UNIT::timer -> UNIT_PREPROCESSOR_TIMER_TIMER_ENABLE_MARK отключена", true);
		
		}
	}
	
}

/// @param			timer
/// @description	Отвяжет таймер от обработчика 
//					и вернёт true, если таймер был отвязан
function UNIT_timerUnbind(_timer) {
	static _map = __UNIT_timersHandlerMap();
	var _cell = _map[? _timer];
	if (_cell == undefined) return false;
	
	ds_map_delete(_map, _timer);
	
	if (UNIT_PREPROCESSOR_TIMER_TIMER_ENABLE_MARK) {
	
	_timer.__mark = weak_ref_create(_timer);
	
	}
	
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
	static _map = __UNIT_timersHandlerMap();
	return ds_map_exists(_map, _timer);
}

/// @param			timer
/// @description	Вернёт обработчик, к которому привязан таймер
//					Если не привязан вернёт undefined
function UNIT_timerGetBind(_timer) {
	static _map = __UNIT_timersHandlerMap();
	var _cell = _map[? _timer];
	if (_cell != undefined) return _cell[__UNIT_TIMER_CELL._HANDLER];
}


#region __private

function __UNIT_timerVoid() {};

#endregion



/*
	Предполагается, что вы не будете использовать:
	1. UNIT_PREPROCESSOR_TIMER_ENABLE_CLONE
	2. UNIT_PREPROCESSOR_TIMER_TIMERS_HANDLER_EXTEND_TICK
	3. UNIT_PREPROCESSOR_TIMER_TIMER_ENABLE_MARK
*/

#macro UNIT_PREPROCESSOR_TIMER_ENABLE_LOG								true
#macro UNIT_PREPROCESSOR_TIMER_ENABLE_DEBUG								true

#macro UNIT_PREPROCESSOR_TIMER_ENABLE_CLONE								true

#macro UNIT_PREPROCESSOR_TIMER_TIMERS_HANDLER_ENABLE_CHECK_ERROR_TICK	true
#macro UNIT_PREPROCESSOR_TIMER_TIMERS_HANDLER_EXTEND_TICK				false

function UNIT_TimersHandler() constructor {
	
	#region __private
	
	static _map = __UNIT_timersHandlerMap();
	
	self.__timers = [];
	self.__count  = 0;
	self.__clear  = -1;
	
	if (UNIT_PREPROCESSOR_TIMER_TIMERS_HANDLER_EXTEND_TICK) {
	
	self.__temp = undefined;
	
	}
	
	if (UNIT_PREPROCESSOR_TIMER_ENABLE_DEBUG) {
	
	self.__debug_time = 0;
	
	}
	
	
	static __clone = function(_constructor) {
		if (UNIT_PREPROCESSOR_TIMER_ENABLE_CLONE) {
		
		var _handler = new _constructor();
		var _value;
		
		for (var _i = 0, _j = -1; _i < self.__count; ++_i) {
			
			do {
				_value = self.__timers[++_j];
			} until (_value[__UNIT_TIMER_CELL._HANDLER] == self);
			
			_handler.bind(_value[__UNIT_TIMER_CELL._TIMER]._clone());
		}
		
		return _handler;
		
		}
		else {
		
		show_error(____UNIT_TIMER_ERROR_CLONE, true);
		
		}
	}
	
	#endregion
	
	static bind = function(_timer) {
		
		if (UNIT_timerGetBind(_timer) == self) {
			
			show_error("UNIT::timer -> таймер уже занят обработчиком", true);
		}
		
		if (UNIT_PREPROCESSOR_TIMER_ENABLE_DEBUG) {
		
		self.__debug_time = 0;
		_timer.__debug_time = 0;
		
		}
		
		var _cell = [self, _timer];
		self._map[? _timer] = _cell;
		
		++self.__count;
		array_push(self.__timers, _cell);
		
		_timer.__init(self, _timer);
		return _timer;
	}
	
	static tick = function(_super) {
		
		if (UNIT_PREPROCESSOR_TIMER_ENABLE_DEBUG) {
		
		self.__debug_time = 0;
		
		}
		
		var _size = array_length(self.__timers);
		if (_size > 0) {
			
			if (UNIT_PREPROCESSOR_TIMER_TIMERS_HANDLER_ENABLE_CHECK_ERROR_TICK) {
			
			if (self.__clear != -1) show_error("UNIT::timer -> нельзя вызывать tick во время вызова tick, clear, clearAll", true);
			self.__clear = -2;
			
			}
			
			var _i = 0, _j = 0, _value, _timer;
			do {
				
				_value = self.__timers[_i];
				if (_value[__UNIT_TIMER_CELL._HANDLER] == self) {
					
					if (UNIT_PREPROCESSOR_TIMER_TIMERS_HANDLER_EXTEND_TICK) {
					
					self.__temp = _value;
					
					}
					
					_timer = _value[__UNIT_TIMER_CELL._TIMER];
					
					if (UNIT_PREPROCESSOR_TIMER_ENABLE_DEBUG) {
					
					_timer.__debug_time = 0;
					
					}
					
					if (not _timer.__tick(self, _timer, _super)) {
						self.__timers[_j] = _value;
						++_j;
					}
					else
					//if (_value[__UNIT_TIMER_CELL._HANDLER] == self) // entry-space
					if (UNIT_timerGetBind(_timer) == self) // handler-space
						UNIT_timerUnbind(_timer);
				}
			} until (++_i == _size);
			
			_size = array_length(self.__timers);
			while (_i != _size) {
				
				_value = self.__timers[_i];
				++_i;
				
				if (_value[__UNIT_TIMER_CELL._HANDLER] == self) {
					self.__timers[_j] = _value;
					++_j;
				}
			}
			
			if (UNIT_PREPROCESSOR_TIMER_TIMERS_HANDLER_EXTEND_TICK) {
			
			delete self.__temp;
			
			}
			
			array_resize(self.__timers, _j);
			
			if (UNIT_PREPROCESSOR_TIMER_TIMERS_HANDLER_ENABLE_CHECK_ERROR_TICK) {
			
			self.__clear = -1;
			
			}
		}
	}
	
	// удалит текущие таймеры в очереди
	static clear = function() {
		
		var _size = array_length(self.__timers);
		if (_size > 0) {
			
			self.__clear = max(0, self.__clear);
			
			var _value;
			while (self.__clear < _size) {
				
				_value = self.__timers[self.__clear];
				++self.__clear;
				
				if (_value[__UNIT_TIMER_CELL._HANDLER] == self && 
					UNIT_timerUnbind(_value[__UNIT_TIMER_CELL._TIMER]) &&
					self.__clear == -1)
					return;
			}
			
			self.__clear = -1;
		}
	}
	
	// очень опасный метод
	static clearAll = function() {
		
		if (UNIT_PREPROCESSOR_TIMER_ENABLE_LOG) {
		
		show_debug_message("UNIT::timer -> вы вызвали TimersHandler.clearAll это может быть опасно. Избегайте его вызова");
		
		}
		
		if (array_length(self.__timers) > 0) {
			
			self.__clear = max(0, self.__clear);
			
			var _value;
			while (self.__clear < array_length(self.__timers)) {
				
				_value = self.__timers[self.__clear];
				++self.__clear;
				
				if (_value[__UNIT_TIMER_CELL._HANDLER] == self && 
					UNIT_timerUnbind(_value[__UNIT_TIMER_CELL._TIMER]) &&
					self.__clear == -1)
					return;
			}
			
			self.__clear = -1;
		}
	}
	
	static getCount = function() {
		return self.__count;	
	}
	
	static isEmpty = function() {
		return (self.__count == 0);	
	}
	
	static isBind = function(_timer) {
		
		return (self == UNIT_timerGetBind(_timer));
	}
	
	static toString = function() {
		return ("UNIT::timer::" + instanceof(self) + "; number of timers: " + string(self.__count));
	}
	
	
	static _clone = function() {
		if (UNIT_PREPROCESSOR_TIMER_ENABLE_CLONE) {
		
		if (UNIT_PREPROCESSOR_TIMER_ENABLE_LOG) {
		
		show_debug_message("UNIT::timer -> осторожно, класс " + instanceof(self) + " использует базовую версию метода _clone");
		
		}
		
		return self.__clone(asset_get_index(instanceof(self)));
		
		}
		else {
		
		show_error(____UNIT_TIMER_ERROR_CLONE, true);
		
		}
	}
	
	static _toArray = function() {
		
		var _array = array_create(self.__count);
		var _value;
		
		for (var _i = 0, _j = -1; _i < self.__count; ++_i) {
			
			do {
				_value = self.__timers[++_j];
			} until (_value[__UNIT_TIMER_CELL._HANDLER] == self);
			
			_array[_i] = _value[__UNIT_TIMER_CELL._TIMER];
		}
		
		return _array;
	}
	
	static _tick_end = function(_super) {
		if (self.__count == 0) return true;
		self.tick(_super);
	}
	
	#region UNIT_PREPROCESSOR_TIMER_TIMERS_HANDLER_EXTEND_TICK
	
	// является ли текущий таймер (во время выполнения tick) связан с текущим обработчиком
	static _tick_isBind = function() {
		if (UNIT_PREPROCESSOR_TIMER_TIMERS_HANDLER_EXTEND_TICK) {
		
		return (self == UNIT_timerGetBind(self.__temp[__UNIT_TIMER_CELL._TIMER]));
		
		}
		else {
		
		show_error(____UNIT_TIMER_ERROR_TIMERS_HANDLER, true);
		
		}
	}
	
	// является ли текущий таймер (во время выполнения tick) связан с текущим обработчиком,
	// при условии, что он не менял очереди выполнения (был отвязан и привязан)
	static _tick_isEntry = function() {
		if (UNIT_PREPROCESSOR_TIMER_TIMERS_HANDLER_EXTEND_TICK) {
		
		return (self == self.__temp[__UNIT_TIMER_CELL._HANDLER]);
		
		}
		else {
		
		show_error(____UNIT_TIMER_ERROR_TIMERS_HANDLER, true);
		
		}
	}
	
	#endregion
	
}

/// @function		UNIT_timersHandlerDebugErrorMemory([step=~10sec], [f_handlers=log], [f_timers=log]);
function UNIT_timersHandlerDebugErrorMemory(_step=room_speed*10, _f_handlers, _f_timers) {
	static _memoryTime = 0;
	
	if (UNIT_PREPROCESSOR_TIMER_ENABLE_DEBUG) {
	
	var _interval = max(room_speed * 5 - 1, _step - 1);
	if (++_memoryTime > _interval) {
		_memoryTime = 0;
	}
	else exit;
	
	show_debug_message("\nUNIT::timer::UNIT_timersHandlerDebugErrorMemory();\n\n");
	
	_f_handlers ??= function(_handler) {
		if (UNIT_PREPROCESSOR_TIMER_ENABLE_DEBUG) {
		
		show_debug_message(@"UNIT::timer -> обнаружен обработчик, который не используется "
		+ string(_handler.__debug_time) + " frames; ~" + string(_handler.__debug_time / room_speed) + " seconds;"
		+ "\n\tUNIT::timer -> вероятная утечка памяти"
		+ "\n\tUNIT::timer -> inst: " + string(_handler)
		+ "\n\tUNIT::timer -> timers-list:"
		);
		
		var _timers = _handler._toArray();
		var _size = array_length(_timers);
		for (var _i = 0; _i < _size; ++_i) {
			show_debug_message("\t" + string(_i + 1) + ". " + string(_timers[_i]));
		}
		
		}
	}
	
	_f_timers ??= function(_timer) {
		if (UNIT_PREPROCESSOR_TIMER_ENABLE_DEBUG) {
		
		show_debug_message(@"UNIT::timer -> обнаружен таймер, который не используется "
		+ string(_timer.__debug_time) + " frames; ~" + string(_timer.__debug_time / room_speed) + " seconds;"
		+ "\n\tUNIT::timer -> вероятная утечка памяти"
		+ "\n\tUNIT::timer -> inst: " + string(_timer) + "\n"
		);
		
		}
	}
	
	var _handlers = ds_map_create();
	var _map = __UNIT_timersHandlerMap();
	
	var _key = ds_map_find_first(_map);
	var _val, _timer, _handler, _time;
	var _list;
	
	repeat ds_map_size(_map) {
		
		_val = _map[? _key];
		_key = ds_map_find_next(_map, _key);
		
		_handler = _val[__UNIT_TIMER_CELL._HANDLER];
		_timer   = _val[__UNIT_TIMER_CELL._TIMER];
		
		_list = _handlers[? _handler];
		if (_list == undefined) {
			_list = ds_list_create();
			ds_map_add_list(_handlers, _handler, _list);
		}
		
		_timer.__debug_time += _interval;
		if (_timer.__debug_time > _step) {
			
			if (_f_timers(_timer)) ds_map_delete(_map, _timer);
		}
		
		if (ds_map_exists(_map, _timer)) {
			
			ds_list_add(_list, _timer);
		}
	}
	
	_key = ds_map_find_first(_handlers);
	repeat ds_map_size(_handlers) {
		
		_val = _handlers[? _key];
		
		_handler = _key;
		_timer   = _val
		
		_key = ds_map_find_next(_handlers, _key);
		
		_handler.__debug_time += _interval;
		if (_handler.__debug_time > _step) {
			
			if (_f_handlers(_handler)) {
				
				var _size = ds_list_size(_timer);
				while (_size > 0) ds_map_delete(_map, _timer[| --_size]);
			}
		}
	}
	
	ds_map_destroy(_handlers);
	
	}
}

#region __private

#macro ____UNIT_TIMER_ERROR_CLONE			"UNIT::timer -> UNIT_PREPROCESSOR_TIMER_ENABLE_CLONE отключена"
#macro ____UNIT_TIMER_ERROR_TIMERS_HANDLER	"UNIT::timer -> UNIT_PREPROCESSOR_TIMER_TIMERS_HANDLER_EXTEND_TICK отключена"

enum __UNIT_TIMER_CELL { _HANDLER, _TIMER };

function __UNIT_timersHandlerMap() {
	static _map = ds_map_create();
	return _map;
}

#endregion


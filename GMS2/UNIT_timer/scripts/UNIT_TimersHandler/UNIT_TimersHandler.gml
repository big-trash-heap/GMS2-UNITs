
/*
	Запрещено создавать клоны UNIT_TimersHandler, но можно создавать клоны таймеров
	Однако предполагается, что вы не будете клонировать таймеры, так как это не безопасно
*/

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
		
		var _cell = [self, _timer];
		self._map[? _timer] = _cell;
		
		++self.__count;
		array_push(self.__timers, _cell);
		
		_timer.__init(self, _timer);
		return _timer;
	}
	
	static tick = function(_super) {
		
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
	
	static clearAll = function() {
		
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


#region __private

#macro ____UNIT_TIMER_ERROR_CLONE			"UNIT::timer -> UNIT_PREPROCESSOR_TIMER_ENABLE_CLONE отключена"
#macro ____UNIT_TIMER_ERROR_TIMERS_HANDLER	"UNIT::timer -> UNIT_PREPROCESSOR_TIMER_TIMERS_HANDLER_EXTEND_TICK отключена"

enum __UNIT_TIMER_CELL { _HANDLER, _TIMER };

function __UNIT_timersHandlerMap() {
	static _map = ds_map_create();
	return _map;
}

#endregion


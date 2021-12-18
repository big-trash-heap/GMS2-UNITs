
#macro UNIT_PREPROCESSOR_TIMER_ERROR_APPEND	true

function UNIT_TimersHandler() constructor {
	
	#region __private
	
	self.__timers = [];
	self.__count  = 0;
	
	if (UNIT_PREPROCESSOR_TIMER_ERROR_APPEND) {
	
	self.__clear = 0;
	
	}
	
	static _map = __UNIT_timerHandler();
	
	#endregion
	
	static append = function(_timer, _argument) {
		
		if (UNIT_timerGetHandler(_timer) == self) {
			
			show_error("UNIT::timer -> Таймер уже занят обработчиком", true);
		}
		
		var _cell = [self, _timer];
		self._map[? _timer] = _cell;
		
		++self.__count;
		array_push(self.__timers, _cell);
		
		_timer.__init(_timer, _argument, self);
		return _timer;
	}
	
	static tick = function(_super) {
		
		var _size = array_length(self.__timers);
		if (_size > 0) {
			
			if (UNIT_PREPROCESSOR_TIMER_ERROR_APPEND) {
				
			if (self.__clear > 0) show_error("UNIT::timer -> нельзя вызывать tick во время вызова tick, clear, clearAll", true);
			self.__clear += 1;
			
			}
			
			var _i = 0, _j = 0, _value, _timer;
			do {
				
				_value = self.__timers[_i];
				if (_value[UNIT_TIMER_CELL.HANDLER] == self) {
					
					_timer = _value[UNIT_TIMER_CELL.TIMER];
					if (not _timer.__tick(self, _timer, _super)) {
						self.__timers[_j] = _value;
						++_j;
					}
					else
					if (_value[UNIT_TIMER_CELL.HANDLER] == self)
						UNIT_timerRemove(_timer);
				}
			} until (++_i == _size);
			
			_size = array_length(self.__timers);
			while (_i != _size) {
				
				_value = self.__timers[_i];
				++_i;
				
				if (_value[UNIT_TIMER_CELL.HANDLER] == self) {
					self.__timers[_j] = _value;
					++_j;
				}
			}
			
			array_resize(self.__timers, _j);
			
			if (UNIT_PREPROCESSOR_TIMER_ERROR_APPEND) {
			
			self.__clear -= 1;
			
			}
		}
	}
	
	static clear = function() {
		
		var _size = array_length(self.__timers);
		if (_size > 0) {
			
			if (UNIT_PREPROCESSOR_TIMER_ERROR_APPEND) {
			
			self.__clear += 1;
			
			}
			
			var _i = 0, _value;
			while (_i < _size) {
				
				_value = self.__timers[_i];
				++_i;
				
				if (_value[UNIT_TIMER_CELL.HANDLER] == self)
					UNIT_timerRemove(_value[UNIT_TIMER_CELL.TIMER]);
			}
			
			if (UNIT_PREPROCESSOR_TIMER_ERROR_APPEND) {
			
			self.__clear -= 1;
			
			}
		}
	}
	
	static clearAll = function() {
		
		if (array_length(self.__timers) > 0) {
			
			if (UNIT_PREPROCESSOR_TIMER_ERROR_APPEND) {
			
			self.__clear += 1;
			
			}
			
			var _i = 0, _value;
			while (_i < array_length(self.__timers)) {
				
				_value = self.__timers[_i];
				++_i;
				
				if (_value[UNIT_TIMER_CELL.HANDLER] == self)
					UNIT_timerRemove(_value[UNIT_TIMER_CELL.TIMER]);
			}
			
			if (UNIT_PREPROCESSOR_TIMER_ERROR_APPEND) {
			
			self.__clear -= 1;
			
			}
		}
	}
	
	static getCount = function() {
		return self.__count;	
	}
	
	static isEmpty = function() {
		return (self.__count == 0);	
	}
	
	static isBind = function(_timer) {
		
		return (self == UNIT_timerGetHandler(_timer));
	}
	
	static toString = function() {
		return ("UNIT::timer::" + instanceof(self) + "; number of timers: " + string(self.__count));
	}
	
}


#region __private

enum UNIT_TIMER_CELL { HANDLER, TIMER };

function __UNIT_timerHandler() {
	static _map = ds_map_create();
	return _map;
}

function UNIT_timerHandler() {};

#endregion


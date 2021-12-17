

function UNIT_TimerHandler() {
	
	#region __private
	
	self.__timers = [];
	self.__count  = 0;
	
	self.__clear_i = -1;
	self.__clear_j = -1;
	
	static _map = __UNIT_timerHandler();
	
	#endregion
	
	static append = function(_timer, _argument) {
		
		if (ds_map_exists(self._map, _timer)) {
			
			show_error("UNIT::timer -> Таймер уже занят обработчиком", true);
		}
		
		var _cell = [self, _timer];
		self._map[? _timer] = _cell;
		
		++self.__count;
		array_push(self.__timers, _cell);
		
		_timer.__init(_timer, _argument, self);
		return _timer;
	}
	
	static iter = function() {
		
		var _size = array_length(self.__timers);
		if (_size > 0) {
		
			var _i = 0, _j = 0, _value, _timer;
			do {
				
				_value = self.__timers[_i];
				if (_value[UNIT_TIMER_CELL.HANDLER] == self) {
					
					_timer = _value[UNIT_TIMER_CELL.TIMER];
					if (_timer.__tick(self, _timer) == false) {
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
				self.__timers[_j] = self.__timers[_i];
				++_j;
				++_i;
			}
			
			array_resize(self.__timers, _j);
		}
	}
	
	static clear = function() {
		
		var _size = array_length(self.__timers);
		if (_size > 0) {
			
			if (self.__clear_i < 0) {
				
				if (self.__clear_i == -2) return;
				self.__clear_i = 0;
			}
			
			self.__clear_j = _size;
			
			var _value;
			while (self.__clear_i != self.__clear_j) {
				
				_value = self.__timers[self.__clear_i++];
				if (_value[UNIT_TIMER_CELL.HANDLER] == self)
					UNIT_timerRemove(_value[UNIT_TIMER_CELL.TIMER]);
			}
			
			if (self.__clear_i < 0) return;
			_size = array_length(self.__timers);
			
			var _j = 0;
			while (self.__clear_i != _size) {
				self.__timers[_j] = self.__timers[self.__clear_i];
				++_j;
				++self.__clear_i;
			}
			
			array_resize(self.__timers, _j);
			
			self.__clear_i = -1;
			self.__clear_j = -1;
		}
	}
	
	static clearAll = function() {
		
		if (array_length(self.__timers) > 0) {
			
			self.__clear_i = -2;
			self.__clear_j = -1;
			
			var _i = 0, _value;
			do {
				
				_value = self.__timers[_i];
				if (_value[UNIT_TIMER_CELL.HANDLER] == self)
					UNIT_timerRemove(_value[UNIT_TIMER_CELL.TIMER]);
			} until (++_i == array_length(self.__timers));
			
			array_resize(self.__timers, 0);
			
			self.__clear_i = -1;
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


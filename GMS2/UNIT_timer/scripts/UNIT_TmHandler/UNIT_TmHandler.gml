
/*
	Предполагается, что вы не будете использовать:
	1. UNIT_PREPROCESSOR_TM_ENABLE_CLONE
	2. UNIT_PREPROCESSOR_TM_HANDLER_EXTEND_TICK
	3. UNIT_PREPROCESSOR_TM_TIMER_ENABLE_MARK
*/

// debug
#macro UNIT_PREPROCESSOR_TM_ENABLE_LOG                       true
#macro UNIT_PREPROCESSOR_TM_HANDLER_ENABLE_CHECK_ERROR_TICK	 true

// extend 0
#macro UNIT_PREPROCESSOR_TM_ENABLE_BIND_SWITCH               true
#macro UNIT_PREPROCESSOR_TM_HANDLER_ENABLE_INFORMING_BINDING true

// extend 1
#macro UNIT_PREPROCESSOR_TM_ENABLE_CLONE                     false
#macro UNIT_PREPROCESSOR_TM_HANDLER_EXTEND_TICK              false

function UNIT_TmHandler()
	: __UNIT_TmHandlerPreprocessor()
	constructor {
	
	#region __private
	
	static __timerBind = function(_timer) {
		
		return { timer: _timer };
	}
	
	static __timerUnbind = function(_timer, _data) {
		
		_data.timer = undefined;
	}
	
	self.__timers = [];
	self.__count  = 0;
	self.__clear  = -1;
	
	static __unbind = function(_timer, _inTick) {
		
		#region PREPROCESSOR
		if (UNIT_PREPROCESSOR_TM_HANDLER_ENABLE_INFORMING_BINDING) {
		
		self.__info_unbind(_timer);
		
		}
		#endregion
		
		_timer.__unbind();
		
		--self.__count;
		_timer.__free(self, _timer, _inTick);
	}
	
	#endregion
	
	static bind = function(_timer) {
		
		if (_timer.isBind()) {
			
			show_error("UNIT::timer -> таймер уже занят обработчиком", true);
		}
		
		#region PREPROCESSOR
		if (UNIT_PREPROCESSOR_TM_ENABLE_BIND_SWITCH) {
		
		if (_timer._bindCan() == false)
			show_error("UNIT::timer -> таймер отключил возможность привязыватся, используйте ._binCan(), чтобы проверить возможность привязать таймер к обработчику", true);
		
		}
		#endregion
		
		#region PREPROCESSOR
		if (UNIT_PREPROCESSOR_TM_HANDLER_ENABLE_INFORMING_BINDING) {
		
		self.__info_bind(_timer);
		
		}
		#endregion
		
		var _anchor = _timer.__bind(self);
		
		++self.__count;
		array_push(self.__timers, _anchor);
		
		_timer.__init(self, _timer);
		
		return _timer;
	}
	
	static tick = function(_super) {
		
		var _size = array_length(self.__timers);
		if (_size > 0) {
			
			#region PREPROCESSOR
			if (UNIT_PREPROCESSOR_TM_HANDLER_ENABLE_CHECK_ERROR_TICK) {
			
			if (self.__clear != -1) show_error("UNIT::timer -> нельзя вызывать tick во время вызова tick, clear, clearLoop", true);
			self.__clear = -2;
			
			}
			#endregion
			
			var _i = 0, _j = 0;
			var _value, _timer;
			do {
				
				_value = self.__timers[_i];
				_timer = _value.timer;
				
				if (_timer != undefined) {
					
					#region PREPROCESSOR
					if (UNIT_PREPROCESSOR_TM_HANDLER_EXTEND_TICK) {
					
					self.__temp = _value;
					
					}
					#endregion
					
					if (not _timer.__tick(self, _timer, _super)) {
						self.__timers[_j] = _value;
						++_j;
					}
					else {
						
						// remove mode: handler-space 
						if (_timer.getBind() == self) {
							self.__unbind(_timer, true);
						}
						
					}
				}
			} until (++_i == _size);
			
			_size = array_length(self.__timers);
			while (_i != _size) {
				
				_value = self.__timers[_i];
				++_i;
				
				if (_value.timer != undefined) {
					self.__timers[_j] = _value;
					++_j;
				}
			}
			
			#region PREPROCESSOR
			if (UNIT_PREPROCESSOR_TM_HANDLER_EXTEND_TICK) {
			
			delete self.__temp;
			
			}
			#endregion
			
			array_resize(self.__timers, _j);
			
			#region PREPROCESSOR
			if (UNIT_PREPROCESSOR_TM_HANDLER_ENABLE_CHECK_ERROR_TICK) {
			
			self.__clear = -1;
			
			}
			#endregion
			
		}
	}
	
	// удалит текущие таймеры в очереди
	static clear = function() {
		
		var _size = array_length(self.__timers);
		if (_size > 0) {
			
			self.__clear = max(0, self.__clear);
			
			var _value, _timer;
			while (self.__clear < _size) {
				
				_value = self.__timers[self.__clear];
				_timer = _value.timer;
				
				++self.__clear;
				
				if (_timer != undefined) {
					
					self.__unbind(_timer, false);
					if (self.__clear == -1) return;
				}
			}
			
			self.__clear = -1;
		}
	}
	
	// очень опасный метод
	static clearLoop = function(_countAttempts=infinity) {
		
		#region PREPROCESSOR
		if (UNIT_PREPROCESSOR_TM_ENABLE_LOG) {
		
		show_debug_message("UNIT::timer -> вы вызвали TmHandler.clearLoop это может быть опасно. Избегайте его вызова");
		show_debug_message("\tUNIT::timer::clearLoop -> количество итераций: " + string(_countAttempts));
		
		if (is_infinity(_countAttempts) && sign(_countAttempts) == 1) {
			
			show_debug_message("\tUNIT::timer::clearLoop -> бесконечное количество итераций может привести к зависанию");
		}
		
		}
		#endregion
		
		var _size = array_length(self.__timers);
		if (_size > 0) {
			
			#region PREPROCESSOR
			if (UNIT_PREPROCESSOR_TM_ENABLE_LOG) {
			
			if (self.__clear != -1) {
				show_debug_message("\tUNIT::timer::clearLoop -> возможный вызов TmHandler.clearLoop в TmHandler.clearLoop. Это может привести к зависанию");
			}
			
			}
			#endregion
			
			self.__clear = max(0, self.__clear);
			
			while (_countAttempts > 0) {
				
				--_countAttempts;
				
				var _value, _timer;
				while (self.__clear < _size) {
					
					_value = self.__timers[self.__clear];
					_timer = _value.timer;
					
					++self.__clear;
					
					if (_timer != undefined) {
						
						self.__unbind(_timer, false);
						if (self.__clear == -1) {
							
							_countAttempts = -10;
							return;
						}
					}
				}
				
				_size = array_length(self.__timers);
				if (_size == self.__clear) break;
			}
			
			#region PREPROCESSOR
			if (UNIT_PREPROCESSOR_TM_ENABLE_LOG) {
			
			show_debug_message("\tUNIT::timer::clearLoop -> не удачное удаление, возможно некоторые таймеры при удаление порождают другие таймеры и т.д.");
			
			}
			#endregion
			
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
		
		return (self == UNIT_tmGetBind(_timer));
	}
	
	static isTimer = function() {
		return false;
	}
	
	static isHandler = function() {
		return true;
	}
	
	static toString = function() {
		return ("UNIT::timer::" + instanceof(self) + "; number of timers: " + string(self.__count));
	}
	
}

#region __private

#macro ____UNIT_TM_ERROR_CLONE          "UNIT::timer -> UNIT_PREPROCESSOR_TM_ENABLE_CLONE отключена"
#macro ____UNIT_TM_ERROR_BIND_SWITCH    "UNIT::timer -> UNIT_PREPROCESSOR_TM_ENABLE_BIND_SWITCH отключена"
#macro ____UNIT_TM_ERROR_HANDLER        "UNIT::timer -> UNIT_PREPROCESSOR_TM_HANDLER_EXTEND_TICK отключена"

function __UNIT_TmHandlerPreprocessor() constructor {
	
	if (UNIT_PREPROCESSOR_TM_HANDLER_EXTEND_TICK) {
	
	self.__temp = undefined;
	
	}
	
	static __info_bind   = __UNIT_tmVoid;
	static __info_unbind = __UNIT_tmVoid;
	
	static __clone = function(_constructor) {
		
		if (UNIT_PREPROCESSOR_TM_ENABLE_CLONE) {
		
		var _handler = new _constructor();
		var _value, _timer;
		
		for (var _i = 0, _j = -1; _i < self.__count; ++_i) {
			
			do {
				_value = self.__timers[++_j];
				_timer = _value.timer;
			} until (_timer != undefined);
			
			_handler.bind(_timer._clone());
		}
		
		return _handler;
		
		}
		else {
		
		show_error(____UNIT_TM_ERROR_CLONE, true);
		
		}
	}
	
	#region public
	
	static _clone = function() {
		
		if (UNIT_PREPROCESSOR_TM_ENABLE_CLONE) {
		
		if (UNIT_PREPROCESSOR_TM_ENABLE_LOG) {
		
		show_debug_message("UNIT::timer -> осторожно, класс " + instanceof(self) + " использует базовую версию метода _clone");
		
		}
		
		return self.__clone(asset_get_index(instanceof(self)));
		
		}
		else {
		
		show_error(____UNIT_TM_ERROR_CLONE, true);
		
		}
	}
	
	static _toArray = function() {
		
		var _array = array_create(self.__count);
		var _value, _timer;
		
		for (var _i = 0, _j = -1; _i < self.__count; ++_i) {
			
			do {
				_value = self.__timers[++_j];
				_timer = _value.timer;
			} until (_timer != undefined);
			
			_array[_i] = _timer;
		}
		
		return _array;
	}
	
	static _tick_end = function(_super) {
		if (self.__count == 0) return true;
		self.tick(_super);
	}
	
	/// ### UNIT_PREPROCESSOR_TM_HANDLER_EXTEND_TICK
	
	// является ли текущий таймер (во время выполнения tick) связан с текущим обработчиком
	static _tick_isBind = function() {
		
		if (UNIT_PREPROCESSOR_TM_HANDLER_EXTEND_TICK) {
		
		var _timer = self.__temp.timer;
		return (_timer != undefined && self == _timer.getBind());
		
		}
		else {
		
		show_error(____UNIT_TM_ERROR_HANDLER, true);
		
		}
	}
	
	// является ли текущий таймер (во время выполнения tick) связан с текущим обработчиком,
	// при условии, что он не менял очереди выполнения (был отвязан и привязан)
	static _tick_isEntry = function() {
		
		if (UNIT_PREPROCESSOR_TM_HANDLER_EXTEND_TICK) {
		
		return (self.__temp.timer != undefined);
		
		}
		else {
		
		show_error(____UNIT_TM_ERROR_HANDLER, true);
		
		}
	}
	
	#endregion
	
}

#endregion


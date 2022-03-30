
// extend
#macro UNIT_PREPROCESSOR_TM_TIMER_ENABLE_MARK	true

// Абстрактный класс
function UNIT_TmTimer() 
	: __UNIT_TmTimerPreprocessor()
	constructor {
	
	#region __private
	
	self.__handler = undefined;
	
	static __init = __UNIT_tmVoid /* handler, timer         */;
	static __tick = __UNIT_tmVoid /* handler, timer, super  */;
	static __free = __UNIT_tmVoid /* handler, timer, inTick */;
	
	#region interface-connect
	
	static __data = function() {
		return self.__handler.data;
	}
	
	static __bind = function(_handler, _data) {
		
		#region PREPROCESSOR
		if (UNIT_PREPROCESSOR_TM_TIMER_ENABLE_MARK) {
		
		self.__markReference = weak_ref_create(self);
		
		}
		#endregion
		
		self.__handler = {
			handler: _handler,
			data: _data,
		}
		
		return _data;
	}
	
	static __unbind = function() {
		
		#region PREPROCESSOR
		if (UNIT_PREPROCESSOR_TM_TIMER_ENABLE_MARK) {
		
		self.__markReference = weak_ref_create(self);
		
		}
		#endregion
		
		delete self.__handler;
	}
	
	#endregion
	
	#region interface-change_f
	
	static __set_finit = function(_f) {
		__UNIT_tmSetF("__init", _f);
	}
	
	static __set_ftick = function(_f) {
		__UNIT_tmSetF("__tick", _f);
	}
	
	static __set_ffree = function(_f) {
		__UNIT_tmSetF("__free", _f);
	}
	
	#endregion
	
	#endregion
	
	static unbind = function(_inTick=false) {
		
		if (self.__handler != undefined) {
			
			self.__handler.handler.__unbind(self, _inTick);
			return true;
		}
		
		return false;
	}
	
	static isBind = function() {
		
		return (self.__handler != undefined);
	}
	
	static getBind = function() {
		
		return self.__handler.handler;
	}
	
	static toString = function() {
		return ("UNIT::tm::" + instanceof(self));
	}
	
	
	static getCategory = function() {
		return UNIT_TM_CATEGORY._TIMER;
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
	        if (not _replace and variable_struct_exists(self, _key)) continue;
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
	
}

/// @param			timer
/// @description	Отвяжет таймер от обработчика 
//					и вернёт true, если таймер был отвязан
function UNIT_tmUnbind(_timer) {

	return _timer.unbind();
}

/// @param			timer
/// @description	Вернёт привязан ли таймер к чему-то
function UNIT_tmIsBind(_timer) {

	return _timer.isBind();
}

/// @param			timer
/// @description	Вернёт обработчик, к которому привязан таймер
//					Если не привязан вернёт undefined
function UNIT_tmGetBind(_timer) {

	return _timer.getBind();
}


#region __private

function __UNIT_TmTimerPreprocessor() constructor {
	
	if (UNIT_PREPROCESSOR_TM_TIMER_ENABLE_MARK) {
	
	self.__markReference = weak_ref_create(self);
	
	}
	
	// этот метод нельзя переопределять
	static __copyn_ = function(_struct) {
		
		if (UNIT_PREPROCESSOR_TM_ENABLE_CLONE) {
		
		var _keys = variable_struct_get_names(_struct);
		var _size = array_length(_keys), _key;
		while (_size > 0) {
			
			_key = _keys[--_size];
			if (string_char_at(_key, 1) != "_")
				self[$ _key] = _struct[$ _key];
		}
		
		if (UNIT_PREPROCESSOR_TM_ENABLE_LOG) {
		
		if (instanceof(self) == instanceof(_struct) && (
			self._get_ftick() != _struct._get_ftick() ||
			self._get_finit() != _struct._get_finit() ||
			self._get_ffree() != _struct._get_ffree())) {
			
			show_debug_message("UNIT::tm -> вероятно не верная реализация метода _clone в классе " + instanceof(self)
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
		
		if (UNIT_PREPROCESSOR_TM_ENABLE_BIND_SWITCH) {
		
		(_struct._bindCan() ? self._bindEnable : self._bindDisable)();
		
		}
		
		return self;
		
		}
		else {
		
		show_error(____UNIT_TM_ERROR_CLONE, true);
		
		}
	}
	
	#region public
	
	static _clone = function() {
		if (UNIT_PREPROCESSOR_TM_ENABLE_CLONE) {
		
		show_error("UNIT::tm -> для класса " + instanceof(self) + " не определён метод _clone", true);
		
		}
		else {
		
		show_error(____UNIT_TM_ERROR_CLONE, true);
		
		}
	}
	
	
	static _mark = function() {
		if (UNIT_PREPROCESSOR_TM_TIMER_ENABLE_MARK) {
		
		return self.__markReference;
		
		}
		else {
		
		show_error("UNIT::tm -> UNIT_PREPROCESSOR_TM_TIMER_ENABLE_MARK отключена", true);
		
		}
	}
	
	
	static _bindCan = function() {
		if (UNIT_PREPROCESSOR_TM_ENABLE_BIND_SWITCH) {
		
		return (not variable_struct_exists(self, "__bindSwitch"));
		
		}
		else {
		
		show_error(____UNIT_TM_ERROR_BIND_SWITCH, true);
		
		}
	}
	
	static _bindEnable = function() {
		if (UNIT_PREPROCESSOR_TM_ENABLE_BIND_SWITCH) {
		
		variable_struct_remove(self, "__bindSwitch");
		return self;
		
		}
		else {
		
		show_error(____UNIT_TM_ERROR_BIND_SWITCH, true);
		
		}
	}
	
	static _bindDisable = function() {
		if (UNIT_PREPROCESSOR_TM_ENABLE_BIND_SWITCH) {
		
		self.__bindSwitch = undefined;
		return self;
		
		}
		else {
		
		show_error(____UNIT_TM_ERROR_BIND_SWITCH, true);
		
		}
	}
	
	#endregion
	
}

#endregion

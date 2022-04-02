

function UNIT_Eventor() : UNIT_EventSingle() constructor {
	
	#region __private
	
	static __compareSelf = function(_self0, _self1) {
	
		static _split = function(_self) {
			
			if (instanceof(_self) == "instance") {
				
				return _self[$ "id"];
			}
			
			return _self;
		}
		
		return (_split(_self0) == _split(_self1));
	}
	
	static __isFuntionsEqual = function(_present_f, _f) {
		
		if (is_numeric(_present_f)) {
			
			return (_f == _present_f);
		}
		else {
			
			if (is_numeric(_f)) {
				
				return (method_get_index(_present_f) == _f);
			}
			else {
				
				if (typeof(_f) == "struct") {
					
					return self.__compareSelf(_f, method_get_self(_present_f));
				}
				
				return (
					method_get_index(_present_f) == method_get_index(_f) &&
					self.__compareSelf(method_get_self(_f), method_get_self(_present_f))
				);
			}
		}
	}
	
	static __getArray = function(_key) {
		
		var _array = self.__events[$ _key];
		if (not is_array(_array)) {
			
			_array = [];
			self.__events[$ _key] = _array;
		}
		
		return _array;
	}
	
	#endregion
	
	static on = function(_key, _f) {
		
		array_push(self.__getArray(_key), _f);
		return self;
	}
	
	static off = function(_key, _f, _byIndex=false) {
		
		var _array = self.__events[$ _key];
		if (is_array(_array)) {
			
			if (_byIndex && is_method(_f)) _f = method_get_index(_f);
			
			var _size = array_length(_array);
			var _vals;
			while (_size > 0) {
				
				_vals = _array[--_size];
				if (self.__isFuntionsEqual(_vals, _f)) {
					
					array_delete(_array, _size, 1);
					if (array_length(_array) == 0)
						variable_struct_remove(self.__events, _key);
					
					return _vals;
				}
			}
		}
	}
	
	static remFst = off;
	
	static remAll = function(_key, _f, _byIndex=false) {
		
		var _array = self.__events[$ _key];
		if (is_array(_array)) {
			
			if (_byIndex && is_method(_f)) _f = method_get_index(_f);
			
			var _size = array_length(_array);
			var _arrayOfRemoved = [];
			var _i = 0, _j = 0, _present_f;
			do {
				
				_present_f = _array[_i];
				if (not self.__isFuntionsEqual(_present_f, _f))
					_array[@ _j++] = _present_f;
				else
					array_push(_arrayOfRemoved, _present_f);
			} until (++_i == _size);
			
			if (_j == 0)
				variable_struct_remove(self.__events, _key);
			else
				array_resize(_array, _j);
			
			return _arrayOfRemoved;
		}
		
		return [];
	}
	
	static exec = function(_key, _arg) {
		
		var _array = self.__events[$ _key];
		if (is_array(_array)) {
			
			var _size = array_length(_array);
			for (var _i = 0; _i < _size; ++_i) _array[_i](_arg);
			
			return true;
		}
		
		return false;
	}
	
	static execFilter = function(_key, _arg) {
		
		var _array = self.__events[$ _key];
		if (is_array(_array)) {
			
			var _size = array_length(_array);
			var _i = 0, _j = 0, _present_f;
			do {
				
				_present_f = _array[_i];
				if (not _present_f(_arg))
					_array[@ _j++] = _present_f;
			} until (++_i == _size);
			
			if (_j == 0)
				variable_struct_remove(self.__events, _key);
			else
				array_resize(_array, _j);
			
			return true;
		}
		
		return false;
	}
	
	static count = function(_key) {
		
		if (is_string(_key)) {
			
			var _array = self.__events[$ _key];
			if (is_array(_array)) return array_length(_array);
			
			return 0;
		}
		
		return variable_struct_names_count(self.__events);
	}
	
	static toString = function() {
		var _events = "";
		var _keys = variable_struct_get_names(self.__events);
		var _size = array_length(_keys);
		if (_size > 0) {
			
			_events = "\"" + _keys[0] + "\": " + string(
				array_length(self.__events[$ _keys[0]])
			);
			for (var _i = 1; _i < _size; ++_i) {
				
				_events += ", \"" + _keys[_i] + "\": "+ string(
					array_length(self.__events[$ _keys[_i]])
				);
			}
		}
		return ("UNIT::event::" + instanceof(self) + "(" + _events + ");");
	}
	
	static toArray = function(_key) {
		
		var _array = self.__events[$ _key];
		if (is_array(_array)) {
			
			var _size = array_length(_array);
			var _copy = array_create(_size);
			array_copy(_copy, 0, _array, 0, _size);
			return _copy;
		}
		
		return [];
	}
	
}


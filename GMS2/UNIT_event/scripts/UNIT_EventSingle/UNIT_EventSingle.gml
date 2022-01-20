

function UNIT_EventSingle() constructor {
	
	#region __private
	
	self.__events = {};
	
	#endregion
	
	static on = function(_key, _f) {
		
		var _old = self.__events[$ _key];
		self.__events[$ _key] = _f;
		return _old;
	}
	
	static off = function(_key, _f) {
		
		var _old = self.__events[$ _key];
		variable_struct_remove(self.__events, _key);
		return _old;
	}
	
	static clear = function(_key) {
		
		if (is_string(_key)) {
			
			variable_struct_remove(self.__events, _key);
		}
		else {
			
			delete self.__events;
			self.__events = {};
		}
		
		return self;
	}
	
	static exec = function(_key, _arg) {
		
		var _f = self.__events[$ _key];
		if (_f != undefined) {
			
			return _f(_arg);
		}
	}
	
	static execFilter = function(_key, _arg) {
		
		var _f = self.__events[$ _key];
		if (_f != undefined) {
			
			if (_f(_arg)) variable_struct_remove(self.__events, _key);
			return true;
		}
		
		return false;
	}
	
	static exists = function(_key) {
		
		return variable_struct_exists(self.__events, _key);
	}
	
	static count = function(_key) {
		
		if (is_string(_key)) {
			
			if (variable_struct_exists(self.__events, _key))
				return 1;
			
			return 0;
		}
		
		return variable_struct_names_count(self.__events);
	}
	
	static toString = function() {
		var _events = "";
		var _keys = variable_struct_get_names(self.__events);
		var _size = array_length(_keys);
		if (_size > 0) {
			
			_events = "\"" + _keys[0] + "\"";
			for (var _i = 1; _i < _size; ++_i) {
				
				_events += ", \"" + _keys[_i] + "\"";
			}
		}
		return ("UNIT::event::" + instanceof(self) + "(" + _events + ");");
	}
	
}


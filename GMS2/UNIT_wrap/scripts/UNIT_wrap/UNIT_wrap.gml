
function UNIT_wrap() {
	return new __UNIT_wrap();
}

/// @param			value
function UNIT_isWrap(_value) {
	return (instanceof(_value) == "__UNIT_wrap");
}


#region __private

function __UNIT_wrap() constructor {
	
	static _set = function(_key, _value) {
		self[$ _key] = _value;
		return self;
	}
	
	static _ext = function(_struct, _replace=true) {
		
		var _keys = variable_struct_get_names(_struct);
		var _size = array_length(_keys), _key;
		while (_size > 0) {
			_key = _keys[--_size];
			if (!_replace && variable_struct_exists(_struct, _key)) continue;
			self[$ _key] = _struct[$ _key];
		}
		return self;
	}
	
	static toString = function() {
		return "UNIT::wrap";	
	}
	
}

#endregion


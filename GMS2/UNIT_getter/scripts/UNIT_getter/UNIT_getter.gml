

function UNIT_getterBoolT() { return true;  };
function UNIT_getterBoolF() { return false; };

/// @description	Создаёт метод, который возвращает значение
//
//					g() -> value
//
/// @param			value
function UNIT_getterAny(_value) {
	static _any = method_get_index(function() {
		return self.value;
	});
	return method({ value: _value }, _any);
}

/// @description	Создаёт метод доступа к элементу
//					Смещает контекст вызова, используйте методы
//
//					g(value) -> value
//
//					Ключи доступа:
//					|, # [x, y], ?, @, $,
//					s - string
//					i - variable_instance_get
//					g - variable_global_get
//					m () - вызов метода { key(value) -> }
//
/// @param			...char,key...
function UNIT_getterAccess() {
	
	static _table = function() {
		
		var _table = {};
		
		_table[$ "@"] = array_get;
		_table[$ "$"] = variable_struct_get;
		_table[$ "?"] = ds_map_find_value;
		_table[$ "|"] = ds_list_find_value;
		_table[$ "s"] = string_char_at;
		_table[$ "i"] = variable_instance_get;
		_table[$ "g"] = variable_global_get;
		_table[$ "m"] = method_get_index(function(_data, _key) {
			return _key(_data);
		});
		_table[$ "#"] = method_get_index(function(_data, _key) {
			return ds_grid_get(_data, _key[0], _key[1]);
		});
		
		return _table;
	}();
	
	static _read = method_get_index(function(_value) {
		
		var _size = array_length(self.array);
		var _state;
		for (var _i = 0; _i < _size; ++_i) {
			
			_state = self.array[_i];
			_value = _state[0](_value, _state[1]);
		}
		
		return _value;
	});
	
	var _argSize = argument_count div 2;
	var _array = array_create(_argSize);
	for (var _i = 0, _j; _i < _argSize; ++_i) {
		
		_j = _i * 2;
		_array[_i] = [_table[$ argument[_j]], argument[_j + 1]];
	}
	
	return method({ array: _array }, _read);
}

//					f = function(argument, data);
/// @function		UNIT_getterCall(f, data);
/// @description	Создаёт метод, который вызывает другую функцию
//					Смещает контекст вызова, используйте методы
//
//					g(argument) -> value
//
function UNIT_getterCall(_f, _data) {
	static _call = method_get_index(function(_argument) {
		
		return self.f(_argument, self.data);
	});
	return method({ f: _f, data: _data }, _call);
}


#region __private

function UNIT_getter() {};

#endregion


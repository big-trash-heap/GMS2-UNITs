

#region modify

//					f = function(value, index, data)
/// @function		UNIT_arrMap(array, f, [data]);
function UNIT_arrMap(_array, _f, _data) {
	var _size = array_length(_array);
	for (var _i = 0; _i < _size; ++_i) 
		array_set(_array, _i, _f(_array[_i], _i, _data));
}

//					f = function(value, index, data)
/// @function		UNIT_arrFilter(array, f, [data]);
function UNIT_arrFilter(_array, _f, _data) {
	
	var _size = array_length(_array);
	if (_size > 0) {
		
		var _i = 0, _j = 0, _value;
		do {
		
			_value = _array[_i];
			if (_f(_value, _i, _data))
				_array[@ _j++] = _value;
		} until (++_i == _size);
		array_resize(_array, _j);
	}
}

#endregion

#region build

//					f = function(value, index, data)
/// @function		UNIT_arrBulMap(array, f, [data]);
function UNIT_arrBulMap(_array, _f, _data) {
	
	var _size = array_length(_array);
	var _arrayBul = array_create(_size);
	
	for (var _i = 0; _i < _size; ++_i) 
		array_set(_arrayBul, _i, _f(_array[_i], _i, _data));
	
	return _arrayBul;
}

//					f = function(value, index, data)
/// @function		UNIT_arrBulFilter(array, f, [data]);
function UNIT_arrBulFilter(_array, _f, _data) {
	
	var _size = array_length(_array);
	var _arrayBul = [];
    
	if (_size > 0) {
		
        var _i = 0, _value;
        do {
			
            _value = _array[_i];
            if (_f(_value, _i, _data)) array_push(_arrayBul, _value);
        } until (++_i == _size);
    }
    
	return _arrayBul;
}

//					valid = function(value, data)
/// @function		UNIT_arrSplit([valid=true], [data], ...args);
function UNIT_arrSplit(_valid, _data) {
	
	var _argSize = argument_count;
	if (_argSize - 2 > 0) {
		
		_valid ??= __UNIT_arr_getTrue;
		
		var _stack = ds_stack_create();
		var _build = [];
		
		var _array, _size, _j;
		var _pack, _value;
		
		for (var _i = 2; _i < _argSize; ++_i) {
			
			_value = argument[_i];
			if (is_array(_value)) {
				
				ds_stack_push(_stack, [0, _value]);
				do {
					
					_pack = ds_stack_top(_stack);
					_array = _pack[1];
					_size = array_length(_array);
					
					for (_j = _pack[0]; _j < _size; ++_j) {
						
						_value = _array[_j];
						if (is_array(_value)) {
							ds_stack_push(_stack, [0, _value]);
							
							_pack[@ 0] = _j + 1;
							_j = -1;
							break;
						}
						else
						if (_valid(_value, _data)) {
							array_push(_build, _value);	
						}
					}
					
					if (_j != -1) ds_stack_pop(_stack);
				} until (ds_stack_empty(_stack));
			}
			else
			if (_valid(_value, _data)) {
				
				array_push(_build, _value);	
			}
		}
		
		ds_stack_destroy(_stack);
		return _build;
	}
	
	return [];
}

#endregion

#region find

//					f = function(value, index, data)
/// @function		UNIT_arrFind(array, index, step, f, [data]);
function UNIT_arrFind(_array, _index, _step, _f, _data) {
	
	if (_step > 0) {
		
		var _size = array_length(_array);
		for (; _index < _size; _index += _step) {
			
			if (_f(_array[_index], _index, _data)) return _index;
		}
	}
	else {
		
		for (; _index >= 0; _index += _step) {
			
			if (_f(_array[_index], _index, _data)) return _index;
		}
	}
	
	return -1;
}

//					fbetter = function(previos, next, data)
//					ffind   = function(value, index, data)
/// @function		UNIT_arrFindBetter(array, index, fbetter, [data_better], [ffind=true], [data_find]);
function UNIT_arrFindBetter(_array, _index, _fbetter, _data_better, _ffind, _data_find) {
	
	var _size = array_length(_array);
	if (_size > 0) {
		
		_ffind ??= __UNIT_arr_getTrue;
		for (var _size = array_length(_array); _index < _size; ++_index) {
			
			if (_ffind(_array[_index], _index, _data_find)) {
				
				var _find_v = _array[_index];
				var _find_i = _index;
				var _value;
				
				for (++_index; _index < _size; ++_index) {
					
					_value = _array[_index];
					if (_ffind(_value, _index, _data_find) &&
						_fbetter(_find_v, _value, _data_better)) {
						
						_find_v = _value;
						_find_i = _index;
					}
				}
				
				return _find_i;
			}
		}
	}
	
	return -1;
}

#endregion

#region other

//					f = function(value, index, data)
/// @function		UNIT_arrForEach(array, f, [data], [index=0]);
function UNIT_arrForEach(_array, _f, _data, _index=0) {
	
	var _size = array_length(_array);
	for (; _index < _size; ++_index) 
		if (_f(_array[_index], _index, _data)) return _index;
	
	return -1;
}

#endregion


#region __private

function __UNIT_arr_getTrue() {
	return true;
}

function UNIT_arrayHigher() {};

#endregion


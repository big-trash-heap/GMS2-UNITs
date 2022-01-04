

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

/// @function		UNIT_arrFlatten(...args);
function UNIT_arrFlatten() {
	
	var _argSize = argument_count;
	if (_argSize > 0) {
		
		var _stack = ds_stack_create();
		var _build = [];
		
		var _array, _size, _j;
		var _pack, _value;
		
		var _i = 0;
		do {
			
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
						else  {
							array_push(_build, _value);	
						}
					}
					
					if (_j != -1) ds_stack_pop(_stack);
				} until (ds_stack_empty(_stack));
			}
			else {
				array_push(_build, _value);	
			}
		} until (++_i == _argSize);
		
		ds_stack_destroy(_stack);
		return _build;
	}
	
	return [];
}

#endregion

#region find


//					f = function(value, index, data)

/// @function		UNIT_arrFindJust(array, index, step, f, [data]);
function UNIT_arrFindJust(_array, _index, _step, _f, _data) {
	
	return UNIT_arrFind(_array, 
		_index,
		(_step > 0 ? max(array_length(_array), _index) : min(-1, _index)),
		_step, 
		_f, _data
	);
}

/// @function		UNIT_arrFindLimit(array, indexBegin, indexEnd, step, f, [data]);
function UNIT_arrFindLimit(_array, _index, _limit, _step, _f, _data) {
	
	_limit = clamp(_limit, -1, array_length(_array));
	
	var _diff = (_limit - _index);
	
	_step = abs(_step) * sign(_diff);
	_limit = _index + ceil(abs(_diff / _step)) * _step;
	
	return UNIT_arrFind(_array, 
		_index,
		_limit,
		_step, 
		_f, _data
	);
}

/// @function		UNIT_arrFindCount(array, index, count, step, f, [data]);
function UNIT_arrFindCount(_array, _index, _count, _step, _f, _data) {
	
	if (_count <= 0) return -1;
	
	return UNIT_arrFindLimit(_array, 
		_index,
		_index + _count * _step,
		_step, 
		_f, _data
	);
}

/// @function		UNIT_arrFind(array, index, limit, step, f, [data]);
function UNIT_arrFind(_array, _index, _limit, _step, _f, _data) {
	
	for (; _index != _limit; _index += _step) {
		
		if (_f(_array[_index], _index, _data)) return _index;
	}
	
	return -1;
}


//					better    = function(previos, next, data)
//					predicate = function(value, index, data)

/// @function		UNIT_arrFindBetterJust(array, index, step, better, [data_better], [predicate=true], [data_predicate]);
function UNIT_arrFindBetterJust(_array, _index, _step, _fbetter, _data_better, _predicate, _data_predicate) {
	
	return UNIT_arrFindBetter(_array,
		_index,
		(_step > 0 ? max(array_length(_array), _index) : min(-1, _index)),
		_step, 
		_fbetter, _data_better, _predicate, _data_predicate
	);
}

/// @function		UNIT_arrFindBetterLimit(array, indexBegin, indexLimit, step, better, [data_better], [predicate=true], [data_predicate]);
function UNIT_arrFindBetterLimit(_array, _index, _limit, _step, _fbetter, _data_better, _predicate, _data_predicate) {
	
	_limit = clamp(_limit, -1, array_length(_array));
	
	var _diff = (_limit - _index);
	
	_step = abs(_step) * sign(_diff);
	_limit = _index + ceil(abs(_diff / _step)) * _step;
	
	return UNIT_arrFindBetter(_array,
		_index,
		_limit,
		_step, 
		_fbetter, _data_better, _predicate, _data_predicate
	);
}

/// @function		UNIT_arrFindBetterCount(array, index, count, step, better, [data_better], [predicate=true], [data_predicate]);
function UNIT_arrFindBetterCount(_array, _index, _count, _step, _fbetter, _data_better, _predicate, _data_predicate) {
	
	if (_count <= 0) return -1;
	
	return UNIT_arrFindBetterLimit(_array,
		_index,
		_index + _count * _step,
		_step,
		_fbetter, _data_better, _predicate, _data_predicate
	);
}

/// @function		UNIT_arrFindBetter(array, index, limit, step, better, [data_better], [predicate=true], [data_predicate]);
function UNIT_arrFindBetter(_array, _index, _limit, _step, _fbetter, _data_better, _predicate, _data_predicate) {
	
	var _size = array_length(_array);
	if (_size > 0) {
		
		if (_index != _limit) {
			
			if (_size == 1) {
				var _value = _array[_index]; // generate-error
				return (_predicate == undefined || _predicate(_value, 0, _data_predicate) ? 0 : -1);
			}
			
			if (_predicate == undefined) {
				
				var _find_v = _array[_index];
				var _find_i = _index;
				var _value;
				
				for (_index += _step; _index != _limit; _index += _step) {
					
					_value = _array[_index];
					if (_fbetter(_find_v, _value, _data_better)) {
						
						_find_v = _value;
						_find_i = _index;
					}
				}
				
				return _find_i;
			}
			else {
				
				for (_index += _step; _index != _limit; _index += _step) {
					
					if (_predicate(_array[_index], _index, _data_predicate)) {
						
						var _find_v = _array[_index];
						var _find_i = _index;
						var _value;
						
						for (_index += _step; _index != _limit; _index += _step) {
							
							_value = _array[_index];
							if (_predicate(_value,  _index, _data_predicate) &&
								_fbetter(_find_v, _value, _data_better)) {
							
								_find_v = _value;
								_find_i = _index;
							}
						}
						
						return _find_i;
					}
				}
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

function UNIT_arrayHigher() {};

#endregion




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

#endregion

#region other

//					f = function(value, index, data)
/// @function		UNIT_arrForEach(array, f, [data]);
function UNIT_arrForEach(_array, _f, _data) {
	
	var _size = array_length(_array);
	for (var _i = 0; _i < _size; ++_i) 
		if (_f(_array[_i], _i, _data)) return;
}

//					valid = function(value, data)
/// @function		UNIT_arrSplit([valid=true], [data], ...args);
function UNIT_arrSplit(_valid, _data) {
	
	static _validTrue = method_get_index(function() {
		return true;
	});
	
	_valid ??= _validTrue;
	
	var _stack   = ds_stack_create();
	var _argSize = argument_count;
	var _build   = [];
	
	var _jsize, _j, _value;
	var _pack, _array;
	
	for (var _i = 2; _i < _argSize; ++_i) {
		
		_value = argument[_i];
		if (is_array(_value)) {
			
			ds_stack_push(_stack, [0, _value]);
			do {
				
				_pack = ds_stack_top(_stack);
				_array = _pack[1];
				_jsize = array_length(_array);
				
				for (_j = _pack[0]; _j < _jsize; ++_j) {
					
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

#endregion


#region __private

function UNIT_arrayHigher() {};

#endregion


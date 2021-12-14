

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
		
		var _i = 0, _j = -1, _value;
		do {
		
			_value = _array[_i];
			if (_f(_value, _i, _data))
				_array[@ ++_j] = _value;
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

#endregion


#region __private

function UNIT_arrayHigher() {};

#endregion



/*
sourse:
https://github.com/dicksonlaw583/LightweightDataStructures/blob/master/extensions/LightweightDataStructures/LightweightDataStructures.gml
*/

/*
	Если f_compare(a, b) вернёт true, то 'a' будет сдвинута влево (к началу контейнера)
*/

//					f_set     = function(data, index, value);
//					f_get     = function(data, index);
//					f_compare = function(a, b);
/// @function		UNIT_sort(data, reverse, sort_begin, sort_end, f_set, f_get, [f_compare=|>|]);
function UNIT_sort(_data, _reverse, _sort_begin, _sort_end, _set, _get, _compare) {
	
	static _def_compare = method_get_index(function(_x, _y) {
		return _x > _y;
	});
	
	if (_sort_end - _sort_begin < 2) return;
	if (_compare == undefined) _compare = _def_compare;
	
	var _stack = ds_stack_create();
	ds_stack_push(_stack, _sort_end, _sort_begin, __UNIT_sort_kernel);
	
	do {
		ds_stack_pop(_stack)(_stack, _data, _reverse, _set, _get, _compare);
	} until (ds_stack_empty(_stack));
	
	ds_stack_destroy(_stack);
}



#region __private

function __UNIT_sort_kernel(_stack, _data, _reverse, _set, _get, _compare) {
	
	var _begin = ds_stack_pop(_stack);
	var _end   = ds_stack_pop(_stack);
	
	var _span = _end - _begin;
	if (_span < 2) return;
	if (_span == 2) {
		
		var _value1 = _get(_data, _begin);
		var _value2 = _get(_data, _begin + 1);
		if (_reverse == _compare(_value1, _value2)) {
			
			_set(_data, _begin,     _value2);
			_set(_data, _begin + 1, _value1);
		}
		return;
	}
	
	var _halfSpan = _span div 2;
	var _middle   = _begin + _halfSpan;
	
	ds_stack_push(_stack,
		_middle, _end, _begin, __UNIT_sort_merger,
		_middle, _begin, __UNIT_sort_kernel,
		_end, _middle, __UNIT_sort_kernel,
	);
	
}

function __UNIT_sort_merger(_stack, _data, _reverse, _set, _get, _compare) {
	
	var _begin  = ds_stack_pop(_stack);
	var _end    = ds_stack_pop(_stack);
	var _middle = ds_stack_pop(_stack);
	
	var _i     = 0;
	var _j     = 0;
	var _iSize = _middle - _begin;
	var _jSize = _end - _middle;
	var _span  = _end - _begin;
	var _arr   = array_create(_span);
	
	var _value1, _value2;
	
	for (var _ii = 0; _ii < _span; ++_ii) {
		if (_i >= _iSize) {
			_arr[_ii] = _get(_data, _middle + _j);
			++_j;
		}
		else
		if (_j >= _jSize) {
			_arr[_ii] = _get(_data, _begin + _i);
			++_i;
		}
		else {
			
			_value1 = _get(_data, _begin + _i);
			_value2 = _get(_data, _middle + _j);
			
			if (_reverse == _compare(_value1, _value2)) {
				_arr[_ii] = _value2;
				++_j;
			}
			else {
				_arr[_ii] = _value1;
				++_i;
			}
		}
	}
	
	for (_ii = 0; _ii < _span; ++_ii) {
		
		_set(_data, _begin + _ii, _arr[_ii]);
	}
	
}

#endregion


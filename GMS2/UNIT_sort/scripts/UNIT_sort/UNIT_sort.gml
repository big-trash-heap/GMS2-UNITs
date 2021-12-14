
/*
sourse:
https://github.com/dicksonlaw583/LightweightDataStructures/blob/master/extensions/LightweightDataStructures/LightweightDataStructures.gml
*/

/// @function		UNIT_sort(data, reverse, sort_begin, sort_end, f_set, f_get, f_compare);
function UNIT_sort(_data, _reverse, _sort_begin, _sort_end, _set, _get, _compare) {
	
	if (_sort_end - _sort_begin < 2) return;
	
	var _queue = ds_queue_create();
	var _main = [
		_queue,
		_data,
		_reverse,
		_set,
		_get,
		_compare,
	];
	var _frame = [
		__UNIT_sort_kernel,
		_sort_begin,
		_sort_end,
	];
	ds_queue_enqueue(_queue, _frame);
	
	while (not ds_queue_empty(_queue)) {
		_frame = ds_queue_dequeue(_queue);
		_frame[__UNIT_SORT_FRAME.FUNCTION](_main, _frame);
	}
	
	ds_queue_destroy(_queue);
}


#region __private

enum __UNIT_SORT_FRAME {
	FUNCTION,
	BEGIN,
	END,
	MIDDLE,
};

enum __UNIT_SORT_MAIN {
	QUEUE,
	DATA,
	REVERSE,
	SET,
	GET,
	COMPARE,
};

function __UNIT_sort_kernel(_main, _frame) {
	
	var _begin = _frame[__UNIT_SORT_FRAME.BEGIN];
	var _end   = _frame[__UNIT_SORT_FRAME.END];
	
	var _span = _end - _begin;
	if (_span < 2) return;
	if (_span == 2) {
		
		var _data = _main[__UNIT_SORT_MAIN.DATA];
		var _get  = _main[__UNIT_SORT_MAIN.GET];
		
		var _value1 = _get(_data, _begin);
		var _value2 = _get(_data, _begin + 1);
		if (_main[__UNIT_SORT_MAIN.REVERSE] == _main[__UNIT_SORT_MAIN.COMPARE](_value1, _value2)) {
			
			var _set = _main[__UNIT_SORT_MAIN.SET];
			
			_set(_data, _begin,     _value2);
			_set(_data, _begin + 1, _value1);
		}
		return;
	}
	
	var _halfSpan = _span div 2;
	var _queue    = _main[__UNIT_SORT_MAIN.QUEUE];
	var _middle   = _begin + _halfSpan;
	
	ds_queue_enqueue(_queue, [
		__UNIT_sort_kernel,
		_begin,
		_middle,
	]);
	
	ds_queue_enqueue(_queue, [
		__UNIT_sort_kernel,
		_middle,
		_end,
	]);
	
	ds_queue_enqueue(_queue, [
		__UNIT_sort_merger,
		_begin,
		_end,
		_middle,
	]);
	
}

function __UNIT_sort_merger(_main, _frame) {
	
	var _begin   = _frame[__UNIT_SORT_FRAME.BEGIN];
	var _middle  = _frame[__UNIT_SORT_FRAME.MIDDLE];
	var _end     = _frame[__UNIT_SORT_FRAME.END];
	
	var _data    = _main[__UNIT_SORT_MAIN.DATA]; 
	var _set     = _main[__UNIT_SORT_MAIN.SET];
	var _get     = _main[__UNIT_SORT_MAIN.GET];
	var _compare = _main[__UNIT_SORT_MAIN.COMPARE];
	var _reverse = _main[__UNIT_SORT_MAIN.REVERSE];
	
	var _i = 0;
	var _j = 0;
	var _iSize = _middle - _begin;
	var _jSize = _end - _middle;
	var _ii    = -1;
	var _span  = _end - _begin;
	var _arr   = array_create(_span);
	
	var _value1, _value2;
	
	repeat (_span) {
		if (_i >= _iSize) {
			_arr[++_ii] = _get(_data, _middle + _j);
			++_j;
		}
		else
		if (_j >= _jSize) {
			_arr[++_ii] = _get(_data, _begin + _i);
			++_i;
		}
		else {
			
			_value1 = _get(_data, _begin + _i);
			_value2 = _get(_data, _middle + _j);
			
			if (_reverse == _compare(_value1, _value2)) {
				
				_arr[++_ii] = _value2;
				++_j;
			}
			else {
				
				_arr[++_ii] = _value1;
				++_i;
			}
		}
	}
	
	for (_i = 0; _i < _span; ++_i) {
		
		_set(_data, _begin + _i, _arr[_i]);
	}
	
}

#endregion



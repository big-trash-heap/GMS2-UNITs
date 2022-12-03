
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

//					better    = function(previos, next, data)
//					predicate = function(value, index, data)

/// @function		UNIT_algoBetter(seq_size, seq_get, seq, index, limit, step, better, [data_better], [predicate=true], [data_predicate]);
function UNIT_algoBetter(_seq_size, _seq_get, _seq, _index, _limit, _step, _fbetter, _data_better, _predicate, _data_predicate) {
	
	if (_index != _limit) {
		
		if (_seq_size(_seq) == 1) {
			var _value = _seq[_index];
			return (_predicate == undefined || _predicate(_value, 0, _data_predicate) ? 0 : -1);
		}
		
		if (_predicate == undefined) {
				
			var _find_v = _seq[_index];
			var _find_i = _index;
			var _value;
				
			for (_index += _step; _index != _limit; _index += _step) {
					
				_value = _seq[_index];
				if (_fbetter(_find_v, _value, _data_better)) {
						
					_find_v = _value;
					_find_i = _index;
				}
			}
			
			return _find_i;
		}
		else {
			
			for (_index += _step; _index != _limit; _index += _step) {
				
				if (_predicate(_seq[_index], _index, _data_predicate)) {
					
					var _find_v = _seq[_index];
					var _find_i = _index;
					var _value;
					
					for (_index += _step; _index != _limit; _index += _step) {
						
						_value = _seq[_index];
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
	
	return -1;
}


/// sample

function UNIT_algoBetterJust(_seq_size, _seq_get, _seq, _fbetter, _data_better, _predicate, _data_predicate) {
	
	return UNIT_algoBetter(_seq_size, _seq_get, _seq, 0, _seq_size(_seq), 1, _fbetter, _data_better, _predicate, _data_predicate);
}

function UNIT_algoBetterStep(_seq_size, _seq_get, _seq, _index, _step, _fbetter, _data_better, _predicate, _data_predicate) {
	
	return UNIT_algoBetter(_seq_size, _seq_get, _seq,
		_index,
		(_step > 0 ? max(_seq_size(_seq), _index) : min(-1, _index)),
		_step, 
		_fbetter, _data_better, _predicate, _data_predicate
	);
}

function UNIT_algoBetterLimit(_seq_size, _seq_get, _seq, _index, _limit, _step, _fbetter, _data_better, _predicate, _data_predicate) {
	
	_limit = clamp(_limit, -1, _seq_size(_seq));
	var _diff = (_limit - _index);
	
	_step = abs(_step) * sign(_diff);
	_limit = _index + ceil(abs(_diff / _step)) * _step;
	
	return UNIT_algoBetter(_seq_size, _seq_get, _seq,
		_index,
		_limit,
		_step, 
		_fbetter, _data_better, _predicate, _data_predicate
	);
}

function UNIT_algoBetterGap(_seq_size, _seq_get, _seq, _index, _count, _step, _fbetter, _data_better, _predicate, _data_predicate) {
	
	if (_count <= 0) return -1;
	
	return UNIT_algoBetterLimit(_seq_size, _seq_get, _seq,
		_index,
		_index + _count * _step,
		_step,
		_fbetter, _data_better, _predicate, _data_predicate
	);
}

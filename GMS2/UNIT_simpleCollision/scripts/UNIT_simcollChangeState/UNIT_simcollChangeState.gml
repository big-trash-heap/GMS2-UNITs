
function UNIT_simcollChangeState(_instance, _struct, _f, _data) {
	var _keys = variable_struct_get_names(_struct), _key;
	var _size = array_length(_keys), _i;
	var _previous = {};
	
	var _instRef;
	with (_instance) {
	
	_instRef = self;
	
	}
	
	for (_i = 0; _i < _size; ++_i) {
		
		_key = _keys[_i];
		
		if (variable_struct_exists(_instRef, _key)) {
			_previous[$ _key] = _instRef[$ _key];
		}
		
		_instRef[$ _key] = _struct[$ _key];
	}
	
	var _result = _f(_instance, _data);
	
	for (_i = 0; _i < _size; ++_i) {
		
		_key = _keys[_i];
		
		if (variable_struct_exists(_previous, _key)) {
			_instRef[$ _key] = _previous[$ _key];
		}
		else {
			variable_struct_remove(_instRef, _key);
		}
		
		_instRef[$ _key] = _struct[$ _key];
	}
	
	return _result;
}

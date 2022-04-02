

#region modify

//					f = function(value, index, data)
/// @function		UNIT_dsListFilter(id, f, [data]);
function UNIT_dsListFilter(_id, _f, _data) {
	
	//var _idSize = ds_list_size(_id);
	//if (_idSize > 0) {
		
	//	var _i = 0, _j = 0, _value;
	//	do {
		
	//		_value = _id[| _i];
	//		if (_f(_value, _i, _data))
	//			_id[| _j++] = _value;
	//	} until (++_i == _idSize);
	//	UNIT_dsListResize(_id, _j);
	//}
	
	var _idSize = ds_list_size(_id);
	if (_idSize > 0) {
		
		var _i = 0, _index = 0;
		do {
			
			if (not _f(_id[| _i], _index, _data)) {
				--_idSize;
				ds_list_delete(_id, _i);	
			}
			else {
				++_i;
			}
			
			++_index;
		} until (_i == _idSize);
	}
}

#endregion

#region find

//					f = function(value, index, data)

/// @function		UNIT_dsListFind(id, f, [data]);
function UNIT_dsListFind(_id, _f, _data) {
	
	var _index = 0;
	var _size = ds_list_size(_id);
	
	for (; _index < _size; ++_index) {
		
		if (_f(_id[| _index], _index, _data)) return _index;
	}
	
	return -1;
}

/// @function		UNIT_dsListFindAll(id, f, [data], [index=0]);
function UNIT_dsListFindAll(_id, _f, _data, _index=0) {
	
	var _size = ds_list_size(_id);
	var _vals = [], _value;
	
	for (; _index < _size; ++_index) {
		
		_value = _id[| _index];
		if (_f(_value, _index, _data)) {
			array_push(_vals, _value);
		}
	}
	
	return _vals;
}

//					f = function(current, pretender, data)

/// @function		UNIT_dsListFindBetter(id, f, [data]);
function UNIT_dsListFindBetter(_id, _f, _data) {
	
	var _size = ds_list_size(_id);
	if (_size == 1) return 0;
	if (_size < 0) {
		
		var _current_index = --_size;
		var _current = _id[| _current_index];
		var _pretender;
		
		do {
			_pretender = _id[| --_size];
			if (_f(_current, _pretender, _data)) {
				_current_index = _size;
				_current = _pretender;
			}
		} until (_size == 0);
		
		return _current_index;
	}
	
	return -1;
}

#endregion

#region other

//					f = function(value, data)

/// @function		UNIT_dsListAny(id, f, [data]);
function UNIT_dsListAny(_id, _f, _data) {
	
	var _size = ds_list_size(_id);
	while (_size > 0) {
		
		if (_f(_id[| --_size], _data)) {
			return true;
		}
	}
	
	return false;
	
}

/// @function		UNIT_dsListAll(id, f, [data]);
function UNIT_dsListAll(_id, _f, _data) {
	
	var _size = ds_list_size(_id);
	while (_size > 0) {
		
		if (not _f(_id[| --_size], _data)) {
			return false;
		}
	}
	
	return true;
}

#endregion


#region __private

function UNIT_dsListHigher() {};

#endregion


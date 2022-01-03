

#region modify

//					f = function(struct, key, data)
/// @function		UNIT_structForEach(struct, f, [data]);
function UNIT_structForEach(_struct, _f, _data) {
    
    var _keys = variable_struct_get_names(_struct);
    var _size = array_length(_keys);
	while (_size > 0) _f(_struct, _keys[--_size], _data);
	
}

//					f = function(struct, key, data)
/// @function		UNIT_structFind(struct, f, [data]);
function UNIT_structFind(_struct, _f, _data) {
    
    var _keys = variable_struct_get_names(_struct);
    var _size = array_length(_keys);
	while (_size > 0) {
		if (_f(_struct, _keys[--_size], _data)) return _keys[_size];
	}
	
    return undefined;
}

#endregion


#region __private

function UNIT_structHigher() {};

#endregion


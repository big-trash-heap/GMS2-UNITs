
//					f = function(value, index, data)
/// @function		UNIT_dsListFilter(array, f, [data]);
function UNIT_dsListFilter(_id, _f, _data) {
	
	var _idSize = ds_list_size(_id);
	if (_idSize > 0) {
		
		var _i = 0, _j = 0, _value;
		do {
		
			_value = _id[| _i];
			if (_f(_value, _i, _data))
				_id[| _j++] = _value;
		} until (++_i == _idSize);
		UNIT_dsListResize(_id, _j);
	}
}


#region __private

function UNIT_dsListHigher() {};

#endregion


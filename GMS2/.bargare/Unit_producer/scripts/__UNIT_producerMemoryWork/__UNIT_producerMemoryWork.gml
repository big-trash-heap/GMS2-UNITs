

enum __UNIT_PRODUCER_MAP { _MAP, _REF };

function __UNIT_producerOrderList() {
	static _list = ds_list_create();
	return _list;
}

function __UNIT_producerOrderNewMap(_producer) {
	static _list = __UNIT_producerOrderList();
	
	var _newmap = undefined;
	var _size = ds_list_size(_list);
	
	for (var _i = 0, _value; _i < _size; ++_i) {
		
		_value = _list[| _i];
		if (not weak_ref_alive(_value[__UNIT_PRODUCER_MAP._REF])) {
			
			_newmap = _value;
			_newmap[@ __UNIT_PRODUCER_MAP._REF] = weak_ref_create(_producer);
			ds_map_clear(_newmap[@ __UNIT_PRODUCER_MAP._MAP]);
			
			++_i;
			break;
		}
	}
	
	while (_i < _size) {
		
		_value = _list[| _i];
		if (not weak_ref_alive(_value[__UNIT_PRODUCER_MAP._REF])) {
			
			ds_map_destroy(_value[@ __UNIT_PRODUCER_MAP._MAP]);
			ds_list_delete(_list, _i);
			
			--_size;
		}
		else {
			++_i;	
		}
	}
	
	if (is_undefined(_newmap)) {
		
		_newmap = [ds_map_create(), weak_ref_create(_producer)];
		ds_list_add(_list, _newmap);
	}
	
	return _newmap[__UNIT_PRODUCER_MAP._MAP];
}

function __UNIT_producerMemoryWork() {};

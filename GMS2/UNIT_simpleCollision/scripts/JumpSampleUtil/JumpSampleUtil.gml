function cc_find(_findFirst) {
	
	static _method = function(_speed, _objects) {
		
		var _size = array_length(_objects);
		var _colobject;
		var _isCollision;
		
		do {
			_colobject = self.find(_speed, _objects[--_size]);
			_isCollision = (_colobject != noone);
		} until (_isCollision || _size == 0);
		
		if (UNIT_PREPROCESSOR_SIMCOLL_JUMPSAMPLE_GETID) {
		
		if (_isCollision) global.UNIT_simcollId = _colobject;
		
		}
		return _isCollision;
	}
	
	return method({ find: _findFirst }, _method);
}

function cc_findWithFilter(_findAll, _check, _data) {
	
	static _method = function(_speed, _objects) {
		
		var _size = array_length(_objects);
		var _list = ds_list_create();
		var _listSize, _instance;
		
		do {
			self.find(_speed, _objects[--_size], _list);
			
			_listSize = ds_list_size(_list);
			if (_listSize > 0) {
				
				do {
					_instance = _list[| --_listSize];
					if (self.check(_instance, self.data)) {
						
						if (UNIT_PREPROCESSOR_SIMCOLL_JUMPSAMPLE_GETID) {
						
						global.UNIT_simcollId = _instance;
						
						}
						
						return true;
					}
				} until (_listSize == 0);
				
				ds_list_clear(_list);
			}
		} until (_size == 0);
		
		ds_list_destroy(_list);
		return false;
	}
	
	return method({ find: _findAll, check: _check, data: _data }, _method);
}

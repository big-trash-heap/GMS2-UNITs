
///					f = function(temp_instance, data);

/// @function		UNIT_simcollImitationJust(f, [data]);
function UNIT_simcollImitationJust(_f, _data) {
	var _instance = instance_create_depth(0, 0, 0, __UNIT_simcollImitation);
	var _result   = _f(_instance, _data);
	if (instance_exists(_instance)) {
		instance_destroy(_instance);	
	}
	return _result;
}

/// @function		UNIT_simcollImitationUnit(f, [data]);
function UNIT_simcollImitationUnit(_f, _data) {
	
	static _instance = noone;
	static _recursion = false;
	
	if (_recursion) {
		return UNIT_simcollImitationJust(_f, _data);
	}
	
	if (not instance_exists(_instance)) {
		_instance = instance_create_depth(0, 0, 0, __UNIT_simcollImitation);
		_instance.persistent = true;
	}
	else {
		
		var _active = false;
		with (_instance) {
		
		_active = true;
		
		}
		
		if (not _active) {
			
			instance_destroy(_instance);
			_instance = instance_create_depth(0, 0, 0, __UNIT_simcollImitation);
			_instance.persistent = true;
		}
	}
	
	_recursion = true;
	var _result = _f(_instance, _data);
	_recursion = false;
	return _result;
}

/// @function		UNIT_simcollImitationUnitUnsafe(f, [data]);
function UNIT_simcollImitationUnitUnsafe(_f, _data) {
	
	static _instance = function() {
		var _instance = instance_create_depth(0, 0, 0, __UNIT_simcollImitation);
		_instance.persistent = true;
		return _instance;
	}();
	
	return _f(_instance, _data);
}


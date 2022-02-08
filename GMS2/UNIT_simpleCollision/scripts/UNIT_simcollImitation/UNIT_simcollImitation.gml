
///					f = function(instance, data);

/// @function		UNIT_simcollImitation(f, [data]);
function UNIT_simcollImitation(_f, _data) {
	var _instance = instance_create_depth(0, 0, 0, __UNIT_simcollImitation);
	var _result   = _f(_instance, _data);
	if (instance_exists(_instance)) {
		instance_destroy(_instance);	
	}
	return _instance;
}

/// @function		UNIT_simcollSprite(f, [data], [x], [y], [sprite], [subimg], [xscale], [yscale], [angle]);
function UNIT_simcollSprite(_f, _data) {
	static _keys = __UNIT_simcollSpriteKeys();
	
	static _recursion = false;
	
	var _instance;
	var _reset;
	
	if (_recursion) {
		_instance = instance_create_depth(0, 0, 0, __UNIT_simcollImitation);
		_reset = false;
	}
	else {
		with (__UNIT_simcollImitationUnit) {
		
		_instance = id;
		break;
		
		}
		
		if (_instance == noone) {
			instance_destroy(__UNIT_simcollImitationUnit);
			_instance = instance_create_depth(0, 0, 0, __UNIT_simcollImitationUnit);
		}
		
		_recursion = true;
		_reset = true;
	}
	
	var _argSize = argument_count, _val;
	while (_argSize > 2) {
		_val = argument[--_argSize];
		if (not is_undefined(_val)) {
			variable_instance_set(_instance, _keys[_argSize - 2], _val);
		}
	}
	
	var _result = _f(_instance, _data);
	if (_reset) {
		_recursion = false;
	}
	else
	if (instance_exists(_instance)) {
		instance_destroy(_instance);	
	}
	
	return _result;
}

/// @function		UNIT_simcollSpriteUnsafe(f, [data], [x], [y], [sprite], [subimg], [xscale], [yscale], [angle]);
function UNIT_simcollSpriteUnsafe(_f, _data) {
	static _keys = __UNIT_simcollSpriteKeys();
	static _instance = function() {
		var _instance = instance_create_depth(0, 0, 0, __UNIT_simcollImitation);
		_instance.persistent = true;
		return _instance;
	}();
	
	var _argSize = argument_count, _val;
	while (_argSize > 2) {
		_val = argument[--_argSize];
		if (not is_undefined(_val)) {
			variable_instance_set(_instance, _keys[_argSize - 2], _val);
		}
	}
	
	return _f(_instance, _data);
}


#region __private

function __UNIT_simcollSpriteKeys() {
	static _keys = [
		"x",
		"y",
		"sprite",
		"image",
		"image_xscale",
		"image_yscale",
		"image_angle",
	];
	return _keys;
}

#endregion


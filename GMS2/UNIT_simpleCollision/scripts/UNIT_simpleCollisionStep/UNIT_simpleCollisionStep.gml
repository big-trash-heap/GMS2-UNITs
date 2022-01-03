
// check = function(inst, data)

/// @function		UNIT_simcollStepW(x, y, object, speed, [check], [data]);
function UNIT_simcollStepW(_x, _y, _object, _speed, _check, _data) {
	
	static _list = __UNIT_simpleCollisionStep();
	
	static _find_left = function(_left, _inst) {
		
		return min(_left, _inst.bbox_left);
	}
	
	static _find_right = function(_right, _inst) {
		
		return max(_right, _inst.bbox_right);
	}
	
	ds_list_clear(_list);
	
	var _size;
	if (_speed < 0) {
		
		_size = collision_rectangle_list(
			self.bbox_left + _speed, self.bbox_top, 
			self.bbox_right, self.bbox_bottom, 
			_object, false, true, _list, false);
	}
	else {
		
		_size = collision_rectangle_list(
			self.bbox_left, self.bbox_top, 
			self.bbox_right + _speed, self.bbox_bottom, 
			_object, false, true, _list, false);
	}
	
	if (_size) {
		
		var _find_f, _find_v, _inst;
		if (_speed < 0) {
			
			_find_f = _find_right;
			_find_v = -infinity;
		}
		else {
			
			_find_f = _find_left;
			_find_v = infinity;
		}
		
		if (!is_undefined(_check)) {
			
			do {
				_inst = _list[| --_size];
				if (_check(_inst, _data)) _find_v = _find_f(_find_v, _inst);
			} until (_size == 0);
			
			if (!is_infinity(_find_v)) {
				
				if (_speed < 0) 
					global.UNIT_simcollDist = (_find_v - self.bbox_left + 1);
				else
					global.UNIT_simcollDist = (_find_v - self.bbox_right - 1);
				
				return true;
			}
		}
		else {
			
			do {
				_find_v = _find_f(_find_v, _list[| --_size]);
			} until (_size == 0);
			
			if (_speed < 0) 
				global.UNIT_simcollDist = (_find_v - self.bbox_left + 1);
			else
				global.UNIT_simcollDist = (_find_v - self.bbox_right - 1);
			
			return true;
		}
	}
	
	global.UNIT_simcollDist = _speed;
	return false;
}

/// @function		UNIT_simcollStepH(x, y, object, speed, [check], [data]);
function UNIT_simcollStepH(_x, _y, _object, _speed, _check, _data) {
	
	static _list = __UNIT_simpleCollisionStep();
	
	static _find_top = function(_top, _inst) {
		
		return min(_top, _inst.bbox_top);
	}
	
	static _find_bottom = function(_bottom, _inst) {
		
		return max(_bottom, _inst.bbox_bottom);
	}
	
	ds_list_clear(_list);
	
	var _size;
	if (_speed < 0) {
		
		_size = collision_rectangle_list(
			self.bbox_left, self.bbox_top + _speed, 
			self.bbox_right, self.bbox_bottom, 
			_object, false, true, _list, false);
	}
	else {
		
		_size = collision_rectangle_list(
			self.bbox_left, self.bbox_top, 
			self.bbox_right, self.bbox_bottom + _speed, 
			_object, false, true, _list, false);
	}
	
	if (_size) {
		
		var _find_f, _find_v, _inst;
		if (_speed < 0) {
			
			_find_f = _find_bottom;
			_find_v = -infinity;
		}
		else {
			
			_find_f = _find_top;
			_find_v = infinity;
		}
		
		if (!is_undefined(_check)) {
			
			do {
				_inst = _list[| --_size];
				if (_check(_inst, _data)) _find_v = _find_f(_find_v, _inst);
			} until (_size == 0);
			
			if (!is_infinity(_find_v)) {
				
				if (_speed < 0) 
					global.UNIT_simcollDist = (_find_v - self.bbox_top + 1);
				else
					global.UNIT_simcollDist = (_find_v - self.bbox_bottom - 1);
				
				return true;
			}
		}
		else {
			
			do {
				_find_v = _find_f(_find_v, _list[| --_size]);
			} until (_size == 0);
			
			if (_speed < 0) 
				global.UNIT_simcollDist = (_find_v - self.bbox_top + 1);
			else
				global.UNIT_simcollDist = (_find_v - self.bbox_bottom - 1);
			
			return true;
		}
	}
	
	global.UNIT_simcollDist = _speed;
	return false;
}


#region __private

function __UNIT_simpleCollisionStep() {
	static _list = ds_list_create();
	return _list;
}

function UNIT_simpleCollisionStep() {};

#endregion


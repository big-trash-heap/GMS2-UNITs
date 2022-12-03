
#macro UNIT_PREPROCESSOR_GRID_ENABLE_CHECK_BOUND	true

/// @function		UNIT_Grid([w=0], [h=0], [value=0]);
function UNIT_Grid(_w=0, _h=0, _value=0) constructor {
	
	#region __private
	
	self.__w = max(0, _w);
	self.__h = max(0, _h);
	
	var _s = self.__w * self.__h;
	if (_s > 0)
		self.__a = array_create(_s, _value);
	
	#endregion
	
	static resize = function(_w=self.__w, _h=self.__h, _value=0) {
		
		_w = max(0, _w);
		_h = max(0, _h);
		
		var _s = _w * _h;
		if (_s > 0) {
			
			var _sw = min(self.__w, _w);
			var _sh = min(self.__h, _h);
			
			var _a = array_create(_s, _value);
			var _i, _j;
			for (_i = 0; _i < _sw; ++_i)
				for (_j = 0; _j < _sh; ++_j)
					_a[@ _j * _w + _i] = self.__a[_j * self.__w + _i];
			
			self.__a = _a;
		}
		else {
			self.__a = undefined;
		}
		
		self.__w = _w;
		self.__h = _h;
	}
	
	static getWidth = function() { return self.__w; };
	static getHeight = function() { return self.__h; };
	
	static get = function(_x, _y) {
		if (UNIT_PREPROCESSOR_GRID_ENABLE_CHECK_BOUND) {
		
		if (!self.exists(_x, _y)) show_error(__UNIT_GRID_ERROR, true);
		
		}
		
		return self.__a[_y * self.__w + _x];
	}
	
	static set = function(_x, _y, _value) {
		if (UNIT_PREPROCESSOR_GRID_ENABLE_CHECK_BOUND) {
		
		if (!self.exists(_x, _y)) show_error(__UNIT_GRID_ERROR, true);
		
		}
		
		self.__a[@ _y * self.__w + _x] = _value;
	}
	
	static exists = function(_x, _y) {
		return (point_in_rectangle(_x, _y, 0, 0, self.__w - 1, self.__h - 1) > 0);	
	}
	
	static existsRegion = function(_x1, _y1, _x2, _y2) {
		return (rectangle_in_rectangle(_x1, _y1, _x2, _y2, 0, 0, self.__w - 1, self.__h - 1) > 0);
	}
	
	// f = f(grid, x, y, data)
	static forEach = function(_f, _data) {
		var _i, _j;
		for (_i = 0; _i < self.__w; ++_i) {
			for (_j = 0; _j < self.__h; ++_j)
				if (_f(self, _i, _j, _data)) return;
		}
	}
	
	// f = f(grid, x, y, data)
	static forRegion = function(_x1, _y1, _x2, _y2, _f, _data) {
		var _yy;
		for (; _x1 <= _x2; ++_x1) {
			for (_yy = _y1; _yy <= _y2; ++_yy)
				if (_f(self, _x1, _yy, _data)) return;
		}
	}
	
	static clear = function(_value=0) {
		if (self.__a == undefined) return;
		var _size = array_length(self.__a);
		while (_size > 0) self.__a[--_size] = _value;
	}
	
	static toString = function() {
		return ("UNIT::grid<" + string(self.__w) + ", " + string(self.__h) + ">::" + instanceof(self));	
	}
	
}


#region __private

#macro __UNIT_GRID_ERROR "UNIT::grid -> выход за границу"

#endregion


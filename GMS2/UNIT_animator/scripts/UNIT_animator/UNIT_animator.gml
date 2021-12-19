
enum UNIT_ANIMATOR_ACTION { _STOP, _AWAIT, _NEXT };
enum UNIT_ANIMATOR_CODE   { _BREAK = -1, _STOP, _CALL };

function UNIT_Animator(_f, _data, _super) constructor {
	
	#region __private
	
	if (_f != undefined) _f = [_f, _data];
	
	self.__super          = _super;
	self.__frames         = [4, 0, [], _f];
	self.__point_size     = 0;
	
	self.__render_run     = 0;
	self.__render_actions = undefined;
	
	self.__loop           = false;
	
	static __next = function() {
		
		self.__render_actions = undefined;
		
		var _after = self.__frames[self.__render_run + 2];
		var _size  = array_length(_after) div 2;
		for (var _i = 0, _j; _i < _size; ++_i) {
			_j = _i * 2;
			if (_after[_j](self, _after[_j + 1])) {
				self.__render_run = UNIT_ANIMATOR_CODE._BREAK;
				return UNIT_ANIMATOR_CODE._BREAK;
			}
		}
		
		_size = self.__frames[self.__render_run] + self.__frames[self.__render_run + 1];
		self.__render_run = (
			_size < array_length(self.__frames)
			? _size
			: -2
		);
		
		return UNIT_ANIMATOR_CODE._CALL;
	}
	
	static __tick = function() {
		
		if (self.__render_run < 0) {
			
			if (self.__render_run == UNIT_ANIMATOR_CODE._BREAK) return UNIT_ANIMATOR_CODE._BREAK;
			if (not self.__loop)								return UNIT_ANIMATOR_CODE._STOP;
			
			self.__render_run = 0;
		}
		
		if (is_undefined(self.__render_actions)) {
				
			var _first = self.__frames[self.__render_run + 3];
			if (_first != undefined) {
				if (_first[0](self, _first[1])) {
					self.__render_run = UNIT_ANIMATOR_CODE._BREAK;
					return UNIT_ANIMATOR_CODE._BREAK;
				}
			}
				
			var _size = self.__frames[self.__render_run + 1];
			if (_size == 0)
				return self.__next();
				
			self.__render_actions = array_create(_size);
			array_copy(self.__render_actions, 0, self.__frames, self.__frames[self.__render_run], _size);
		}
			
		var _next = true;
		var _size = array_length(self.__render_actions);
		var _i = 0, _j = 0, _value;
		do {
				
			_value = self.__render_actions[_i];
			if (_value[0]) {
					
				if (_value[1](self, _value[2])) {
					
					self.__render_run = UNIT_ANIMATOR_CODE._BREAK;
					self.__render_actions = undefined;
					return UNIT_ANIMATOR_CODE._BREAK;
				}
					
				self.__render_actions[_j++] = _value;
			}
			else {
				switch (_value[1](self, _value[2])) {
					
				case UNIT_ANIMATOR_ACTION._NEXT:
					break;
					
				case UNIT_ANIMATOR_ACTION._STOP:
					self.__render_run = UNIT_ANIMATOR_CODE._BREAK;
					self.__render_actions = undefined;
					return UNIT_ANIMATOR_CODE._BREAK;
					break;
					
				default:
					_next = false;
					self.__render_actions[_j++] = _value;
					break;
					
				}
			}
			
			if (is_undefined(self.__render_actions)) return UNIT_ANIMATOR_CODE._CALL;
		} until (++_i == _size);
			
		if (_next) return self.__next();
		array_resize(self.__render_actions, _j);
			
		return UNIT_ANIMATOR_CODE._CALL;
	}
	
	#endregion
	
	static add_frame = function(_f, _data) {
		
		if (_f != undefined) _f = [_f, _data];
		
		self.__point_size = array_length(self.__frames);
		array_push(self.__frames, self.__point_size + 4, 0, [], _f);
		
		return self;
	}
	
	static add_action = function(_f, _data) {
		
		self.__frames[self.__point_size + 1] += 1;
		array_push(self.__frames, [false, _f, _data]);
		
		return self;
	}
	
	static add_await = function(_f, _data) {
		
		self.__frames[self.__point_size + 1] += 1;
		array_push(self.__frames, [true, _f, _data]);
		
		return self;
	}
	
	static add_after = function(_f, _data) {
		
		array_push(self.__frames[self.__point_size + 2], _f, _data);
		
		return self;
	}
	
	
	static _tick = self.__tick;
	
	static tick = function() {
		
		if (variable_struct_exists(self, "__save")) show_error("", true);
		self.__save = undefined;
		
		var _result = self.__tick();
		variable_struct_remove(self, "__save");
		return _result;
	}
	
	static code = function() {
		
		if (self.__render_run < 0) {
				
			if (self.__render_run == UNIT_ANIMATOR_CODE._BREAK) return UNIT_ANIMATOR_CODE._BREAK;
			if (not self.__loop)								return UNIT_ANIMATOR_CODE._STOP;
		}
		
		return UNIT_ANIMATOR_CODE._CALL;
	}
	
	
	static get_super = function() {
		return self.__super;
	}
	
	static set_super = function(_super) {
		self.__super = _super;
		return self;
	}
	
	static get_loop = function() {
		return self.__loop;	
	}
	
	static set_loop = function(_loop) {
		self.__loop = _loop;
		return self;
	}
	
	
	static replay = function() {
		
		self.__render_run     = 0;
		self.__render_actions = undefined;
		
		return self;
	}
	
}


#region __private

function UNIT_animator() {};

#endregion


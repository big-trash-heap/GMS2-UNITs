
/*
	Данный класс предполагает:
	1. Экземпляр класса будет использован 1 раз, или будет зациклен (loop)
	2. Экземпляр класса не будет модифицироватся во время его использования (tick)
	3. Вы не будете использовать UNIT_PREPROCESSOR_ANIMATOR_EXTEND_CODE (_replay)
	4. Вы не будете вызывать tick при вызове tick (в рамках одного экземпляра)
	5. Вы не будете копировать данный экземпляр (clone, UNIT_Animator(clone))
*/

#macro UNIT_PREPROCESSOR_ANIMATOR_ENABLE_CLONE	true

#macro UNIT_PREPROCESSOR_ANIMATOR_EXTEND_CODE	false
#macro UNIT_PREPROCESSOR_ANIMATOR_ERROR_TICK	true
#macro UNIT_PREPROCESSOR_ANIMATOR_LOG			true

enum UNIT_ANIMATOR_ACTION { _STOP,       _AWAIT, _NEXT };
enum UNIT_ANIMATOR_CODE   { _BREAK = -1, _STOP,  _CALL };

//					f = f(animator, data)
/// @function		UNIT_Animator([f], [data], [super=undefined], [loop=false]);
function UNIT_Animator() constructor {
	
	#region init
	
	if (argument_count >= 1 && instanceof(argument[0]) == "__UNIT_Animator") {
		
		var _wrap = argument[0];
		
		self.super            = _wrap.super;
		self.__frames         = _wrap.__frames;
		self.__point_size     = _wrap.__point_size;
		self.__loop           = _wrap.__loop;   
		self.__render_run     = _wrap.__render_run;
		self.__render_actions = _wrap.__render_actions;
	}
	else {
		
		var _f     = undefined;
		var _super = undefined;
		var _loop  = false;
		if (argument_count > 0) {
		
			if (argument_count > 1) {
				
				_f = [argument[0], argument[1]];
				if (argument_count > 2) {
					
					_super = argument[2];
					if (argument_count > 3) {
						
						_loop = argument[3];
					}
				}
			}
			else {
				_f = [argument[0], undefined];	
			}
		}
		
		self.super            = _super;
		self.__frames         = [4, 0, [], _f];
		self.__point_size     = 0;
		self.__loop           = _loop;
		self.__render_run     = 0;
		self.__render_actions = undefined;
	}
	
	#endregion
	
	#region __private
	
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
			
			if (UNIT_PREPROCESSOR_ANIMATOR_EXTEND_CODE) {
			
			if (is_undefined(self.__render_actions)) return UNIT_ANIMATOR_CODE._CALL;
			
			}
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
	
	
	static tick = function() {
		
		if (UNIT_PREPROCESSOR_ANIMATOR_ERROR_TICK) {
		
		if (variable_struct_exists(self, "__save")) show_error("UNIT::animator -> нельзя вызывать tick во время вызова tick", true);
		self.__save = undefined;
		
		var _result = self.__tick();
		variable_struct_remove(self, "__save");
		return _result;
		
		}
		else {
			
		return self.__tick();
		
		}
	}
	
	static code = function() {
		
		if (self.__render_run < 0) {
				
			if (self.__render_run == UNIT_ANIMATOR_CODE._BREAK) return UNIT_ANIMATOR_CODE._BREAK;
			if (not self.__loop)								return UNIT_ANIMATOR_CODE._STOP;
		}
		
		return UNIT_ANIMATOR_CODE._CALL;
	}
	
	
	static get_super = function() {
		return self.super;
	}
	
	static set_super = function(_super) {
		self.super = _super;
		return self;
	}
	
	static get_loop = function() {
		return self.__loop;	
	}
	
	static set_loop = function(_loop) {
		self.__loop = _loop;
		return self;
	}
	
	
	static _replay = function() {
		
		if (not UNIT_PREPROCESSOR_ANIMATOR_EXTEND_CODE) {
		
		show_error("UNIT::animator -> для работы функции UNIT_Animator._replay включите UNIT_PREPROCESSOR_ANIMATOR_REPLAY", true);
		
		}
		else {
		
		if (UNIT_PREPROCESSOR_ANIMATOR_LOG) {
		
		show_debug_message("UNIT::animator -> UNIT_PREPROCESSOR_ANIMATOR_EXTEND_CODE -> UNIT_Animator._replay является не безопасной функцией");
		
		}
		
		self.__render_run     = 0;
		self.__render_actions = undefined;
		
		return self;
		
		}
	}
	
	static clone = function(_stateSave=false) {
		
		if (UNIT_PREPROCESSOR_ANIMATOR_ENABLE_CLONE) {
		
		var _wrap = new __UNIT_Animator();
		var _obj  = self;
		
		with (_wrap) {
		
		if (UNIT_PREPROCESSOR_ANIMATOR_LOG) {
		
		show_debug_message("UNIT::animator -> клонирование экземпляра UNIT_Animator не является безопасным");
		
		if (_stateSave)
		show_debug_message("UNIT::animator -> клонирование экземпляра UNIT_Animator с настройкой stateSave=true, крайне не безопасна");
		
		}
		
		self.super = _obj.super;
		
		var _size = array_length(_obj.__frames);
		
		self.__point_size = _obj.__point_size;
		self.__loop       = _obj.__loop;
		self.__frames     = array_create(_size);
		
		array_copy(self.__frames, 0, _obj.__frames, 0, _size);
		
		var _after_index = self.__point_size + 2;
		var _after       = self.__frames[_after_index];
		_size		     = array_length(_after);
		var _after_new   = array_create(_size);
		
		array_copy(_after_new, 0, _after, 0, _size);
		
		self.__frames[_after_index] = _after_new;
		
		if (_stateSave) {
			
			self.__render_run     = _obj.__render_run;
			self.__render_actions = undefined;
			
			var _actions = _obj.__render_actions;
			if (_actions != undefined) {
				
				_size                 = array_length(_actions);
				self.__render_actions = array_create(_actions);
				
				array_copy(self.__render_actions, 0, _actions, 0, _size);
			}
		}
		else {
			
			self.__render_run     = 0;
			self.__render_actions = undefined;
		}
		
		}
		
		return new UNIT_Animator(_wrap);
		
		}
		else {
		
		show_error("UNIT::animator -> клонирования экземпляра запрещено, включите UNIT_PREPROCESSOR_ANIMATOR_ENABLE_CLONE", true);
		
		}
	}
	
}


#region __private

function UNIT_animator() {};

function __UNIT_Animator() constructor {};

#endregion




/*
	Настройки работы функций
	(смотри в UNIT_simpleCollisionMove)
*/

// Общие настройки
															// сохранения id объекта, с которым было обнаруженно столкновение в последний раз
															// записывается global.UNIT_simcollId
#macro UNIT_PREPROCESSOR_SIMPLE_COLLISION_JUMPSAMPLE_GETID	false

// Настройки UNIT_simcollJumpLine
															// проверка ошибочных ситуаций
															// из-за погрешности collision_line, иногда результат UNIT_simcollJumpLine оказывается неверным
															// эта настройка может решить эту проблему, но зачастую это совсем не нужно
#macro UNIT_PREPROCESSOR_SIMPLE_COLLISION_JUMPLINE_FIXANGLE	false
														
															// сохранения угла
															// записывается в global.UNIT_simcollDir
#macro UNIT_PREPROCESSOR_SIMPLE_COLLISION_JUMPLINE_GETANGLE	false


#region PREPROCESSOR

// инициализация переменных

if (UNIT_PREPROCESSOR_SIMPLE_COLLISION_JUMPSAMPLE_GETID) {
	
global.UNIT_simcollId = noone;
	
}

if (UNIT_PREPROCESSOR_SIMPLE_COLLISION_JUMPLINE_GETANGLE) {
	
global.UNIT_simcollDir = 0;

}

#endregion

/*
	Некоторые шаблонные реализации основанные на UNIT_simcollJump
	
	Все функции возвращают true, при наличии столкновение и false при его отсутствие
	Так же, они запишут последнею "свободную" скорость в переменную global.UNIT_simcollDist
	(под свободной я подразумеваю, скорость при которой столкновения нету)
*/

#region line

/// @function		UNIT_simcollJumpLine(x1, y1, x2, y2, obj, [prec=false], [notme=false], [accuracy=UNIT_SIMPLE_COLLISION_MOVE_DEFAULT_ACCURACY]);
function UNIT_simcollJumpLine(_x1, _y1, _x2, _y2, _obj, _prec=false, _notme=false, _accuracy=UNIT_SIMPLE_COLLISION_MOVE_DEFAULT_ACCURACY) {
	
	static _sampleObject = __UNIT_simpleCollisionJumpSample();
	
	static _check = method(_sampleObject,
		function(_speed, _object) {
			
			_object = collision_line(
				self._x1, self._y1,
				self._x1 + lengthdir_x(_speed, self._dir),
					self._y1 + lengthdir_y(_speed, self._dir),
				_object, self._prec, self._notme
			);
			
			if (UNIT_PREPROCESSOR_SIMPLE_COLLISION_JUMPSAMPLE_GETID) {
				
			if (_object) global.UNIT_simcollId = _object;
			
			}
			return _object;
		});
		
	if (UNIT_PREPROCESSOR_SIMPLE_COLLISION_JUMPSAMPLE_GETID) {
	
	global.UNIT_simcollId = noone;
	
	}
	
	var _dir = point_direction(_x1, _y1, _x2, _y2);
	
	if (UNIT_PREPROCESSOR_SIMPLE_COLLISION_JUMPLINE_GETANGLE) {
		
	global.UNIT_simcollDir = _dir;
	
	}
	
	_sampleObject._x1    = _x1;
	_sampleObject._y1    = _y1;
	_sampleObject._dir   = _dir;
	_sampleObject._prec  = _prec;
	_sampleObject._notme = _notme;
	
	_x2 = point_distance(_x1, _y1, _x2, _y2);
	_y2 = UNIT_simcollJump(_x2, _check, _obj, _accuracy);
	
	if (UNIT_PREPROCESSOR_SIMPLE_COLLISION_JUMPLINE_FIXANGLE) {
	
	if (_y2) {
		
		_x1 = _x1 + lengthdir_x(global.UNIT_simcollDist, _dir);
		_y1 = _y1 + lengthdir_y(global.UNIT_simcollDist, _dir);
		
		if (!collision_circle(_x1, _y1, 1.7 + _accuracy, _obj, _prec, _notme)) {
			
			global.UNIT_simcollDist = _x2;
			
			if (UNIT_PREPROCESSOR_SIMPLE_COLLISION_JUMPSAMPLE_GETID) {
			
			global.UNIT_simcollId = noone;
			
			}
			
			return false;
		}
	}
	
	}
	
	return _y2;
}

#endregion

#region rectangle

/// @function		UNIT_simcollJumpRectW(x1, y1, y2, width, obj, [prec=false], [notme=false], [accuracy=UNIT_SIMPLE_COLLISION_MOVE_DEFAULT_ACCURACY]);
function UNIT_simcollJumpRectW(_x1, _y1, _y2, _width, _obj, _prec=false, _notme=false, _accuracy=UNIT_SIMPLE_COLLISION_MOVE_DEFAULT_ACCURACY) {
	
	static _sampleObject = __UNIT_simpleCollisionJumpSample();
	
	static _check_xp = method(_sampleObject,
		function(_speed, _object) {
			
			_object = collision_rectangle(
				self._x1, self._y1,
				self._x1 + _speed, self._z,
				_object, self._prec, self._notme
			);
			
			if (UNIT_PREPROCESSOR_SIMPLE_COLLISION_JUMPSAMPLE_GETID) {
				
			if (_object) global.UNIT_simcollId = _object;
				
			}
			return _object;
		});
	
	static _check_xm = method(_sampleObject,
		function(_speed, _object) {
			
			_object = collision_rectangle(
				self._x1 - _speed, self._y1,
				self._x1, self._z,
				_object, self._prec, self._notme
			);
			
			if (UNIT_PREPROCESSOR_SIMPLE_COLLISION_JUMPSAMPLE_GETID) {
				
			if (_object) global.UNIT_simcollId = _object;
			
			}
			return _object;
		});
	
	if (UNIT_PREPROCESSOR_SIMPLE_COLLISION_JUMPSAMPLE_GETID) {
	
	global.UNIT_simcollId = noone;
	
	}
	
	_sampleObject._x1    = _x1;
	_sampleObject._y1    = _y1;
	_sampleObject._z     = _y2;
	_sampleObject._prec  = _prec;
	_sampleObject._notme = _notme;
	
	if (sign(_width) == -1) {
		
		_y1 = UNIT_simcollJump(-_width, _check_xm, _obj, _accuracy);
		global.UNIT_simcollDist = -global.UNIT_simcollDist;
	}
	else {
		
		_y1 = UNIT_simcollJump(_width, _check_xp, _obj, _accuracy);
	}
	
	return _y1;
}

/// @function		UNIT_simcollJumpRectH(x1, y1, x2, height, obj, [prec=false], [notme=false], [accuracy=UNIT_SIMPLE_COLLISION_MOVE_DEFAULT_ACCURACY]);
function UNIT_simcollJumpRectH(_x1, _y1, _x2, _height, _obj, _prec=false, _notme=false, _accuracy=UNIT_SIMPLE_COLLISION_MOVE_DEFAULT_ACCURACY) {
	
	static _sampleObject = __UNIT_simpleCollisionJumpSample();
	
	static _check_yp = method(_sampleObject,
		function(_speed, _object) {
			
			_object = collision_rectangle(
				self._x1, self._y1,
				self._z, self._y1 + _speed,
				_object, self._prec, self._notme
			);
			
			if (UNIT_PREPROCESSOR_SIMPLE_COLLISION_JUMPSAMPLE_GETID) {
				
			if (_object) global.UNIT_simcollId = _object;
			
			}
			return _object;
		});
	
	static _check_ym = method(_sampleObject,
		function(_speed, _object) {
			
			_object = collision_rectangle(
				self._x1, self._y1 - _speed,
				self._z, self._y1,
				_object, self._prec, self._notme
			);
			
			if (UNIT_PREPROCESSOR_SIMPLE_COLLISION_JUMPSAMPLE_GETID) {
				
			if (_object) global.UNIT_simcollId = _object;
			
			}
			return _object;
		});
	
	if (UNIT_PREPROCESSOR_SIMPLE_COLLISION_JUMPSAMPLE_GETID) {
	
	global.UNIT_simcollId = noone;
	
	}
	
	_sampleObject._x1    = _x1;
	_sampleObject._y1    = _y1;
	_sampleObject._z     = _x2;
	_sampleObject._prec  = _prec;
	_sampleObject._notme = _notme;
	
	if (sign(_height) == -1) {
		
		_y1 = UNIT_simcollJump(-_height, _check_ym, _obj, _accuracy);
		global.UNIT_simcollDist = -global.UNIT_simcollDist;
	}
	else {
		
		_y1 = UNIT_simcollJump(_height, _check_yp, _obj, _accuracy);
	}
	
	return _y1;
}

#endregion

#region circle

/// @function		UNIT_simcollJumpCircle(x, y, rad, obj, [prec=false], [notme=false], [accuracy=UNIT_SIMPLE_COLLISION_MOVE_DEFAULT_ACCURACY]);
function UNIT_simcollJumpCircle(_x, _y, _rad, _obj, _prec=false, _notme=false, _accuracy=UNIT_SIMPLE_COLLISION_MOVE_DEFAULT_ACCURACY) {
	
	static _sampleObject = __UNIT_simpleCollisionJumpSample();
	
	static _check = method(_sampleObject,
		function(_speed, _object) {
			
			_object = collision_circle(
				self._x1, self._y1,
				_speed, _object, self._prec, self._notme
			);
			
			if (UNIT_PREPROCESSOR_SIMPLE_COLLISION_JUMPSAMPLE_GETID) {
				
			if (_object) global.UNIT_simcollId = _object;
			
			}
			return _object;
		});
	
	if (UNIT_PREPROCESSOR_SIMPLE_COLLISION_JUMPSAMPLE_GETID) {
	
	global.UNIT_simcollId = noone;
	
	}
	
	_sampleObject._x1    = _x;
	_sampleObject._y1    = _y;
	_sampleObject._z     = _rad;
	_sampleObject._prec  = _prec;
	_sampleObject._notme = _notme;
	
	return UNIT_simcollJump(_rad, _check, _obj, _accuracy);
}

#endregion


#region __private

function __UNIT_simpleCollisionJumpSample() {
	static _obj = {};
	return _obj;
}

function UNIT_simpleCollisionJumpSample() {};

#endregion


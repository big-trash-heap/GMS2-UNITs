

/*
	Настройки работы функций
	(смотри в UNIT_simcollMove)
*/

// Общие настройки
															// сохранения id объекта, с которым было обнаруженно столкновение в последний раз
															// записывается global.UNIT_simcollId
#macro UNIT_PREPROCESSOR_SIMCOLL_JUMPSAMPLE_GETID           false

// Настройки UNIT_simcollJumpLine
															// проверка ошибочных ситуаций
															// из-за погрешности collision_line, иногда результат UNIT_simcollJumpLine оказывается неверным
															// эта настройка может решить эту проблему, но зачастую это совсем не нужно
#macro UNIT_PREPROCESSOR_SIMCOLL_JUMPLINE_FIXANGLE	false
															
															// сохранения угла
															// записывается в global.UNIT_simcollDir
#macro UNIT_PREPROCESSOR_SIMCOLL_JUMPLINE_GETANGLE	false


#region PREPROCESSOR

// инициализация переменных

if (UNIT_PREPROCESSOR_SIMCOLL_JUMPSAMPLE_GETID) {
	
global.UNIT_simcollId = noone;
	
}

if (UNIT_PREPROCESSOR_SIMCOLL_JUMPLINE_GETANGLE) {
	
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

/// @function		UNIT_simcollJumpLine(x1, y1, x2, y2, objects, [prec=false], [notme=false], [accuracy=UNIT_SIMCOLL_MOVE_DEFAULT_ACCURACY]);
function UNIT_simcollJumpLine(_x1, _y1, _x2, _y2, _objects, _prec=false, _notme=false, _accuracy=UNIT_SIMCOLL_MOVE_DEFAULT_ACCURACY) {
	
	static _sampleObject = __UNIT_simcollJumpSample();
	
	static _check = method(_sampleObject,
		function(_speed, _objects) {
			
			var _size = array_length(_objects);
			var _colobject;
			var _isCollision;
			
			do {
				
				_colobject = collision_line(
					self._x1, self._y1,
					self._x1 + lengthdir_x(_speed, self._dir),
						self._y1 + lengthdir_y(_speed, self._dir),
					_objects[--_size], self._prec, self._notme,
				);
				
				_isCollision = (_colobject != noone);
			} until (_isCollision || _size == 0);
			
			if (UNIT_PREPROCESSOR_SIMCOLL_JUMPSAMPLE_GETID) {
				
			if (_isCollision) global.UNIT_simcollId = _colobject;
			
			}
			return _isCollision;
		});
	
	if (not is_array(_objects)) _objects = [_objects];
	
	if (UNIT_PREPROCESSOR_SIMCOLL_JUMPSAMPLE_GETID) {
	
	global.UNIT_simcollId = noone;
	
	}
	
	if (array_length(_objects) == 0) {
		
		if (UNIT_PREPROCESSOR_SIMCOLL_JUMPLINE_GETANGLE) {
		
		global.UNIT_simcollDir = point_direction(_x1, _y1, _x2, _y2);
		
		}
		
		global.UNIT_simcollDist = point_distance(_x1, _y1, _x2, _y2);
		return false;
	}
	
	var _dir = point_direction(_x1, _y1, _x2, _y2);
	
	if (UNIT_PREPROCESSOR_SIMCOLL_JUMPLINE_GETANGLE) {
	
	global.UNIT_simcollDir = _dir;
	
	}
	
	_sampleObject._x1    = _x1;
	_sampleObject._y1    = _y1;
	_sampleObject._dir   = _dir;
	_sampleObject._prec  = _prec;
	_sampleObject._notme = _notme;
	
	_x2 = point_distance(_x1, _y1, _x2, _y2);
	_y2 = UNIT_simcollJump(_x2, _check, _objects, _accuracy);
	
	if (UNIT_PREPROCESSOR_SIMCOLL_JUMPLINE_FIXANGLE) {
	
	if (_y2) {
		
		_x1 = _x1 + lengthdir_x(global.UNIT_simcollDist, _dir);
		_y1 = _y1 + lengthdir_y(global.UNIT_simcollDist, _dir);
		
		if (UNIT_PREPROCESSOR_SIMCOLL_JUMPSAMPLE_GETID) {
		
		if (collision_circle(_x1, _y1, 1.7 + _accuracy, global.UNIT_simcollId, _prec, false)) return true;
		
		}
		
		var _size = array_length(_objects);
		var _colobject;
		do {
			
			_colobject = collision_circle(_x1, _y1, 1.7 + _accuracy, _objects[--_size], _prec, _notme);
			if (_colobject != noone) {
				
				if (UNIT_PREPROCESSOR_SIMCOLL_JUMPSAMPLE_GETID) {
				
				global.UNIT_simcollId = _colobject;
				
				}
				
				return true;
			}
		} until (_size == 0);
		
		global.UNIT_simcollDist = _x2;
		
		if (UNIT_PREPROCESSOR_SIMCOLL_JUMPSAMPLE_GETID) {
		
		global.UNIT_simcollId = noone;
		
		}
		
		return false;
	}
	
	}
	
	return _y2;
}

#endregion

#region rectangle

/// @function		UNIT_simcollJumpRectW(x1, y1, y2, width, objects, [prec=false], [notme=false], [accuracy=UNIT_SIMCOLL_MOVE_DEFAULT_ACCURACY]);
function UNIT_simcollJumpRectW(_x1, _y1, _y2, _width, _objects, _prec=false, _notme=false, _accuracy=UNIT_SIMCOLL_MOVE_DEFAULT_ACCURACY) {
	
	static _sampleObject = __UNIT_simcollJumpSample();
	
	static _check_xp = method(_sampleObject,
		function(_speed, _objects) {
			
			var _size = array_length(_objects);
			var _colobject;
			var _isCollision;
			
			do {
				
				_colobject = collision_rectangle(
					self._x1, self._y1,
					self._x1 + _speed, self._z,
					_objects[--_size], self._prec, self._notme,
				);
				
				_isCollision = (_colobject != noone);
			} until (_isCollision || _size == 0);
			
			if (UNIT_PREPROCESSOR_SIMCOLL_JUMPSAMPLE_GETID) {
				
			if (_isCollision) global.UNIT_simcollId = _colobject;
			
			}
			return _isCollision;
		});
	
	static _check_xm = method(_sampleObject,
		function(_speed, _objects) {
			
			var _size = array_length(_objects);
			var _colobject;
			var _isCollision;
			
			do {
				
				_colobject = collision_rectangle(
					self._x1 - _speed, self._y1,
					self._x1, self._z,
					_objects[--_size], self._prec, self._notme,
				);
				
				_isCollision = (_colobject != noone);
			} until (_isCollision || _size == 0);
			
			if (UNIT_PREPROCESSOR_SIMCOLL_JUMPSAMPLE_GETID) {
				
			if (_isCollision) global.UNIT_simcollId = _colobject;
			
			}
			return _isCollision;
		});
	
	if (not is_array(_objects)) _objects = [_objects];
	
	if (UNIT_PREPROCESSOR_SIMCOLL_JUMPSAMPLE_GETID) {
	
	global.UNIT_simcollId = noone;
	
	}
	
	if (array_length(_objects) == 0) {
		
		global.UNIT_simcollDist = _width;
		return false;
	}
	
	_sampleObject._x1    = _x1;
	_sampleObject._y1    = _y1;
	_sampleObject._z     = _y2;
	_sampleObject._prec  = _prec;
	_sampleObject._notme = _notme;
	
	if (sign(_width) == -1) {
		
		_y1 = UNIT_simcollJump(-_width, _check_xm, _objects, _accuracy);
		global.UNIT_simcollDist = -global.UNIT_simcollDist;
	}
	else {
		
		_y1 = UNIT_simcollJump(_width, _check_xp, _objects, _accuracy);
	}
	
	return _y1;
}

/// @function		UNIT_simcollJumpRectH(x1, y1, x2, height, objects, [prec=false], [notme=false], [accuracy=UNIT_SIMCOLL_MOVE_DEFAULT_ACCURACY]);
function UNIT_simcollJumpRectH(_x1, _y1, _x2, _height, _objects, _prec=false, _notme=false, _accuracy=UNIT_SIMCOLL_MOVE_DEFAULT_ACCURACY) {
	
	static _sampleObject = __UNIT_simcollJumpSample();
	
	static _check_yp = method(_sampleObject,
		function(_speed, _objects) {
			
			var _size = array_length(_objects);
			var _colobject;
			var _isCollision;
			
			do {
				
				_colobject = collision_rectangle(
					self._x1, self._y1,
					self._z, self._y1 + _speed,
					_objects[--_size], self._prec, self._notme,
				);
				
				_isCollision = (_colobject != noone);
			} until (_isCollision || _size == 0);
			
			if (UNIT_PREPROCESSOR_SIMCOLL_JUMPSAMPLE_GETID) {
				
			if (_isCollision) global.UNIT_simcollId = _colobject;
			
			}
			return _isCollision;
		});
	
	static _check_ym = method(_sampleObject,
		function(_speed, _objects) {
			
			var _size = array_length(_objects);
			var _colobject;
			var _isCollision;
			
			do {
				
				_colobject = collision_rectangle(
					self._x1, self._y1 - _speed,
					self._z, self._y1,
					_objects[--_size], self._prec, self._notme,
				);
				
				_isCollision = (_colobject != noone);
			} until (_isCollision || _size == 0);
			
			if (UNIT_PREPROCESSOR_SIMCOLL_JUMPSAMPLE_GETID) {
				
			if (_isCollision) global.UNIT_simcollId = _colobject;
			
			}
			return _isCollision;
		});
	
	if (not is_array(_objects)) _objects = [_objects];
	
	if (UNIT_PREPROCESSOR_SIMCOLL_JUMPSAMPLE_GETID) {
	
	global.UNIT_simcollId = noone;
	
	}
	
	if (array_length(_objects) == 0) {
		
		global.UNIT_simcollDist = _height;
		return false;
	}
	
	_sampleObject._x1    = _x1;
	_sampleObject._y1    = _y1;
	_sampleObject._z     = _x2;
	_sampleObject._prec  = _prec;
	_sampleObject._notme = _notme;
	
	if (sign(_height) == -1) {
		
		_y1 = UNIT_simcollJump(-_height, _check_ym, _objects, _accuracy);
		global.UNIT_simcollDist = -global.UNIT_simcollDist;
	}
	else {
		
		_y1 = UNIT_simcollJump(_height, _check_yp, _objects, _accuracy);
	}
	
	return _y1;
}

#endregion

#region circle

/// @function		UNIT_simcollJumpCircle(x, y, rad, objects, [prec=false], [notme=false], [accuracy=UNIT_SIMCOLL_MOVE_DEFAULT_ACCURACY]);
function UNIT_simcollJumpCircle(_x, _y, _rad, _objects, _prec=false, _notme=false, _accuracy=UNIT_SIMCOLL_MOVE_DEFAULT_ACCURACY) {
	
	static _sampleObject = __UNIT_simcollJumpSample();
	
	static _check = method(_sampleObject,
		function(_speed, _objects) {
			
			var _size = array_length(_objects);
			var _colobject;
			var _isCollision;
			
			do {
				
				_colobject = collision_circle(
					self._x1, self._y1,
					_speed, _objects[--_size], self._prec, self._notme,
				);
				
				_isCollision = (_colobject != noone);
			} until (_isCollision || _size == 0);
			
			if (UNIT_PREPROCESSOR_SIMCOLL_JUMPSAMPLE_GETID) {
				
			if (_isCollision) global.UNIT_simcollId = _colobject;
			
			}
			return _isCollision;
		});
	
	if (not is_array(_objects)) _objects = [_objects];
	
	if (UNIT_PREPROCESSOR_SIMCOLL_JUMPSAMPLE_GETID) {
	
	global.UNIT_simcollId = noone;
	
	}
	
	if (array_length(_objects) == 0) {
		
		global.UNIT_simcollDist = _rad;
		return false;
	}
	
	_sampleObject._x1    = _x;
	_sampleObject._y1    = _y;
	_sampleObject._z     = _rad;
	_sampleObject._prec  = _prec;
	_sampleObject._notme = _notme;
	
	return UNIT_simcollJump(_rad, _check, _objects, _accuracy);
}

#endregion


#region __private

function __UNIT_simcollJumpSample() {
	static _obj = {};
	return _obj;
}

function UNIT_simcollJumpSample() {};

#endregion

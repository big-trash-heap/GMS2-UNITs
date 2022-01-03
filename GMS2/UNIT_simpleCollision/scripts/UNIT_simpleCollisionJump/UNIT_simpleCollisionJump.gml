
// точность используемая в качестве стандартной (если аргумент не был передан)
/*
	В данном случаи, точность это предел поиска
	(например при точности 32, мы остановим поиск, когда найденная скорость, будет меньше 32)
*/
#macro UNIT_SIMPLE_COLLISION_MOVE_DEFAULT_ACCURACY	0.8

//					check = function(speed, data)
/// @function		UNIT_simcollJump(speed, check, [data], [accuracy]);
/// @description	Вернёт true, при наличии столкновения, а так же запишет в
//					global.UNIT_simcollDist "свободную" скорость
//					(под свободной я подразумеваю, скорость при которой столкновения нету)
//					Для поиска мы используем, что-то вроде бинарного поиска
//					(Это может быть намного эффективнее чем UNIT_simcollMove_single и UNIT_simcollMove_double)
function UNIT_simcollJump(_speed, _check, _data, _accuracy=UNIT_SIMPLE_COLLISION_MOVE_DEFAULT_ACCURACY) {
	
	if (_check(_speed, _data)) {
		
		_speed /= 2;
		var _mathSpeed = _speed;
		
		while (_speed > _accuracy) {
			
			_speed /= 2;
			if (_check(_mathSpeed, _data))
				_mathSpeed -= _speed;
			else
				_mathSpeed += _speed;
		}
		
		global.UNIT_simcollDist = _mathSpeed;
		return true;
	}
	
	global.UNIT_simcollDist = _speed;
	return false;
}


#region __private

function UNIT_simpleCollisionJump() {};

#endregion


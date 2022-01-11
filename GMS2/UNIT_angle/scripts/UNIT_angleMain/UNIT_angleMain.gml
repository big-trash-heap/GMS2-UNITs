
// Я использовал свой старый код, который тоже можно скачать (но не с github)
// https://marketplace.yoyogames.com/assets/5621/smooth-rotation-and-arc

#region main

/// @param			angle
function UNIT_angleWrap(_angle) {
	
	// source
	// LICENSE: https://github.com/kraifpatrik/CE/blob/master/LICENSE (Creative Commons Zero v1.0 Universal)
	// LINK   : https://github.com/kraifpatrik/CE/blob/4a97fe6c14955e7ac7253a323c3adb6190a99c0f/scripts/ce_math_misc/ce_math_misc.gml#L109
	
	// В отличии от моего варианта, тут мы сохраняем дробную часть
	return (_angle + ceil(-_angle / 360) * 360);
}

/// @function		UNIT_angleRotate(angleCurrent, angleRequired, speed, [accuracy]);
function UNIT_angleRotate(_angleCurrent, _angleRequired, _speed, _accuracy=-1) {
	
	if (sign(_speed) < 1) return _angleCurrent;
	
	var _diff = angle_difference(_angleRequired, _angleCurrent);
	if (abs(_diff) < _accuracy) return _angleRequired;
	
	return (_angleCurrent + clamp(_diff, -_speed, _speed));
}

/// @function		UNIT_angleArcWrap(angle, arcAngle, arcLengthHalf);
function UNIT_angleArcWrap(_angle, _arcAngle, _arcLengthHalf) {
	
	if (sign(_arcLengthHalf) < 1) return UNIT_angleWrap(_arcAngle);
	
	var _diff = angle_difference(_angle, _arcAngle);
	if (sign(_arcLengthHalf - abs(_diff)) < 1) {
		
		if (sign(_diff) > 0)
			return UNIT_angleWrap(_arcAngle + _arcLengthHalf);
		else
			return UNIT_angleWrap(_arcAngle - _arcLengthHalf);
	}
	
	return UNIT_angleWrap(_angle);
}

/// @function		UNIT_angleArcNearestLimit(angle, arcAngle, arcLengthHalf);
function UNIT_angleArcNearestLimit(_angle, _arcAngle, _arcLengthHalf) {
	
	if (sign(_arcLengthHalf) < 1) return UNIT_angleWrap(_arcAngle);
	
	if (sign(angle_difference(_angle, _arcAngle)) > 0)
		return UNIT_angleWrap(_arcAngle + _arcLengthHalf);
	else
		return UNIT_angleWrap(_arcAngle - _arcLengthHalf);
	
}

/// @function		UNIT_angleArcFurtherLimit(angle, arcAngle, arcLengthHalf);
function UNIT_angleArcFurtherLimit(_angle, _arcAngle, _arcLengthHalf) {
	
	if (sign(_arcLengthHalf) < 1) return UNIT_angleWrap(_arcAngle);
	
	if (sign(angle_difference(_angle, _arcAngle)) > 0)
		return UNIT_angleWrap(_arcAngle - _arcLengthHalf);
	else
		return UNIT_angleWrap(_arcAngle + _arcLengthHalf);
}

/// @function		UNIT_angleArcRotate(angleCurrent, angleRequired, speed, arcAngle, arcLengthHalf, [accuracy]);
function UNIT_angleArcRotate(_angleCurrent, _angleRequired, _speed, _arcAngle, _arcLengthHalf, _accuracy) {
	
	return UNIT_angleRotate(_angleCurrent,
		UNIT_angleArcWrap(_angleRequired, _arcAngle, _arcLengthHalf), 
		_speed, _accuracy
	);
}

/// @function		UNIT_angleArcIn(angleTest, arcAngle, arcLengthHalf);
function UNIT_angleArcIn(_angleTest, _arcAngle, _arcLengthHalf) {
	return (sign(_arcLengthHalf - abs(angle_difference(_angleTest, _arcAngle))) == 1);
}

#endregion

#region special

// Для вращения можно использовать скорость, но это может привести к не точности (так как мы работаем с double)...
// ... поэтому для вращения лучше использовать UNIT_angleRotate, UNIT_angleArcRotate, UNIT_angleArcRotateWrap

/// @function		UNIT_angleSpeedRotate(angleCurrent, angleRequired, speed);
function UNIT_angleSpeedRotate(_angleCurrent, _angleRequired, _speed) {
	
	if (sign(_speed) < 1) return 0;
	return clamp(angle_difference(_angleRequired, _angleCurrent), -_speed, _speed);
}

/// @function		UNIT_angleSpeedArcRotate(angleCurrent, angleRequired, speed, arcAngle, arcLengthHalf);
function UNIT_angleSpeedArcRotate(_angleCurrent, _angleRequired, _speed, _arcAngle, _arcLengthHalf) {
	
	return UNIT_angleSpeedRotate(_angleCurrent,
		UNIT_angleArcWrap(_angleRequired, _arcAngle, _arcLengthHalf),
		_speed
	);
}

/// @function		UNIT_angleArcRotateWrap(angleCurrent, angleRequired, speed, arcAngle, arcLengthHalf, [accuracy]);
function UNIT_angleArcRotateWrap(_angleCurrent, _angleRequired, _speed, _arcAngle, _arcLengthHalf, _accuracy) {
	
	return UNIT_angleArcWrap(UNIT_angleArcRotate(
		_angleCurrent, _angleRequired, _speed, _arcAngle, _arcLengthHalf, _accuracy
	), _arcAngle, _arcLengthHalf);
}

#endregion


#region __private

function UNIT_angleMain() {};

#endregion




//					f = function(number) // floor/round/ceil/...
/// @function		UNIT_mthAbsRound(number, [f=floor]);
function UNIT_mthAbsRound(_number, _f=floor) {
	return (sign(_number) * _f(abs(_number)));
}

/// @param			number
function UNIT_mthTrunc(_number) {
	return (sign(_number) == -1 ? ceil(_number) : floor(_number));
}

/// @function		UNIT_mthSign(number, [positive=true]);
function UNIT_mthSign(_number, _positive=true) {
	_number = sign(_number);
	return (_number != 0 ? _number : (_positive ? 1 : -1));
}

/// @param			angle
function UNIT_mthAngleWrap(_angle) {
	return (_angle + ceil(-_angle / 360) * 360);
}


#region __private

function UNIT_math() {};

#endregion


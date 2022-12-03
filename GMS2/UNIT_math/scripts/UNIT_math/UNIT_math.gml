

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

// https://github.com/blueburncz/CoreExtension/blob/bc1eb8216f407a28bb22ea39fa5b7ce974cec339/scripts/CE_MathMisc/CE_MathMisc.gml#L79
function UNIT_mthSnap(_number, _step) {
	return (floor(_number / _step) * _step);
}

function UNIT_mthWrap(_number, _max) {
	return (_number + ceil(-_number / _max) * _max);
}

function UNIT_mthWrap2(_number, _min, _max) {
	var _length = (_max - _min);
	_number    -= _min;
	
	return (_number + ceil(-_number / _length) * _length + _min);
}


#region __private

function UNIT_math() {};

#endregion


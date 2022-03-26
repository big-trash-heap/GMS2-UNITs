

#region basic

/// @param			...values
function UNIT_functorVoid() {
	return undefined;
}

/// @function		UNIT_functorConst(_, value);
function UNIT_functorConst(_0, _value) {
	return _value;
}

/// @function		UNIT_functorId(value, ...values);
function UNIT_functorId(_value) {
	return _value;
}

/// @param			value
function UNIT_functorArr(_value) {
	return (is_array(_value) ? _value : [_value]);
}

/// @param			value
function UNIT_functorInv(_value) {
	return (not _value);
}

#endregion

#region method

/// @param			func
function UNIT_functorMeth(_func) {
	return method(undefined, _func);
}

/// @param			func
function UNIT_functorFunc(_func) {
	return (is_method(_func) ? method_get_index(_func) : _func);
}

#endregion


#region __private

function UNIT_functors() {};

#endregion


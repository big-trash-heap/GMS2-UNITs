

/*
	Сравнение объектов, с возможностью отсортировать их в порядке (Ord)
	Можно использовать например для функции array_sort
*/

#macro UNIT_COMP_LT	-1	// what < with
#macro UNIT_COMP_EQ	0  	// what = with
#macro UNIT_COMP_GT	1	// what > with

#region basic

/// @function		UNIT_compOrdNum(what, with);
function UNIT_compOrdNum(_what, _with) {
	
	/*
		UNIT_compOrdNum(2.0000242, 2.0000242) -> UNIT_COMP_EQ
		UNIT_compOrdNum(5, 5)                 -> UNIT_COMP_EQ
		
		UNIT_compOrdNum(2.0000242, 2.0000243) -> UNIT_COMP_LT
		UNIT_compOrdNum(2, 5)                 -> UNIT_COMP_LT
		
		UNIT_compOrdNum(2.0000243, 2.0000242) -> UNIT_COMP_GT
		UNIT_compOrdNum(5, 2)                 -> UNIT_COMP_GT
	*/
	
	return sign(_what - _with);
}

/// @function		UNIT_compOrdStr(what, with);
/// @description	Лексикографическое сравнение строк
function UNIT_compOrdStr(_what, _with) {

	/*
		UNIT_compOrdStr("aa", "aa") -> UNIT_COMP_EQ
		UNIT_compOrdStr("", "")     -> UNIT_COMP_EQ
		
		UNIT_compOrdStr("aa", "ab") -> UNIT_COMP_LT
		UNIT_compOrdStr("a", "ab")  -> UNIT_COMP_LT
		UNIT_compOrdStr("", "ab")   -> UNIT_COMP_LT
		UNIT_compOrdStr("ab", "b")  -> UNIT_COMP_LT
		
		UNIT_compOrdStr("2", "1")   -> UNIT_COMP_GT
		UNIT_compOrdStr("2", "11")  -> UNIT_COMP_GT
		UNIT_compOrdStr("2", "")    -> UNIT_COMP_GT
		UNIT_compOrdStr("b", "ab")  -> UNIT_COMP_GT
	*/
	
	var _sizeWhat = string_length(_what);
	var _sizeWith = string_length(_with);
	
	var _sign, _j = min(_sizeWhat, _sizeWith);
	for (var _i = 1; _i <= _j; ++_i) {
		
		_sign = sign(string_ord_at(_what, _i) - string_ord_at(_with, _i));
		if (_sign != 0) return _sign;
	}
	
	return sign(_sizeWhat - _sizeWith);
}

/// @function		UNIT_compOrdNS(what, with);
/// @description	Комбинация UNIT_compOrdNum и UNIT_compOrdStr
//					Числа по отношению к строкам, расцениваются
//					как меньшее значение
function UNIT_compOrdNS(_what, _with) {
	if (is_string(_what)) {
		if (is_string(_with)) {
			return UNIT_compOrdStr(_what, _with);
		}
		return UNIT_COMP_GT;
	}
	if (is_string(_with)) return UNIT_COMP_LT;
	return sign(_what - _with);
}

#endregion

#region __private

function UNIT_compareOrd() {};

#endregion


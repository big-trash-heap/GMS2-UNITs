
/*
	Перевод в разные системы счисления
*/

#macro UNIT_TO_STR_DEFTABLE		"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
#macro UNIT_TO_STR_HEX			16
#macro UNIT_TO_STR_OCT			8
#macro UNIT_TO_STR_BIN			2

// СС - система счисления

/// @function		UNIT_toStrIntTBase(integer, base, [table=UNIT_TO_STR_DEFTABLE]);
/// @description	Переводит число из 10-СС в base-СС (в виде строки)
function UNIT_toStrIntTBase(_integer, _base, _table=UNIT_TO_STR_DEFTABLE) {
    
    var _sign = sign(_integer);
    if (_sign == 0) {
		return string_char_at(_table, 1);
	}
	
    var _result = "";
	for (
		_integer = abs(_integer);
		_integer > 0; 
		_integer = _integer div _base;
	) {
        _result  = string_char_at(_table, (_integer mod _base) + 1) + _result;
    }
	
    return (_sign == -1 ? "-" + _result : _result);
}

/// @function		UNIT_toStrBaseTInt(string, base, [table=UNIT_TO_STR_DEFTABLE]);
/// @description	Переводит число (строку) из base-СС в 10-СС (в виде числа)
function UNIT_toStrBaseTInt(_string, _base, _table) {
    
    static _defaultTable = UNIT_toStrBaseTIntBulTable(UNIT_TO_STR_DEFTABLE);
    
    if (is_undefined(_table)) {
    	_table = _defaultTable;
	}
    else {
    	_table = (is_string(_table) ? UNIT_toStrBaseTIntBulTable(_table) : _table);
	}
    
    var _integer = 0;
	var _size    = string_length(_string);
	var _index   = _size;
	var _skip    = 1;
	var _sign    = 1;
	
	if (string_char_at(_string, 1) == "-") {
		_sign = -1;
		++_skip;
	}
	
	for (;_skip <= _index; --_index) {
		
		_integer += 
			power(_base, _size - _index) * _table[$ string_char_at(_string, _index)];
	}
	
	return (_integer * _sign);
}

/// @description	Строит таблицу из символов
//
/// @param			table
function UNIT_toStrBaseTIntBulTable(_table) {
	
	var _size = string_length(_table);
    var _build = {};
    for (var _i = 1; _i <= _size; ++_i) {
		
		_build[$ string_char_at(_table, _i)] = _i - 1;	
	}
    
	return _build;
}

/// @description	Комбинирует UNIT_toStrIntTBase и UNIT_toStrBaseTInt в одну функцию
//
/// @param			value
/// @param			[base=16]
/// @param			[padding=0] - минимальная длина строки, где отсутствующие
//						значения будут заполнены нулями
function UNIT_toStrInt(_value, _base=16, _padding=0) {
	
	if (is_string(_value)) {
		return UNIT_toStrBaseTInt(_value, _base);
	}
	
	var _str = UNIT_toStrIntTBase(_value, _base);
	if (_padding < 1) {
		return _str;
	}
	
	var _sign = 1;
	if (string_char_at(_str, 1) == "-") {
		
		_sign = -1;
		_str = string_delete(_str, 1, 1);
	}
	
	var _size = string_length(_str);
	if (_padding > _size) {
		_str = string_repeat("0", _padding - _size) + _str;
	}
	
	return (_sign == -1 ? "-" + _str : _str);
}


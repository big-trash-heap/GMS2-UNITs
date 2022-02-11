

#region modify

/// @function		UNIT_arrPlace(array, [index=size], ...value);
/// @description	Заменят (и добавляет) элементы в массиве
function UNIT_arrPlace(_array, _index) {
	var _count = argument_count - 2;
	if (_count > 0) {
		
		var _size = array_length(_array);
		if (is_undefined(_index)) _index = _size;
		
		array_resize(_array, max(_size, _index + _count));
		for (var _i = 0; _i < _count; ++_i) 
			array_set(_array, _index + _i, argument[_i + 2]);
	}
}

/// @function		UNIT_arrInsEm(array, index, count, [value]);
/// @description	Смещает элементы в массиве и устанавливает
//					значение value (если указанно) на их место
function UNIT_arrInsEm(_array, _index, _count) {
    if (_count > 0) {
		
        var _length = array_length(_array);
		var _size   = _length - _index;
		var _insert = (_size > 0);
		
        array_resize(_array, max(_length, _index + _count));
		
        if (_insert) {
			
			// сдвиг элементов
            var shift = _index + _count;
            while (_size--) array_set(_array, _size + shift, array_get(_array, _size + _index));
        }
        if (argument_count > 3) {
            if (_insert) {
                
				// закраска элементов если вставили внутрь массива
				while (_count--) array_set(_array, _index + _count, argument[3]);
                return true;
            }
            
			// закраска элементов если вставили за пределы массива
			_size = array_length(_array);
            _length -= 1;
            while (++_length < _size) array_set(_array, _length, argument[3]);
        }
        return true;
    }
    return false;
}

/// @description	Удалит и вернёт первый элемент массива
//					Если элементов нету, вернёт undefined
//
/// @param			array
function UNIT_arrShift(_array) {
    if (array_length(_array)) {
		
        var _value = array_get(_array, 0);
        array_delete(_array, 0, 1);
        return _value;
    }
    return undefined;
}

/// @function		UNIT_arrUnshift(array, ...value);
/// @description	Вставит элементы в начало массива
function UNIT_arrUnshift(_array) {
	var _argSize = argument_count;
    if (UNIT_arrInsEm(_array, 0, _argSize - 1)) {
		
        var _i = 0;
        while (++_i < _argSize) 
			array_set(_array, _i - 1, argument[_i]);
		
		return (_argSize - 1);
    }
	return 0;
}

/// @param			array
function UNIT_arrShuffle(_array) {
    var _size = array_length(_array);
    if (_size > 1) {
		
        var _i = -1, _swap, _j;
        while (++_i < _size) {
			
            _j = irandom(_size - 1);
            _swap = array_get(_array, _i);
            array_set(_array, _i, array_get(_array, _j));
            array_set(_array, _j, _swap);
        }
	}
}

/// @function		UNIT_arrCop(dest, dest_index, src, [src_index=0], [length=max]);
/// @description	Аналог array_copy, поддерживающий копирование 
//					в двух одинаковых (по ссылкам) массивам
function UNIT_arrCop(_dest, _destIndex, _src, _srcIndex=0, _length) {
	
    if (is_undefined(_length)) _length = array_length(_src) - _srcIndex;
    if (_length > 0) {
		
        array_resize(_dest, max(array_length(_dest), _destIndex + _length));
        if (_dest == _src) {
			
            if (_destIndex == _srcIndex) exit;
            if (_destIndex > _srcIndex) {
            	
				// копирование с конца
				// так работает array_copy
            	do {
            		_length -= 1;
            		array_set(_dest, _length + _destIndex, array_get(_src, _length + _srcIndex));
            	} until (_length <= 0);
                exit;
            }
        }
		
		// копирование с начала
        var _i = 0;
        do {
            array_set(_dest, _i + _destIndex, array_get(_src, _i + _srcIndex));
        } until (++_i == _length);
    }
}

/// @function		UNIT_arrIns(dest, dest_index, src, [src_index=0], [length=max]);
/// @description	Вставка элементов, поддерживает вставку из
//					двух одинаковых (по ссылкам) массивам
function UNIT_arrIns(_dest, _destIndex, _src, _srcIndex=0, _length) {
	
    if (is_undefined(_length)) _length = array_length(_src) - _srcIndex;
    if (_length > 0) {
		
		var _destLength = array_length(_dest);
        var _size = _destLength - _destIndex;
		array_resize(_dest, _destLength + _length);
		
        if (_size > 0) {
			
            var _destShift = _destIndex + _length;
            if (_dest == _src) {
				
				// копирование с помощью временного массива
                var _temp = array_create(_length), _i = -1;
                while (++_i < _length) array_set(_temp, _i,                 array_get(_src, _i + _srcIndex));
                while (_size--)        array_set(_dest, _size + _destShift, array_get(_dest, _size + _destIndex));
				
                _i = -1;
                while (++_i < _length) array_set(_dest, _i + _destIndex,    array_get(_temp, _i));
                exit;
            }
			// сдвиг элементов
            do {
				_size -= 1;
            	array_set(_dest, _size + _destShift, array_get(_dest, _size + _destIndex));
            } until (_size == 0);
        }
		// заливка элементов
        do {
        	_length -= 1;
        	array_set(_dest, _length + _destIndex, array_get(_src, _length + _srcIndex));
        } until (_length == 0);
    }
}

/// @function		UNIT_arrRemNOrd(array, index);
/// @description	Удаляет элемент меняя его местами с последним
function UNIT_arrRemNOrd(_array, _index) {
	var _size = array_length(_array) - 1;
	array_set(_array, _index, array_get(_array, _size));
	array_resize(_array, _size);
}

/// @param			array
function UNIT_arrClear(_array) {
	array_resize(_array, 0);	
}

#endregion

#region build

/// @param			...value
function UNIT_arrBul() {
	var _argSize  = argument_count;
	var _arrayBul = array_create(_argSize);
	for (var _i = 0; _i < _argSize; ++_i) 
		array_set(_arrayBul, _i, argument[_i]);
	return _arrayBul;
}

/// @param			array
/// @description	Клонирование массива с глубиной 1
function UNIT_arrBulDup1d(_array) {
	var _size = array_length(_array);
	var _arrayBul = array_create(_size);
	array_copy(_arrayBul, 0, _array, 0, _size);
	return _arrayBul;
}

/// @function		UNIT_arrBulFlatten(_array, [_depth=1]);
function UNIT_arrBulFlatten(_array, _depth=1) {
	
	if (_depth < 1) return UNIT_arrBulDup1d(_array);
	return UNIT_arrBulFlattenFrom(_depth + 2, _array);
}

/// @function		UNIT_arrBulFlattenFrom(_depth, ...args);
function UNIT_arrBulFlattenFrom(_depth) {
	
	var _argSize = argument_count;
	if (_argSize > 1) {
		
		var _stack = ds_stack_create();
		var _build = [];
		
		var _array, _size, _j;
		var _pack, _value;
		var _locdepth;
		
		var _i = 1;
		do {
			
			_value = argument[_i];
			if (_depth > 1 && is_array(_value)) {
				
				ds_stack_push(_stack, [0, _value, 2]);
				do {
					
					_pack = ds_stack_top(_stack);
					_array = _pack[1];
					_locdepth = _pack[2];
					_size = array_length(_array);
					
					for (_j = _pack[0]; _j < _size; ++_j) {
						
						_value = _array[_j];
						if (_locdepth < _depth && is_array(_value)) {
							ds_stack_push(_stack, [0, _value, _locdepth + 1]);
							
							_pack[@ 0] = _j + 1;
							_j = -1;
							break;
						}
						else  {
							array_push(_build, _value);	
						}
					}
					
					if (_j != -1) ds_stack_pop(_stack);
				} until (ds_stack_empty(_stack));
			}
			else {
				array_push(_build, _value);	
			}
		} until (++_i == _argSize);
		
		ds_stack_destroy(_stack);
		return _build;
	}
	
	return [];
}

#endregion

#region find

/// @function		UNIT_arrFindByVal(array, value, [index=0]);
function UNIT_arrFindByVal(_array, _value, _index=0) {
	
	var _size = array_length(_array);
	for (; _index < _size; ++_index)
		if (_array[_index] == _value) return _index;
	
	return -1;
}

/// @function		UNIT_arrExists(array, value);
function UNIT_arrExists(_array, _value) {
	return (UNIT_arrFindByVal(_array, _value) != -1);
}

#endregion

#region range

/// @function		UNIT_arrRangeGet(array, index, size);
function UNIT_arrRangeGet(_array, _index, _length) {
	var _range = array_create(_length);
	array_copy(_range, 0, _array, _index, _length);
	return _range;
}

/// @function		UNIT_arrRangeSet(array, index, range);
function UNIT_arrRangeSet(_array, _index, _range) {
	UNIT_arrCop(_array, _index, _range);
}

/// @function		UNIT_arrRangeInsert(array, index, range);
function UNIT_arrRangeInsert(_array, _index, _range) {
	UNIT_arrIns(_array, _index, _range);
}

#endregion


#region __private

function UNIT_array() {};

#endregion


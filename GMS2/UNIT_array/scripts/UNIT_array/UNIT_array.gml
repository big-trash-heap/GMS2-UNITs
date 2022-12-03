
/*
	При использовании следующих функций вы должны учесть, что
	1. Я не думаю о памяти, так как язык не обязует думать о таких вещах
	2. Я не валидирую аргументы (в том числе и не обязательные) и не обрабатываю ошибки, я доверяю пользователю
	3. Я не гарантирую, что не правильные аргументы приведут к сбою, которые вы сможете отследить
	4. Я никогда не возвращаю исключений
	
	Вы должны понимать, что если вы вызове функции с неправильным аргументами это всё равно может работать (просто логически некорректно)
	Я опишу возможные причины этого:
	1. Я не валидирую аргументы, но из-за специфики алгоритма, он может отработать и с неверными аргументами (только не так как ожидалось)
	2. В некоторых местах я всё таки валидирую и поправляю переданные аргументы. Я делаю это поскольку это очень хорошо вписывается в интерфейс,
		который я пишу. Поэтому передавая некорректные аргументы, вы можете получить то, что ожидаете
		Я валидирую аргументы, так как это позволяте мне сделать код проще
	
	Моя цель, это написание простого и оптимального интерфейса
	
	**Для корректной работы вы должны поставлять функциям корректные аргументы**
*/

#region modify

/* impl in UNIT_ArrayWrap.place */
/// @func UNIT_arrPlace(array, [index=size], ...values)
///
/// @desc Устанавливает элементы в массив
///
/// @param {Array<Any>} _array
/// @param {Real | Undefined} _index - если передан Undefined, 
/// то функция будет работать как `array_push`
///
/// @param {Any} [..._values]
function UNIT_arrPlace(_array, _index) {
	var _count = argument_count - 2;
	if (_count == 0) {
		return;
	}
	
	var _size = array_length(_array);
	
	_index ??= _size;
	array_resize(_array, max(_size, _index + _count));
	
	for (var _i = _count - 1; _i >= 0; --_i) {
		array_set(_array, _index + _i, argument[_i + 2]);
	}
}

/// @func UNIT_arrInsEm(array, index, count, [value])
///
/// @dest Смещает элементы в массиве и устанавливает
/// значение `value` (если указанно) на их место,
/// значение не передано, оставит как есть
///
/// @param {Array<Any>} _array
/// @param {Real} _index
/// @param {Real} _count
/// @param {Any} [_value]
///
/// @return {Bool} - вернёт `true`, если `_count > 0`, или `false`
function UNIT_arrInsEm(_array, _index, _count) {
    if (_count < 1) {
		return false;	
	}
	
    var _length = array_length(_array);
	var _size   = _length - _index;
	var _isFill = (_size > 0);
	
    array_resize(_array, max(_length, _index + _count));
	
    if (_isFill) {
		
		// сдвиг элементов
		var _shift = _index + _count;
		for (--_size; _size >= 0; --_size) {
			array_set(_array, _size + _shift, array_get(_array, _size + _index));
		}
    }
	
    if (argument_count > 3) {
        if (_isFill) {
            
			// закраска элементов если вставили внутрь массива
			for (--_count; _count >= 0; --_count) {
				array_set(_array, _index + _count, argument[3]);
			}
			
            return true;
        }
        
		// закраска элементов если вставили за пределы массива
		for (_size = array_length(_array); _length < _size; ++_length) {
			array_set(_array, _length, argument[3]);
		}
    }
	
    return true;
}

/// @func UNIT_arrShift(_array)
/// @desc Удалит и вернёт первый элемент массива.
/// Если элементов нету, вернёт `undefined`
//
/// @param {Array<Any>} _array
///
/// @return {Any | Undefined}
function UNIT_arrShift(_array) {
	if (array_length(_array) == 0) {
		return undefined;
	}
	
	var _value = array_get(_array, 0);
	array_delete(_array, 0, 1);
	return _value;
}

/* impl in UNIT_ArrayWrap.unshift */
/// @func UNIT_arrUnshift(array, ...value)
///
/// @desc Вставит элементы в начало массива
///
/// @param {Array<Any>} _array
/// @param {Any} [..._values]
///
/// @returns {Real} - вернёт количество вставленных элементов
function UNIT_arrUnshift(_array) {
	var _argSize = argument_count;
	
	if (!UNIT_arrInsEm(_array, 0, _argSize - 1)) {
		return 0;
	}
	
	for (var _i = 1; _i < _argSize; ++_i) {
		array_set(_array, _i - 1, argument[_i]);	
	}
	
	return (_argSize - 1);
}

/// @func UNIT_arrShuffle(array)
///
/// @desc Перемешает элементы массива
///
/// @param {Array<Any>} _array
function UNIT_arrShuffle(_array) {
    var _size = array_length(_array);
	if (_size < 2) {
		return;
	}
	
	var _swap, _j;
	for (var _i = 0; _i < _size; ++_i) {
		
		_j = irandom(_size - 1);
		_swap = array_get(_array, _i);
		array_set(_array, _i, array_get(_array, _j));
		array_set(_array, _j, _swap);
	}
}

/// @func UNIT_arrCop(dest, destIndex, src, [srcIndex=0], [length=max])
///
/// @desc Аналог array_copy, поддерживающий копирование 
/// в двух одинаковых (по ссылкам) массивам
///
/// @param {Array<Any>} _dest
/// @param {Real} _destIndex
/// @param {Array<Any>} _src
/// @param {Real} [_srcIndex]
/// @param {Real} [_length]
function UNIT_arrCop(_dest, _destIndex, _src, _srcIndex=0, _length) {
	
	_length = min(_length ?? infinity, array_length(_src) - _srcIndex);
	
	if (_length < 1) {
		return;
	}
	 
	array_resize(_dest, max(array_length(_dest), _destIndex + _length));
	if (_dest == _src) {
		
        if (_destIndex == _srcIndex) {
			return;
		}
		
        if (_destIndex > _srcIndex) {
            
			// копирование с конца
			// так работает array_copy
			for (--_length; _length >= 0; --_length) {
				array_set(_dest, _length + _destIndex, array_get(_src, _length + _srcIndex));
			}
			
			return;
        }
    }
	
	// копирование с начала
	for (var _i = 0; _i < _length; ++_i) {
		array_set(_dest, _i + _destIndex, array_get(_src, _i + _srcIndex));
	}
}

/// @func UNIT_arrIns(dest, destIndex, src, [srcIndex=0], [length=max])
///
/// @desc Вставка элементов, поддерживает вставку из
/// двух одинаковых (по ссылкам) массивам
///
/// @param {Array<Any>} _dest
/// @param {Real} _destIndex
/// @param {Array<Any>} _src
/// @param {Real} [_srcIndex]
/// @param {Real} [_length]
function UNIT_arrIns(_dest, _destIndex, _src, _srcIndex=0, _length) {
	
	_length = min(_length ?? infinity, array_length(_src) - _srcIndex);
	
	if (_length < 1) {
		return;
	}
	
	if (_dest == _src) {
		
		// копирование с помощью временного массива
		var _swap = array_create(_length);
		array_copy(_swap, 0, _dest, _srcIndex, _length);
		
		UNIT_arrInsEm(_dest, _destIndex, _length);
		
		array_copy(_dest, _destIndex, _swap, 0, _length);
		
        return;
    }
	
	UNIT_arrInsEm(_dest, _destIndex, _length);
	array_copy(_dest, _destIndex, _src, _srcIndex, _length);
}

/// @func UNIT_arrFill(array, value, [begin=0], [end=end])
///
/// @desc Заполняет массив элементами `value`
///
/// @param {Array<Any>} _array
/// @param {Any} _value
/// @param {Real} [_begin]
/// @param {Real} [_end]
function UNIT_arrFill(_array, _value, _begin=0, _end) {
	
	_end = min(_end ?? infinity, array_length(_array));
	
	for (_begin = max(0, _begin); _begin < _end; ++_begin) {
		array_set(_array, _begin, _value);
	}
}

/// @func UNIT_arrSplice(array, [index=0], [count=max])
///
/// @desc Удаляет промежуток массива и возвращает его
///
/// @param {Array<Any>} _array
/// @param {Real} [_index=0]
/// @param {Real} [_count]
///
/// @return {Array<Any>}
function UNIT_arrSplice(_array, _index=0, _count) {
	
	var _size = array_length(_array);
	
	if (_index >= _size) {
		
		return [];
	}
	
	_count =  min(_count ?? infinity, _size - _index);
	var _range = UNIT_arrRangeGet(_array, _index, _count);
	
	array_delete(_array, _index, _count);
	
	return _range;
}

/// @func UNIT_arrReverse(array)
///
/// @desc Переворачивает массив
///
/// @param {Array<Any>} _array
function UNIT_arrReverse(_array) {
	
	var _size = array_length(_array);
	
	if (_size < 2) {
		return;
	}
	
	var _sizeHalf = _size div 2;
	var _swap, _j;
	
	for (var _i = 0; _i < _sizeHalf; ++_i) {
		
		_j = _size - _i - 1;
		_swap = array_get(_array, _i);
		
		array_set(_array, _i, array_get(_array, _j));
		array_set(_array, _j, _swap);
	}
}

/// @func UNIT_arrSwapRemove(array, index)
///
/// @desc Меняет указанный элемент местами с последним и удаляет его,
///	при этом возвращая этот элемент
///
/// @param {Array<Any>} _array
/// @param {Real} _index
///
/// @return {Any | Undefined} _array
function UNIT_arrSwapRemove(_array, _index) {
	
	var _size = array_length(_array);
	
	if (_size < 1) {
		return undefined;
	}
	
	var _value = array_get(_array, _index);
	
	if (_index != _size - 1) {
		array_set(_array, _index, array_get(_array, _size - 1));
	}
	
	array_resize(_array, _size);
	return _value;
}

/// @func UNIT_arrClear(array)
///
/// @desc Удалит все элементы в массиве
///
/// @param {Array<Any>} _array
function UNIT_arrClear(_array) {
	array_resize(_array, 0);	
}

#endregion

#region build

/// @func UNIT_arrBul(...values)
/// @pure
///
/// @desc Построит массив, аналог `[1, 2, 3...]`
///
/// @param {Any} [...values]
///
/// @return {Array<Any>}
function UNIT_arrBul() {
	var _argSize  = argument_count;
	var _arrayBul = array_create(_argSize);
	
	for (var _i = 0; _i < _argSize; ++_i) {
		array_set(_arrayBul, _i, argument[_i]);	
	}
	
	return _arrayBul;
}

/// @func UNIT_arrBulDup1d(_array)
/// @pure
///
/// @desc Создаст копию массив (глубина копирования 1)
///
/// @param {Array<Any>} _array
///
/// @return {Array<Any>}
function UNIT_arrBulDup1d(_array) {
	var _size = array_length(_array);
	var _arrayBul = array_create(_size);
	
	array_copy(_arrayBul, 0, _array, 0, _size);
	
	return _arrayBul;
}

/// @func UNIT_arrBulFlatten(array, [depth=1])
/// @pure
///
/// @desc Объединит все подвложенные массивы в один массив (не рекурсивный алгоритм)
///
/// @param {Array<Any>} _array
/// @param {Real} [depth]
///
/// @return {Array<Any>}
function UNIT_arrBulFlatten(_array, _depth=1) {
	
	if (_depth < 1) {
		return UNIT_arrBulDup1d(_array);
	}
	
	return UNIT_arrBulFlattenFrom(_depth + 2, _array);
}

/// @func UNIT_arrBulFlattenFrom(depth, ...values)
/// @pure
///
/// @desc Объединит все значение в один массив, если значение являются массивами,
/// они так же будут объединятся
///
/// @param {Real} depth
/// @param {Any} ...values
///
/// @return {Array<Any>}
function UNIT_arrBulFlattenFrom(_depth) {
	
	var _argSize = argument_count;
	if (_argSize < 2) {
		return [];	
	}
	
	var _stack = ds_stack_create();
	var _build = [];
	
	var _array, _size, _j;
	var _pack, _value;
	var _locdepth;
	
	for (var _i = 1; _i < _argSize; ++_i) {
		
		_value = argument[_i];
		
		if (_depth < 2 || !is_array(_value)) {
			array_push(_build, _value);
			continue;
		}
		
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
	
	ds_stack_destroy(_stack);
	return _build;
}

#endregion

#region find

/// @func UNIT_arrFindByVal(array, value, [index=0])
/// @pure
///
/// @desc Вернёт индекс первого совпадения со значением, если не найдёт вернёт -1.
/// Ищёт слева-направо
///
/// @param {Array<Any>} _array
/// @param {Any} value
/// @param {Real} [index=0]
///
/// @return {Real}
function UNIT_arrFindByVal(_array, _value, _index=0) {
	
	var _size = array_length(_array);
	
	for (; _index < _size; ++_index) {
		if (_array[_index] == _value) {
			return _index;
		}
	}
	
	return -1;
}
	
/// @func UNIT_arrFindByVal(array, value, [index=0])
/// @pure
///
/// @desc Вернёт индекс первого совпадения со значением, если не найдёт вернёт -1.
/// Ищёт справо налево
///
/// @param {Array<Any>} _array
/// @param {Any} value
/// @param {Real} [index=0]
///
/// @return {Real}
function UNIT_arrFindLastByVal(_array, _value, _index) {
	
	for (
		_index = clamp(_index ?? infinity, 0, array_length(_array) - 1); 
		_index >= 0;  
		--_index
	) {
		if (_array[_index] == _value) {
			return _index;	
		}
	}
	
	return -1;
}

/// @func UNIT_arrFindByVal(array, value, [index=0])
/// @pure
///
/// @desc Вернёт существует ли такое значение в магазине
///
/// @param {Array<Any>} _array
/// @param {Any} _value
///
/// @return {Bool}
function UNIT_arrExists(_array, _value) {
	return (UNIT_arrFindByVal(_array, _value) != -1);
}

#endregion

#region range

/// @func UNIT_arrRangeAdd(array, range)
///
/// @desc Добавляет массив в массив
///
/// @param {Array<Any>} array
/// @param {Array<Any>} range
function UNIT_arrRangeAdd(_array, _range) {
	UNIT_arrCop(_array, array_length(_array), _range);
}

/// @func UNIT_arrRangeGet(array, index, [index=max])
/// @pure
///
/// @desc Вернёт указанный промежуток
///
/// @param {Array<Any>} _array
/// @param {Real} _index
/// @param {Real} [_size]
///
/// @return {Array<Any>}
function UNIT_arrRangeGet(_array, _index, _size) {
	_size ??= array_length(_array) - _index;
	
	var _range = array_create(_size);
	array_copy(_range, 0, _array, _index, _size);
	return _range;
}

/// @func UNIT_arrRangeSet(array, index, range)
///
/// @desc Установит промежуток в массив на указанную позицию
///
/// @param {Array<Any>} _array
/// @param {Real} _index
/// @param {Array<Any>} _range
function UNIT_arrRangeSet(_array, _index, _range) {
	UNIT_arrCop(_array, _index, _range);
}

/// @func UNIT_arrRangeInsert(array, index, range)
///
/// @desc Вставит промежуток в массив на указанную позицию
///
/// @param {Array<Any>} _array
/// @param {Real} _index
/// @param {Array<Any>} _range
function UNIT_arrRangeInsert(_array, _index, _range) {
	UNIT_arrIns(_array, _index, _range);
}

#endregion

#region other

/// @func UNIT_arrJoin(array, [separator=","])
///
/// @desc Объединит все значение в строку с указанным разделителем
///
/// @param {Array<Any>} _array
/// @param {String} [_separator]
///
/// @return {String}
function UNIT_arrJoin(_array, _separator=",") {
	var _size = array_length(_array);
	if (_size == 0) {
		return "";	
	}
	
	var _buffer = buffer_create(32, buffer_grow, 1);
	
	buffer_write(_buffer, buffer_text, string(_array[0]));
	
	for (var _i = 1; _i < _size; ++_i) {
		buffer_write(_buffer, buffer_text, _separator);
		buffer_write(_buffer, buffer_text, string(_array[_i]));
	}
	
	buffer_write(_buffer, buffer_u8, 0);
	buffer_seek(_buffer, buffer_seek_start, 0);
	
	var _text = buffer_read(_buffer, buffer_text);
	
	buffer_delete(_buffer);
	
	return _text;
}

#endregion


#region __private

enum ___UNIT_ARRAY_BUL_FLATTEN_FROM {
}

function UNIT_array() {};

#endregion

// zips
// includes
// pad_left
// pad_right
// 

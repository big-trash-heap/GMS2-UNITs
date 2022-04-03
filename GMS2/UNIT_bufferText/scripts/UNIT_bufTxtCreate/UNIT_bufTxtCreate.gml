

/*
	Данные функции являются обёрткой над обычными буферами
	
	Их цель предоставить интерфейс, сигнатура которого,
	подчёркивает их задачу
	
	Задачей данного интерфейса является накопление текста
	и возврат его в виде строки
	
	Кодировка UTF8
*/


/// @param			[size=128]
function UNIT_bufTxtCreate(_size=128) {
	return buffer_create(_size, buffer_grow, 1);
}

/// @function		UNIT_bufTxtAppend(buffer, string);
function UNIT_bufTxtAppend(_buffer, _string) {
	buffer_write(_buffer, buffer_text, _string);
}

/// @function		UNIT_bufTxtPush(buffer, ...strings);
function UNIT_bufTxtPush(_buffer) {
	
	var _argSize = argument_count;
	for (var _i = 1; _i < _argSize; ++_i) 
		buffer_write(_buffer, buffer_text, argument[_i]);
}

/// @description	Возвращает строку записанную в буфере
//
/// @param			buffer
function UNIT_bufTxtRead(_buffer) {
	
	var _anchor = buffer_tell(_buffer);
	buffer_write(_buffer, buffer_u8, 0);
	buffer_seek(_buffer, buffer_seek_start, 0);
	var _string = buffer_read(_buffer, buffer_string);
	buffer_seek(_buffer, buffer_seek_start, _anchor);
	return _string;
}

/// @description	Возвращает строку записанную в буфере
//					и очищает его
//
/// @param			buffer
function UNIT_bufTxtClRead(_buffer) {
	
	buffer_write(_buffer, buffer_u8, 0);
	buffer_seek(_buffer, buffer_seek_start, 0);
	var _string = buffer_read(_buffer, buffer_string);
	buffer_seek(_buffer, buffer_seek_start, 0);
	return _string;
}

/// @function		UNIT_bufTxtClear(buffer, [newsize]);
/// @description	Производит отчистку буферу
//					и изменяет его размер если он был указан
//					Размер может быть изменён, 
//					только в меньшую сторону
function UNIT_bufTxtClear(_buffer, _size) {
	
	buffer_seek(_buffer, buffer_seek_start, 0);
	
	if (!is_undefined(_size) and buffer_get_size(_buffer) > _size)
		buffer_resize(_buffer, _size);
}

/// @description	Удаляет буфер, а так же возвращает
//					строку записанную в нём
//
/// @param			buffer
function UNIT_bufTxtFree(_buffer, _read=true) {
	
	if (_read) {
		buffer_write(_buffer, buffer_u8, 0);
		buffer_seek(_buffer, buffer_seek_start, 0);
		var _string = buffer_read(_buffer, buffer_string);
		buffer_delete(_buffer);
		return _string;
	}
	
	buffer_delete(_buffer);
}

/// @description	Возвращает количество данных в буффере (в байтах)
//
/// @param			buffer
function UNIT_bufTxtSize(_buffer) {
	
	return (buffer_tell(_buffer) + 1);
}

/// @description	Возвращает размер буффера (в байтах)
//
/// @param			buffer
function UNIT_bufTxtCapacity(_buffer) {
	
	return (buffer_get_size(_buffer));
}



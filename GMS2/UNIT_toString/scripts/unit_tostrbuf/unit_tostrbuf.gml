
function UNIT_toStrBuf(_buffer, _maxBytes=50) {
	var _bytes = buffer_get_size(_buffer);
	
	if (_bytes == 0) {
		return "<Buffer >";
	}
	
	var _bytesView = min(_bytes, _maxBytes);
	var _bytesHide = _bytes - _bytesView;
	
	var _bufTxt = buffer_create(_bytesView * 3 + 48, buffer_grow, 1);
	buffer_write(_bufTxt, buffer_text, "<Buffer");
	
	var _u8, _u8Bytes;
	for (var _i = 0; _i < _bytesView; ++_i) {
		
		_u8 = buffer_peek(_buffer, _i, buffer_u8);
		_u8Bytes = string_lower(UNIT_toStrInt(_u8, 16, 2));
		
		buffer_write(_bufTxt, buffer_text, " " + _u8Bytes);
	}
	
	buffer_write(_bufTxt, buffer_text, 
		_bytesHide == 0
			? ">"
			: " ... " + string(_bytesHide) + " more bytes>",
	);
	
	buffer_write(_buffer, buffer_u8, 0);
	buffer_seek(_buffer, buffer_seek_start, 0);
	
	var _string = buffer_read(_buffer, buffer_string);
	
	buffer_delete(_buffer);
	return _string;
}

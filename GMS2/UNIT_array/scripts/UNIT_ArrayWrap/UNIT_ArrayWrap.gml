
function UNIT_arrayWrap(_array = undefined) {
	return new UNIT_ArrayWrap(_array);
}


/// @func UNIT_ArrayWrap([array])
/// @param {Array.Any} array
function UNIT_ArrayWrap(_array) constructor {
	
	self.array = _array;
	
	#region modify
	
	/// UNIT_array
	
	/// @func set(index, value)
	///
	/// @param {Real} index
	/// @param {Any} value
	static set = function(_index, _value) {
		array_set(self.array, _index, _value);
		return self;
	}
	
	/// @func insertEmpty(index, count, [value])
	/// @param {Real} index
	/// @param {Real} count
	/// @param {Any} [value]
	static insertEmpty = function(_index, _count) {
		
		if (argument_count > 2) {
			return UNIT_arrInsEm(self.array, _index, _count, argument[2]);
		} 
		
		return UNIT_arrInsEm(self.array, _index, _count);
	}

	/* number */
	/* impl UNIT_arrUnshift */
	static unshift = function() {
	
		var _argSize = argument_count;
	
		if (!UNIT_arrInsEm(self.array, 0, _argSize)) {
			return 0;
		}
	
		for (var _i = 0; _i < _argSize; ++_i) {
			array_set(self.array, _i, argument[_i]);	
		}
	
		return _argSize;
	}

	/* self */
	/* impl UNIT_arrPlace */
	static place = function(_index) {

		var _count = argument_count - 1;
		if (_count == 0) {
			return;
		}
	
		var _size = array_length(self.array);
	
		_index ??= _size;
		array_resize(self.array, max(_size, _index + _count));
	
		for (var _i = _count - 1; _i >= 0; --_i) {
			array_set(self.array, _index + _i, argument[_i + 2]);
		}
		
		return self;
	}
	
	/* self */
	/* impl array_insert */
	static insert = function(_index) {
		
		if (!UNIT_arrInsEm(self.array, _index, argument_count - 1)) {
			return;	
		}
		
		for (var _i = 1; _i < argument_count; ++_i) {
			array_set(self.array, _index + _i - 1, argument[_i]);	
		}
		
		return self;
	}
	
	/* self */
	/* impl array_push */
	static push = function() {
		
		var _size = array_length(self.array);
		for (var _i = argument_count - 1; _i >= 0; --_i) {
			array_set(self.array, _size + _i, argument[_i]);
		}
		
		return self;
	}
	
	/* self */
	/* impl array_delete */
	static remove = function(_index, _number) {
		
		_number = min(_number ?? infinity, array_length(self.array) - _index);
		
		array_delete(self.array, _index, _number);
		
		return self;
	}
	
	/* self */
	static fill = function(_value, _begin, _end) {
		UNIT_arrFill(self.array, _value, _begin, _end);
		return self;
	}
	
	/* self */
	static slice = function(_index, _count) {
		UNIT_arrSlice(self.array, _index, _count);
		return self;
	}
	
	/* self */
	static reverse = function(_index, _count) {
		UNIT_arrReverse(self.array);
		return self;
	}
	
	/* any */
	static shift = function() {
		return UNIT_arrShift(self.array);
	}
	
	/* self */
	static shuffle = function() {
		UNIT_arrShuffle(self.array);
		return self;
	}
	
	/* self */
	static resize = function(_size) {
		array_resize(self.array, _size);
		return self;
	}
	
	/* self */
	static clear = function() {
		UNIT_arrClear(self.array);
		return self;
	}
	
	/* self */
	static swapRemove = function(_index) {
		UNIT_arrSwapRemove(self.array, _index);
		return self;
	}
	
	/* self */
	static betwCopy = function(_destIndex, _src, _srcIndex, _length) {
		UNIT_arrCop(self.array, _src, _srcIndex, _length);
		return self;
	}
	
	/* self */
	static betwInsert = function(_destIndex, _src, _srcIndex, _length) {
		UNIT_arrIns(self.array, _src, _srcIndex, _length);
		return self;
	}
	
	/* self */
	static rangeAdd = function(_index, _range) {
		UNIT_arrRangeAdd(self.array, _range);
		return self;
	}
	
	/* self */
	static rangeSet = function(_index, _range) {
		UNIT_arrRangeSet(self.array, _index, _range);
		return self;
	}
	
	/* self */
	static rangeInsert = function(_index, _range) {
		UNIT_arrRangeInsert(self.array, _index, _range);
		return self;
	}
	
	/// UNIT_arrayHigher
	
	/// @func map
	/// @param {Function} f
	/// @param {Any} [data]
	static map = function(_f, _data) {
		UNIT_arrMap(self.array, _f, _data);
		return self;
	}
	
	/// @func filter
	/// @param {Function} f
	/// @param {Any} [data]
	static filter = function(_f, _data) {
		UNIT_arrFilter(self.array, _f, _data);
		return self;
	}
	
	#endregion
	
	#region build
	
	/// @func dup1d_
	static dup1d_ = function() {
		return UNIT_arrBulDup1d(self.array);
	}
	
	/* array */
	static flatten_ = function(_depth) {
		return UNIT_arrBulFlatten(self.array, _depth);
	}
	
	/* array */
	static slice_ = function(_index, _count) {
		return UNIT_arrBulSlice(self.array, _index, _count);
	}
	
	/* array */
	static rangeGet_ = function(_index, _length) {
		return UNIT_arrRangeGet(self.array, _index, _length);
	}
	
	/// UNIT_arrayHigher
	
	/* any */
	static map_ = function(_f, _data) {
		return UNIT_arrBulMap(self.array, _f, _data);
	}
	
	/* any */
	static filter_ = function(_f, _data) {
		return UNIT_arrBulFilter(self.array, _f, _data);
	}
	
	#endregion
	
	#region find
	
	#endregion
	
	#region other
	
	/* any */
	static get = function(_index) {
		return array_get(self.array, _index);
	}
	
	/* number */
	static getLength = function() {
		return array_length(self.array);	
	}
	
	#endregion
	
}

function __debug(_assert, _mess) {
	if (!_assert) {
		
		clipboard_set_text("\"" + _mess + "\"");
		throw ("\n\t" + _mess);
	}
}


var _lcheck = function(_id, _array) {
			
			var _idSize = ds_list_size(_id);
			var _size = array_length(_array);
			if (_idSize != _size) return false;
			
			for (var _i = 0; _i < _size; ++_i) {
				
				if (_id[| _i] != _array[_i]) return false;
			}
			
			return true;
		}
		var _id;
		
		#region UNIT_dsListBul
		
		_id = UNIT_dsListBul(0, "Hello", "World", -1, undefined, 32);
		
		__debug(
			_lcheck(_id, [0, "Hello", "World", -1, undefined, 32]),
			"<UNIT_dsListBul 0>"
		);
		
		ds_list_destroy(_id);
		
		_id = UNIT_dsListBul();
		
		__debug(
			_lcheck(_id, []),
			"<UNIT_dsListBul 1>"
		);
		
		ds_list_destroy(_id);
		
		_id = UNIT_dsListBul(1, 2, ".");
		
		__debug(
			_lcheck(_id, [1, 2, "."]),
			"<UNIT_dsListBul 2>"
		);
		
		ds_list_destroy(_id);
		
		show_debug_message("\t UNIT_dsListBul \t\tis work");
		
		#endregion
		
		#region UNIT_dsListToArr
		
		_id = UNIT_dsListBul(0, "Hello", "World", -1, undefined, 32);
		
		__debug(
			array_equals(UNIT_dsListToArr(_id), [0, "Hello", "World", -1, undefined, 32]),
			"<UNIT_dsListToArr 0>"
		);
		
		ds_list_destroy(_id);
		
		_id = UNIT_dsListBul();
		
		__debug(
			array_equals(UNIT_dsListToArr(_id), []),
			"<UNIT_dsListToArr 1>"
		);
		
		ds_list_destroy(_id);
		
		_id = UNIT_dsListBul(1, 2, ".");
		
		__debug(
			array_equals(UNIT_dsListToArr(_id), [1, 2, "."]),
			"<UNIT_dsListToArr 2>"
		);
		
		ds_list_destroy(_id);
		
		show_debug_message("\t UNIT_dsListToArr \t\tis work");
		
		#endregion
		
		#region UNIT_dsListResize
		
		_id = UNIT_dsListBul(0, 1, 2, 3, 4, 5);
		
		UNIT_dsListResize(_id, ds_list_size(_id) + 5);
		
		__debug(
			11 == ds_list_size(_id),
			"<UNIT_dsListResize 0.size>"
		);
		
		__debug(
			_lcheck(_id, [0, 1, 2, 3, 4, 5, 0, 0, 0, 0, 0]),
			"<UNIT_dsListResize 0.data>"
		);
		
		UNIT_dsListResize(_id, ds_list_size(_id) - 7);
		
		__debug(
			4 == ds_list_size(_id),
			"<UNIT_dsListResize 1.size>"
		);
		
		__debug(
			_lcheck(_id, [0, 1, 2, 3]),
			"<UNIT_dsListResize 1.data>"
		);
		
		UNIT_dsListResize(_id, 0);
		
		__debug(
			0 == ds_list_size(_id),
			"<UNIT_dsListResize 2.size>"
		);
		
		__debug(
			_lcheck(_id, []),
			"<UNIT_dsListResize 2.data>"
		);
		
		ds_list_add(_id, 11);
		UNIT_dsListResize(_id, 5);
		
		__debug(
			5 == ds_list_size(_id),
			"<UNIT_dsListResize 3.size>"
		);
		
		__debug(
			_lcheck(_id, [11, 0, 0, 0, 0]),
			"<UNIT_dsListResize 3.data>"
		);
		
		ds_list_destroy(_id);
		
		show_debug_message("\t UNIT_dsListResize \t\tis work");
		
		#endregion
		
		#region UNIT_dsListDel
		
		_id = UNIT_dsListBul(0, 8, 1, 2, 24, 7);
		
		UNIT_dsListDel(_id, 0, 3);
		
		__debug(
			_lcheck(_id, [2, 24, 7]),
			"<UNIT_dsListDel 0>"
		);
		
		ds_list_add(_id, 2, 52, 12, 2);
		
		var _array = [2, 24, 7, 2, 52, 12, 2];
		array_delete(_array, 1, 2);
		array_delete(_array, 3, 3);
		array_delete(_array, 3, 3);
		
		UNIT_dsListDel(_id, 1, 2);
		UNIT_dsListDel(_id, 3, 3);
		
		__debug(
			_lcheck(_id, _array),
			"<UNIT_dsListDel 1>"
		);
		
		array_push(_array, 1, 23, 234, 519, "h", undefined);
		ds_list_add(_id, 1, 23, 234, 519, "h", undefined);
		
		array_delete(_array, 1, 2);
		array_delete(_array, 1, 2);
		array_delete(_array, 3, 2);
		
		UNIT_dsListDel(_id, 1, 2);
		UNIT_dsListDel(_id, 1, 2);
		UNIT_dsListDel(_id, 3, 2);
		
		__debug(
			_lcheck(_id, _array),
			"<UNIT_dsListDel 2>"
		);
		
		array_delete(_array, array_length(_array), 5);
		UNIT_dsListDel(_id, ds_list_size(_id), 5);
		
		__debug(
			_lcheck(_id, _array),
			"<UNIT_dsListDel 3>"
		);
		
		ds_list_destroy(_id);
		
		show_debug_message("\t UNIT_dsListDel \t\tis work");
		
		#endregion
	
	
	show_debug_message(
			"<API TEST>\n\t" + "apiScrDsListHigher"
		);
		
		var _lcheck = function(_id, _array) {
			
			var _idSize = ds_list_size(_id);
			var _size = array_length(_array);
			if (_idSize != _size) return false;
			
			for (var _i = 0; _i < _size; ++_i) {
				
				if (_id[| _i] != _array[_i]) return false;
			}
			
			return true;
		}

		var _f = function(_value) { return _value > 5; };
		var _id0 = UNIT_dsListBul(1, 8, 4, 1, 10, 20, -1, 3, 7, 11, 1);
		var _id1 = UNIT_dsListBul(1, "hello", 1, 2, undefined, "world", [], {}, 123, 1);
		
		#region UNIT_dsListFilter
		
		UNIT_dsListFilter(_id0, _f);
		
		__debug(
			array_equals(UNIT_dsListToArr(_id0), [8, 10, 20, 7, 11]),
			"<UNIT_dsListFilter 0>"
		);
		
		UNIT_dsListFilter(_id1, is_string);
		
		__debug(
			array_equals(UNIT_dsListToArr(_id1), ["hello", "world"]),
			"<UNIT_dsListFilter 1>"
		);
		
		ds_list_destroy(_id0);
		ds_list_destroy(_id1);
		
		show_debug_message("\t UNIT_dsListFilter  \t\tis work");
		
		#endregion
		
//rework

/* может выделить память под ds_ */

#macro UNIT_PREPROCESSOR_PRAGMA_LOG	true

/// @function		UNIT_pragma(name, dependencies, f);
function UNIT_pragma(_name, _dependencies, _f) {
	if (__UNIT_pragma()) {
		
		ds_priority_add(global.__UNIT_queue_data, [
			_f,
			_data,
		], _priority);
		
		return;
	}
	
	show_error(__UNIT_PRAGMA_ERROR, true);
}

/*
	Эта функция вызовет весь добавленный в очередь код
	Она также освободит память
	Вы должны использовать её только 1 раз, и только в объектах
*/
function UNIT_pragmaExecute() {
	if (__UNIT_pragma()) {
		
		var _data;
		while (!ds_priority_empty(global.__UNIT_queue_data)) {
			
			_data = ds_priority_delete_min(global.__UNIT_queue_data);
			_data[___UNIT_PRAGMA_CELL._F](_data[___UNIT_PRAGMA_CELL._VALUE]);
		}
		
		ds_priority_destroy(global.__UNIT_queue_data);
		global.__UNIT_queue_data = -1;
		
		if (UNIT_PREPROCESSOR_PRAGMA_LOG) {
		
		show_debug_message("UNIT::pragma -> память под очередь была освобожденна");
		
		}
		
		return;
	}
	
	show_error(__UNIT_PRAGMA_ERROR, true);
}


#region __private

#macro __UNIT_PRAGMA_ERROR "UNIT::pragma -> очередь уже использована"

enum ___UNIT_PRAGMA_CELL { _F, _NAME, _DEPENDENCIES };

function __UNIT_pragma() {
	static _void = function() {
		global.__UNIT_names = ds_map_create();
		
		if (UNIT_PREPROCESSOR_PRAGMA_LOG) {
		
		show_debug_message("UNIT::pragma -> память под очередь была выделена");
		
		}
	}();
	return (global.__UNIT_queue_data >= 0);
}

#endregion


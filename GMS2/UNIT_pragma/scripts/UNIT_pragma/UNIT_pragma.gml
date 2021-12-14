/* может выделить память под ds_ */

#macro UNIT_PRAGMA_LOG	true

/// @function		UNIT_pragma(f, [priority=0], [data]);
function UNIT_pragma(_f, _priority=0, _data) {
	if (__UNIT_pragma()) {
		
		ds_priority_add(global.__UNIT_pragma_data, [
			_f,
			_data,
		], _priority);
		
		return;
	}
	
	show_error(____UNIT_PRAGMA_ERROR, true);
}

function UNIT_pragmaExecute() {
	if (__UNIT_pragma()) {
		
		var _data;
		while (!ds_priority_empty(global.__UNIT_pragma_data)) {
			
			_data = ds_priority_delete_min(global.__UNIT_pragma_data);
			_data[0](_data[1]);
		}
		
		ds_priority_destroy(global.__UNIT_pragma_data);
		global.__UNIT_pragma_data = -1;
		
		if (UNIT_PRAGMA_LOG) {
		
		show_debug_message("UNIT::pragma -> память под очередь была освобожденна");
		
		}
		
		return;
	}
	
	show_error(____UNIT_PRAGMA_ERROR, true);
}


#region __private

#macro ____UNIT_PRAGMA_ERROR "UNIT::pragma -> очередь уже использована"

function __UNIT_pragma() {
	static _void = function() {
		global.__UNIT_pragma_data = ds_priority_create();
		
		if (UNIT_PRAGMA_LOG) {
		
		show_debug_message("UNIT::pragma -> память под очередь было выделена");
		
		}
	}();
	return (global.__UNIT_pragma_data >= 0);
}

#endregion


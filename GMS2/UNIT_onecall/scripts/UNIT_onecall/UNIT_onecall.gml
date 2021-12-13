/* может выделить память под ds_ */

#macro UNIT_ONECALL_LOG	true

#macro UNIT_ONE		if(__UNIT_onecall(
#macro UNIT_CALL	))exit

function UNIT_onecallFree() {
	if (__UNIT_onecallData()) {
		
		ds_map_destroy(global.__UNIT_onecall_data);
		global.__UNIT_onecall_data = -1;
		
		if (UNIT_ONECALL_LOG) {
		
		show_debug_message("UNIT::onecall -> память под словарь была освобождена");
		
		}
		
		return;
	}
	
	show_error(____UNIT_onecall__error, true);
}


#region __private

#macro ____UNIT_onecall__error	"UNIT::onecall -> был освобождён и не может быть использован повторно"

function __UNIT_onecall(_value) {
	if (__UNIT_onecallData()) {
		
		if (ds_map_exists(global.__UNIT_onecall_data, _value)) return true;
		
		global.__UNIT_onecall_data[? _value] = undefined;
		return false;
	}
	
	show_error(____UNIT_onecall__error, true);
}

function __UNIT_onecallData(_value) {
	static _void = function() {
		global.__UNIT_onecall_data = ds_map_create();
		
		if (UNIT_ONECALL_LOG) {
		
		show_debug_message("UNIT::onecall -> память под словарь была выделена");
		
		}
	}();
	return (global.__UNIT_onecall_data >= 0);
}

function UNIT_onecall() {};

#endregion


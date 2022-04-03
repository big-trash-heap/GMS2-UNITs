/* может выделить память под ds_ */

#macro UNIT_PREPROCESSOR_ONECALL_LOG	true

#macro UNIT_ONE		if(__UNIT_onecall(
#macro UNIT_CALL	))exit

/*
	Эта функция очистит память
	Вы должны использовать её только 1 раз, и только в объектах
*/
function UNIT_onecallFree() {
	if (__UNIT_onecallData()) {
		
		ds_map_destroy(global.__UNIT_onecall_data);
		global.__UNIT_onecall_data = -1;
		
		if (UNIT_PREPROCESSOR_ONECALL_LOG) {
		
		show_debug_message("UNIT::onecall -> память под словарь была освобождена");
		
		}
		
		return;
	}
	
	show_error(__UNIT_ONECALL_ERROR, true);
}


#region __private

#macro __UNIT_ONECALL_ERROR	"UNIT::onecall -> был освобождён и не может быть использован повторно"

function __UNIT_onecall(_value) {
	if (__UNIT_onecallData()) {
		
		if (ds_map_exists(global.__UNIT_onecall_data, _value)) return true;
		
		global.__UNIT_onecall_data[? _value] = undefined;
		return false;
	}
	
	show_error(__UNIT_ONECALL_ERROR, true);
}

function __UNIT_onecallData(_value) {
	static _void = function() {
		global.__UNIT_onecall_data = ds_map_create();
		
		if (UNIT_PREPROCESSOR_ONECALL_LOG) {
		
		show_debug_message("UNIT::onecall -> память под словарь была выделена");
		
		}
	}();
	return (global.__UNIT_onecall_data >= 0);
}

#endregion


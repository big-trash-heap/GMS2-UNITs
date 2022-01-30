
/*
	Данное решение не относится к базовым и представленно как дополнение

	Глобальный интерфейс для удобной простой и удобной работы
	Необходимо вызывать UNIT_tmGlobalTick каждый шаг для работы
	
	Данный файл можно удалить, он не влияет на работу остальных скриптов
*/

/// @description	Получение глобального обработчика
function UNIT_tmGlobal() {
	static _handler = new __UNIT_TmHandlerGlobal();
	return _handler;
}

/// @param			[super]
/// @description	Итератор глобального обработчика
function UNIT_tmGlobalTick(_super) {
	static _handler = UNIT_tmGlobal();
	_handler.tick(_super);
}


/// @function		UNIT_tmGl_timer(timer);
function UNIT_tmGl_timer(_timer) {
	return UNIT_tmGlobal().bind(_timer);
}

/// @function		UNIT_tmGl_loop([ftick], [finit], [ffree]);
function UNIT_tmGl_loop(_ftick, _finit, _ffree) {
	return UNIT_tmGlobal().newLoop(_ftick, _finit, _ffree);
}

/// @function		UNIT_tmGl_loopAsync([ftick], [finit], [ffree]);
function UNIT_tmGl_loopAsync(_ftick, _finit, _ffree) {
	return UNIT_tmGlobal().newLoopAsync(_ftick, _finit, _ffree);
}

/// @function		UNIT_tmGl_sync(steps, [ftick], [finit], [ffree]);
function UNIT_tmGl_sync(_steps, _ftick, _finit, _ffree) {
	return UNIT_tmGlobal().newSync(_steps, _ftick, _finit, _ffree);
}

/// @function		UNIT_tmGl_async(milisec, [ftick], [finit], [ffree]);
function UNIT_tmGl_async(_milisec, _ftick, _finit, _ffree) {
	return UNIT_tmGlobal().newAsync(_milisec, _ftick, _finit, _ffree);
}

/// @function		UNIT_tmGl_endSync(steps, f);
function UNIT_tmGl_endSync(_steps, _f) {
	return UNIT_tmGlobal().newEndSync(_steps, _f);
}

/// @function		UNIT_tmGl_endAsync(milisec, f);
function UNIT_tmGl_endAsync(_milisec, _f) {
	return UNIT_tmGlobal().newEndAsync(_milisec, _f);
}


#region __private

function __UNIT_TmHandlerGlobal() : UNIT_TmHandlerSimpleExt() constructor {
	
	static toString = function() {
		return ("UNIT::timer::UNIT_tmGlobal; number of timers: " + string(self.__count));
	}
	
	
	static _clone = function() {
		if (UNIT_PREPROCESSOR_TM_ENABLE_CLONE) {
		
		show_error("UNIT::timer::UNIT_tmGlobal -> клонирование запрещено", true);
		
		}
		else {
		
		show_error(____UNIT_TM_ERROR_CLONE, true);
		
		}
	}
	
	static __info_bind = function(_timer) {
		if (UNIT_PREPROCESSOR_TM_HANDLER_ENABLE_INFORMING_BINDING
			&& UNIT_PREPROCESSOR_TM_ENABLE_LOG) {
		
		show_debug_message("UNIT::timer::UNIT_tmGlobal.bind(" + string(_timer) + ");");
		
		}
	}
	
	static __info_unbind = function(_timer) {
		if (UNIT_PREPROCESSOR_TM_HANDLER_ENABLE_INFORMING_BINDING
			&& UNIT_PREPROCESSOR_TM_ENABLE_LOG) {
		
		show_debug_message("UNIT::timer::UNIT_tmGlobal.unbind(" + string(_timer) + ");");
		
		}
	}
	
}

#endregion


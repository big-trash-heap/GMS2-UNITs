
/*
	Глобальный интерфейс для удобной простой и удобной работы
*/

function UNIT_timerGlobal() {
	static _handler = new UNIT_TimersHandler();
	return _handler;
}

/// @param			UNIT_timerGlobalTick(super);
function UNIT_timerGlobalTick(_super) {
	static _handler = UNIT_timerGlobal();
	_handler.tick(_super);
}

/// @function		UNIT_timerGl_timer(timer, [argument]);
function UNIT_timerGl_timer(_timer, _argument) {
	static _handler = UNIT_timerGlobal();
	return _handler.bind(_timer, _argument);
}

/// @function		UNIT_timerGl_loop(steps, [ftick], [finit], [ffree], [argument]);
function UNIT_timerGl_loop(_ftick, _finit, _ffree, _argument) {
	return UNIT_timerGl_timer(new UNIT_TimerLoop(_ftick, _finit, _ffree), _argument);
}

/// @function		UNIT_timerGl_sync(steps, [ftick], [finit], [ffree], [argument]);
function UNIT_timerGl_sync(_steps, _ftick, _finit, _ffree, _argument) {
	return UNIT_timerGl_timer(new UNIT_TimerSyncExt(_steps, _ftick, _finit, _ffree), _argument);
}

/// @function		UNIT_timerGl_syncEnd(steps, f);
function UNIT_timerGl_syncEnd(_steps, _f) {
	return UNIT_timerGl_timer(new UNIT_TimerSyncExt(_steps, undefined, undefined, _f), undefined);
}

/// @function		UNIT_timerGl_async(milisec, [ftick], [finit], [ffree], [argument]);
function UNIT_timerGl_async(_milisec, _ftick, _finit, _ffree, _argument) {
	return UNIT_timerGl_timer(new UNIT_TimerAsyncExt(_milisec, _ftick, _finit, _ffree), _argument);
}

/// @function		UNIT_timerGl_asyncEnd(milisec, f);
function UNIT_timerGl_asyncEnd(_milisec, _f) {
	return UNIT_timerGl_timer(new UNIT_TimerAsyncExt(_milisec, undefined, undefined, _f), undefined);
}


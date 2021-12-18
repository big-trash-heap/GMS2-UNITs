

function UNIT_timerGlobal() {
	static _handler = new UNIT_TimersHandler();
	return _handler;
}

function UNIT_timerGlobalTick(_super) {
	static _handler = UNIT_timerGlobal();
	_handler.tick(_super);
}


function UNIT_timerGl_timer(_timer, _argument) {
	static _handler = UNIT_timerGlobal();
	return _handler.append(_timer, _argument);
}

function UNIT_timerGl_loop(_ftick, _finit, _fkill, _argument) {
	return UNIT_timerGl_timer(new UNIT_TimerLoop(_ftick, _finit, _fkill), _argument);
}

function UNIT_timerGl_sync(_steps, _ftick, _finit, _fkill, _argument) {
	return UNIT_timerGl_timer(new UNIT_TimerSyncExt(_steps, _ftick, _finit, _fkill), _argument);
}

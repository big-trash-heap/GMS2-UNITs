
/*
	finit = function(handler, timer);
	ftick = function(handler, timer, super, milisec_step);
	ffree = function(handler, timer);
*/

/*
	Данное решение не относится к базовым и представленно как дополнение
*/


/// @function		UNIT_TimerLoopAsync([ftick], [finit], [ffree]);
/// @description	Зацикленный асинхронный таймер
function UNIT_TimerLoopAsync(_ftick, _finit, _ffree) : UNIT_TimerLoop(undefined, undefined, _ffree) constructor {
	
	#region __private
	
	static __finit = __UNIT_timerVoid;
	
	if (_finit != undefined) self.__finit = _finit;
	if (_ftick != undefined) self.__ftick = _ftick;
	
	static __init = __UNIT_timerLoopAsyncInit;
	static __tick = function(_handler, _timer, _super) {
		var _ctime = current_time;
		var _diff = _ctime - self.__ctime;
		
		self.__ctime = _ctime;
		return self.__ftick(_handler, _timer, _super, _diff);
	}
	
	#endregion
	
	static _get_finit = __UNIT_timerLoopAsync_finit;
	static _get_ftick = function() {
		return self.__ftick;
	}
	
	
	static _clone = function() {
		if (UNIT_PREPROCESSOR_TIMER_ENABLE_CLONE) {
		
		return new UNIT_TimerLoopAsync(self.__tick, self.__init, self.__free).__copyn_(self);
		
		}
		else {
		
		show_error(____UNIT_TIMER_ERROR_CLONE, true);
		
		}
	}
	
}

/// @function		UNIT_TimerLoopAsyncExt([ftick], [finit], [ffree]);
/// @description	Зацикленный асинхронный таймер
function UNIT_TimerLoopAsyncExt(_ftick, _finit, _ffree) : UNIT_TimerLoopExt(_ftick, undefined, _ffree) constructor {
	
	#region __private
	
	static __finit = __UNIT_timerVoid;
	
	if (_finit != undefined) self.__finit = _finit;
	if (_ftick != undefined) self.__ftick = _ftick;
	
	static __init = __UNIT_timerLoopAsyncInit;
	static __tick = function(_handler, _timer, _super) {
		var _ctime = current_time;
		if (self.__play) {
			
			var _diff = _ctime - self.__ctime;
			
			self.__ctime = _ctime;
			return self.__ftick(_handler, _timer, _super, _diff);
		} else {
			self.__ctime = _ctime;
		}
	}
	
	#endregion
	
	static resume = function() {
		if (not self.__play) {
			self.__play  = true;
			self.__ctime = current_time;
		}
		return self;
	}
	
	
	static _get_finit = __UNIT_timerLoopAsync_finit;
	
	static _clone = function() {
		if (UNIT_PREPROCESSOR_TIMER_ENABLE_CLONE) {
		
		var _timer = new UNIT_TimerLoopAsyncExt(self.__ftick, self.__init, self.__free);
		_timer.__play = self.__play;
		return _timer.__copyn_(self);
		
		}
		else {
		
		show_error(____UNIT_TIMER_ERROR_CLONE, true);
		
		}
	}
	
}


#region __private

function __UNIT_timerLoopAsyncInit(_handler, _timer) {
	self.__ctime = current_time;
	self.__finit(_handler, _timer);
}

function __UNIT_timerLoopAsync_finit() {
	return self.__finit;
}

#endregion



/*
	finit = function(handler, timer);
	ftick = function(handler, timer, super, milisec_step);
	ffree = function(handler, timer, inTick);
*/

/*
	Данное решение не относится к базовым и представленно как дополнение
*/


/// @function		UNIT_TimerLoopAsync([ftick], [finit], [ffree]);
/// @description	Зацикленный асинхронный таймер
function UNIT_TimerLoopAsync(_ftick, _finit, _ffree) : UNIT_TimerLoop(undefined, undefined, _ffree) constructor {
	
	#region __private
	
	static __set_finit = __UNIT_timerOverride_set_finit;
	static __set_ftick = __UNIT_timerOverride_set_ftick;
	
	static __finit = __UNIT_timerVoid;
	static __ftick = __UNIT_timerVoid;
	
	static __init = __UNIT_timerLoopAsyncInit;
	static __tick = function(_handler, _timer, _super) {
		var _ctime = current_time;
		var _diff = _ctime - _timer.__ctime;
		
		_timer.__ctime = _ctime;
		return _timer.__ftick(_handler, _timer, _super, _diff);
	}
	
	self.__set_finit(_finit);
	self.__set_ftick(_ftick);
	
	#endregion
	
	static _get_finit = __UNIT_timerOverride_get_finit;
	static _get_ftick = __UNIT_timerOverride_get_ftick;
	
	
	static _clone = function() {
		if (UNIT_PREPROCESSOR_TIMER_ENABLE_CLONE) {
		
		return new UNIT_TimerLoopAsync(self.__ftick, self.__finit, self.__free).__copyn_(self);
		
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
	
	static __set_finit = __UNIT_timerOverride_set_finit;
	
	static __finit = __UNIT_timerVoid;
	
	static __init = __UNIT_timerLoopAsyncInit;
	static __tick = function(_handler, _timer, _super) {
		var _ctime = current_time;
		if (_timer.__play) {
			
			var _diff = _ctime - _timer.__ctime;
			
			_timer.__ctime = _ctime;
			return _timer.__ftick(_handler, _timer, _super, _diff);
		} else {
			_timer.__ctime = _ctime;
		}
	}
	
	self.__set_finit(_finit);
	
	#endregion
	
	static resume = function() {
		if (not self.__play) {
			self.__play  = true;
			self.__ctime = current_time;
		}
		return self;
	}
	
	
	static _get_finit = __UNIT_timerOverride_get_finit;
	
	static _clone = function() {
		if (UNIT_PREPROCESSOR_TIMER_ENABLE_CLONE) {
		
		var _timer = new UNIT_TimerLoopAsyncExt(self.__ftick, self.__finit, self.__free);
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
	_timer.__ctime = current_time;
	_timer.__finit(_handler, _timer);
}

#endregion


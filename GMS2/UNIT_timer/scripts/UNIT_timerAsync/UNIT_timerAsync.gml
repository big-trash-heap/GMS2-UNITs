
/*
	finit = function(handler, timer);
	ftick = function(handler, timer, super, milisec_step);
	ffree = function(handler, timer, inTick);
*/

/*
	Данное решение не относится к базовым и представленно как дополнение
	
	Изначально асинхронные таймеры, были реализованы через 1 функцию tick (точно так же как и синхронные)
	У таких таймеров, было общее асинхронное время за 1 игровой кадр (что не совсем правильно, но очень красиво и просто)
	
	Я бы оставил старое решение, но я не могу его добавить, так как это вышло за предел UNIT-а
*/


/// @function		UNIT_TimerAsync(milisec, [ftick], [finit], [ffree]);
/// @description	Асинхронный таймер
function UNIT_TimerAsync(_milisec, _ftick, _finit, _ffree) : __UNIT_TimerTimelapse(_milisec, _ftick, undefined, _ffree) constructor {
	
	#region __private
	
	static __set_finit = __UNIT_timerAsync_set_finit;
	
	static __finit = __UNIT_timerVoid;
	
	static __init = __UNIT_timerAsyncInit;
	static __tick = __UNIT_timerAsyncTick;
	
	self.__set_finit(_finit);
	
	#endregion
	
	static resume = __UNIT_timerAsyncResume;
	
	
	static _get_finit = __UNIT_timerAsync_finit;
	
	
	static _clone = function() {
		if (UNIT_PREPROCESSOR_TIMER_ENABLE_CLONE) {
		
		return self.__clone(UNIT_TimerAsync);
		
		}
		else {
		
		show_error(____UNIT_TIMER_ERROR_CLONE, true);
		
		}
	}
	
}

/// @function		UNIT_TimerAsyncExt(milisec, [ftick], [finit], [ffree]);
/// @description	Асинхронный таймер
function UNIT_TimerAsyncExt(_milisec, _ftick, _finit, _ffree) : __UNIT_TimerTimelapseExt(_milisec, _ftick, undefined, _ffree) constructor {
	
	#region __private
	
	static __set_finit = __UNIT_timerAsync_set_finit;
	
	static __finit = __UNIT_timerVoid;
	
	static __init = __UNIT_timerAsyncInit;
	static __tick = __UNIT_timerAsyncTick;
	
	self.__set_finit(_finit);
	
	#endregion
	
	static resume = __UNIT_timerAsyncResume;
	
	static resetTime = function(_play=true) {
		var _sign = sign(self.__step);
		if (_sign == 0) _sign = (_play ? 1 : -1);
		if (self.__step <= 0 && _sign == 1) self.__ctime = current_time;
		self.__step = self.__max_step * _sign;
		return self;
	}
	
	
	static _get_finit = __UNIT_timerAsync_finit;
	
	
	static _clone = function() {
		if (UNIT_PREPROCESSOR_TIMER_ENABLE_CLONE) {
		
		return self.__clone(UNIT_TimerAsyncExt);
		
		}
		else {
		
		show_error(____UNIT_TIMER_ERROR_CLONE, true);
		
		}
	}
	
}


#region __private

function __UNIT_timerAsyncInit(_handler, _timer) {
	_timer.__ctime = current_time;
	_timer.__finit(_handler, _timer);
}

function __UNIT_timerAsyncTick(_handler, _timer, _super) {
	if (_timer.__step > 0) {
		
		var _ctime = current_time;
		var _step = _ctime - _timer.__ctime;
		
		if (_timer.__step > _step) {
			_timer.__step -= _step;
		}
		else {
			_step = _timer.__step;
			_timer.__step = 0;
		}
		
		_timer.__ctime = _ctime;
		_timer.__ftick(_handler, _timer, _super, _step);
		return (_timer.__step == 0);
	}
}

function __UNIT_timerAsyncResume() {
	if (self.__step < 0) {
		self.__step = -self.__step;
		self.__ctime = current_time;
	}
	return self;
}

function __UNIT_timerAsync_finit() {
	return self.__finit;
}

function __UNIT_timerAsync_set_finit(_f) {
	self.__set_f("__finit", _f);
}

#endregion



/*
	finit = finit(handler, timer, argument);
	ftick = finit(handler, timer, super, milisec_step);
	ffree = finit(handler, timer);
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
	
	static __finit = UNIT_timerAsync;
	if (_finit != undefined) self.__finit = _finit;
	
	static __init = __UNIT_timerAsyncInit;
	static __tick = __UNIT_timerAsyncTick;
	
	#endregion
	
	static resume = __UNIT_timerAsyncResume;
	static _get_finit = __UNIT_timerAsync_finit;
	
}

/// @function		UNIT_TimerAsyncExt(milisec, [ftick], [finit], [ffree]);
/// @description	Асинхронный таймер
function UNIT_TimerAsyncExt(_milisec, _ftick, _finit, _ffree) : __UNIT_TimerTimelapseExt(_milisec, _ftick, undefined, _ffree) constructor {
	
	#region __private
	
	static __finit = UNIT_timerAsync;
	if (_finit != undefined) self.__finit = _finit;
	
	static __init = __UNIT_timerAsyncInit;
	static __tick = __UNIT_timerAsyncTick;
	
	#endregion
	
	static resume = __UNIT_timerAsyncResume;
	static _get_finit = __UNIT_timerAsync_finit;
	
	static resetTime = function(_play=true) {
		var _sign = sign(self.__step);
		if (_sign == 0) _sign = (_play ? 1 : -1);
		if (self.__step <= 0 && _sign == 1) self.__ctime = current_time;
		self.__step = self.__max_step * _sign;
		return self;
	}
	
}


#region __private

function __UNIT_timerAsyncInit(_handler, _timer, _argument) {
	self.__ctime = current_time;
	self.__finit(_handler, _timer, _argument);
}

function __UNIT_timerAsyncTick(_handler, _timer, _super) {
	if (self.__step > 0) {
		
		var _ctime = current_time;
		var _step = _ctime - self.__ctime;
		
		if (self.__step > _step) {
			self.__step -= _step;
		}
		else {
			_step = self.__step;
			self.__step = 0;
		}
		
		self.__ctime = _ctime;
		self.__ftick(_handler, _timer, _super, _step);
		return (self.__step == 0);
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

function UNIT_timerAsync() {};

#endregion


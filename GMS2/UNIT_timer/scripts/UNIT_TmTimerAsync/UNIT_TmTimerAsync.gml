
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


/// @function		UNIT_TmTimerAsync(milisec, [ftick], [finit], [ffree]);
/// @description	Асинхронный таймер
function UNIT_TmTimerAsync(_milisec, _ftick, _finit, _ffree) : __UNIT_TmTimerTimelapse(_milisec, _ftick, undefined, _ffree) constructor {
	
	#region __private
	
	static __set_finit = __UNIT_tmOverride_set_finit;
	
	static __finit = __UNIT_tmVoid;
	
	static __init = __UNIT_tmAsyncInit;
	static __tick = __UNIT_tmAsyncTick;
	
	self.__set_finit(_finit);
	
	#endregion
	
	static resume = __UNIT_tmAsyncResume;
	
	
	static _get_finit = __UNIT_tmOverride_get_finit;
	
	
	static _clone = function() {
		if (UNIT_PREPROCESSOR_TM_ENABLE_CLONE) {
		
		return self.__clone(UNIT_TmTimerAsync);
		
		}
		else {
		
		show_error(____UNIT_TM_ERROR_CLONE, true);
		
		}
	}
	
}

/// @function		UNIT_TmTimerAsyncExt(milisec, [ftick], [finit], [ffree]);
/// @description	Асинхронный таймер
function UNIT_TmTimerAsyncExt(_milisec, _ftick, _finit, _ffree) : __UNIT_TmTimerTimelapseExt(_milisec, _ftick, undefined, _ffree) constructor {
	
	#region __private
	
	static __set_finit = __UNIT_tmOverride_set_finit;
	
	static __finit = __UNIT_tmVoid;
	
	static __init = __UNIT_tmAsyncInit;
	static __tick = __UNIT_tmAsyncTick;
	
	self.__set_finit(_finit);
	
	#endregion
	
	static resume = __UNIT_tmAsyncResume;
	
	static resetTime = function(_play=true) {
		var _sign = sign(self.__step);
		if (_sign == 0) _sign = (_play ? 1 : -1);
		if (self.__step <= 0 && _sign == 1) self.__ctime = current_time;
		self.__step = self.__max_step * _sign;
		return self;
	}
	
	
	static _get_finit = __UNIT_tmOverride_get_finit;
	
	
	static _clone = function() {
		if (UNIT_PREPROCESSOR_TM_ENABLE_CLONE) {
		
		return self.__clone(UNIT_TmTimerAsyncExt);
		
		}
		else {
		
		show_error(____UNIT_TM_ERROR_CLONE, true);
		
		}
	}
	
}


#region __private

function __UNIT_tmAsyncInit(_handler, _timer) {
	_timer.__ctime = current_time;
	_timer.__finit(_handler, _timer);
}

function __UNIT_tmAsyncTick(_handler, _timer, _super) {
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
		
		#region PREPROCESSOR
		____UNIT_TM_SKIP_VOID_TICK_TIMELAPSE;
		#endregion
		
		if (_timer.__ftick(_handler, _timer, _super, _step) == true) {
			return true;	
		}
		
		return (_timer.__step == 0);
	}
}

function __UNIT_tmAsyncResume() {
	if (self.__step < 0) {
		self.__step = -self.__step;
		self.__ctime = current_time;
	}
	return self;
}

#endregion


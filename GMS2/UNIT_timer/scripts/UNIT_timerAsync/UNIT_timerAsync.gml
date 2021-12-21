

/// @function		UNIT_TimerAsync(milisec, [ftick], [finit], [ffree]);
/// @description	Асинхронный таймер
function UNIT_TimerAsync(_milisec, _ftick=undefined, _finit=undefined, _ffree=undefined) : UNIT_Timer() constructor {
	
	#region __private
	
	static __finit = UNIT_timerAsync;
	static __ftick = UNIT_timerAsync;
	
	self.__step = ceil(abs(_milisec)) * sign(_milisec);
	
	if (_ffree != undefined) self.__free = _ffree;
	
	if (_finit != undefined) self.__finit = _finit;
	if (_ftick != undefined) self.__ftick = _ftick;
	
	static __init = function(_handler, _timer, _argument) {
		self.__ctime = current_time;
		self.__finit(_handler, _timer, _argument);
	}
	
	static __tick = function(_handler, _timer, _super) {
		
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
	
	#endregion
	
	static setTime = function(_milisec) {
		self.__step = ceil(abs(_milisec)) * sign(_milisec);
		return self;
	}
	
	static getTime = function() {
		return abs(self.__step);
	}
	
	static pause = function() {
		if (self.__step > 0) self.__step = -self.__step;
		return self;
	}
	
	static resume = function() {
		if (self.__step < 0) {
			self.__step = -self.__step;
			self.__ctime = current_time;
		}
		return self;
	}
	
	static isPause = function() {
		return (self.__step < 0);
	}
	
	static isPlay = function() {
		return (self.__step > 0);
	}
	
	static isEnd = function() {
		return (self.__step == 0);
	}
	
	static _get_finit = function() {
		return self.__finit;
	}
	
	static _get_ftick = function() {
		return self.__ftick;
	}
	
}

/// @function		UNIT_TimerAsyncExt(milisec, [ftick], [finit], [ffree]);
/// @description	Асинхронный таймер, с большим функционалом
function UNIT_TimerAsyncExt(_milisec, _ftick, _finit, _ffree) : UNIT_TimerAsync(_milisec, _ftick, _finit, _ffree) constructor {

	#region __private
	
	self.__max_step = abs(self.__step);
	
	#endregion
	
	static setTime = function(_milisec) {
		self.__step = ceil(abs(_milisec)) * sign(_milisec);
		self.__max_step = abs(self.__step);
		return self;
	}
	
	static getTimeMax = function() {
		return self.__max_step;
	}
	
	static getPast = function() {
		return (self.__max_step - abs(self.__step));
	}
	
	static getLeft = self.getTime;
	
	static getPastCf = function() {
		return (1 - abs(self.__step) / self.__max_step);
	}
	
	static getLeftCf = function() {
		return (abs(self.__step) / self.__max_step);
	}
	
	static resetTime = function(_play=true) {
		var _sign = sign(self.__step);
		if (_sign == 0) _sign = (_play ? 1 : -1);
		if (self.__step <= 0 && _sign == 1) self.__ctime = current_time;
		self.__step = self.__max_step * _sign;
		return self;
	}
	
}


#region __private

function UNIT_timerAsync() {};

#endregion


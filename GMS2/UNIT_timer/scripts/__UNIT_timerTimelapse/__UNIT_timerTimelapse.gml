
/*
	Идея в том, что тут необходимо переопределить только метод tick
*/

function __UNIT_timerTimelapse() {};

function __UNIT_TimerTimelapse(_steps, _ftick=undefined, _finit=undefined, _ffree=undefined) : UNIT_Timer() constructor {
	
	#region __private
	
	static __ftick = __UNIT_timerTimelapse;
	
	self.__step = ceil(abs(_steps)) * sign(_steps);
	
	if (_finit != undefined) self.__init = _finit;
	if (_ffree != undefined) self.__free = _ffree;
	
	if (_ftick != undefined) self.__ftick = _ftick;
	
	#endregion
	
	static setTime = function(_steps) {
		self.__step = ceil(abs(_steps)) * sign(_steps);
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
		if (self.__step < 0) self.__step = -self.__step;
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
	
	
	static _get_ftick = function() {
		return self.__ftick;
	}
	
}

function __UNIT_TimerTimelapseExt(_steps, _ftick, _finit, _ffree) : __UNIT_TimerTimelapse(_steps, _ftick, _finit, _ffree) constructor {
	
	#region __private
	
	self.__max_step = abs(self.__step);
	
	#endregion
	
	static setTime = function(_steps) {
		self.__step = ceil(abs(_steps)) * sign(_steps);
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
	
	static resetTime = function(_play=false) {
		var _sign = sign(self.__step);
		if (_sign == 0) _sign = (_play ? 1 : -1);
		self.__step = self.__max_step * _sign;
		return self;
	}
	
}


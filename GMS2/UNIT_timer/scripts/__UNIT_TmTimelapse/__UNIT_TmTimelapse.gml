
/*
	Идея в том, что тут необходимо переопределить только метод tick
*/

function __UNIT_TmTimerTimelapse(_steps, _ftick=undefined, _finit=undefined, _ffree=undefined) : UNIT_TmTimer() constructor {
	
	#region __private
	
	static __set_ftick = __UNIT_tmOverride_set_ftick;
	
	static __ftick = __UNIT_tmVoid;
	
	self.__step = ceil(abs(_steps)) * sign(_steps);
	
	self.__set_finit(_finit);
	self.__set_ftick(_ftick);
	self.__set_ffree(_ffree);
	
	static __clone = function(_constructor) {
		if (UNIT_PREPROCESSOR_TM_ENABLE_CLONE) {
		
		return new _constructor(self.__step, self._get_ftick(), self._get_finit(), self._get_ffree()).__copyn_(self);
		
		}
		else {
		
		show_error(____UNIT_TM_ERROR_CLONE, true);
		
		}
	}
	
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
	
	
	static _get_ftick = __UNIT_tmOverride_get_ftick;
	
}

function __UNIT_TmTimerTimelapseExt(_steps, _ftick, _finit, _ffree) : __UNIT_TmTimerTimelapse(_steps, _ftick, _finit, _ffree) constructor {
	
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


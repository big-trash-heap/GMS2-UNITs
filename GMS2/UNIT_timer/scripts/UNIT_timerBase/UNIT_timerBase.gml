
function UNIT_TimerLoop(_ftick, _finit, _fkill) : __UNIT_TimerBaseLoop(_ftick, _finit, _fkill) constructor {};

function UNIT_TimerSync(_steps, _ftick, _finit, _fkill) : __UNIT_TimerBaseTimeout(_steps, _ftick, _finit, _fkill) constructor {
	
	#region __private
	
	static __tick = __UNIT_timerTickSync;
	
	#endregion
	
}

function UNIT_TimerSyncExt(_steps, _ftick, _finit, _fkill) : __UNIT_TimerBaseTimeoutExt(_steps, _ftick, _finit, _fkill) constructor {
	
	#region __private
	
	static __tick = __UNIT_timerTickSync;
	
	#endregion
	
}


#region __private

function __UNIT_TimerBaseLoop(_ftick=undefined, _finit=undefined, _fkill=undefined) : UNIT_Timer() constructor {
	
	#region __private
	
	if (_finit != undefined) self.__init = _finit;
	if (_ftick != undefined) self.__tick = _ftick;
	if (_fkill != undefined) self.__kill = _fkill;
	
	#endregion
	
}

function __UNIT_TimerBaseTimeout(_steps, _ftick=undefined, _finit=undefined, _fkill=undefined) : UNIT_Timer() constructor {
	
	#region __private
	
	static __ftick = UNIT_timerBase;
	
	self.__step = ceil(abs(_steps)) * sign(_steps);
	
	if (_finit != undefined) self.__init = _finit;
	if (_fkill != undefined) self.__kill = _fkill;
	
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
	
}

function __UNIT_TimerBaseTimeoutExt(_steps, _ftick, _finit, _fkill) : __UNIT_TimerBaseTimeout(_steps, _ftick, _finit, _fkill) constructor {
	
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
	
	static resetTime = function(_endPlay=false) {
		var _sign = sign(self.__step);
		if (_sign == 0) _sign = (_endPlay ? -1 : 1);
		self.__step = self.__max_step * _sign;
		return self;
	}
	
}

function __UNIT_timerTickSync(_handler, _timer) {
	
	if (self.__step > 0) {
		
		--self.__step;
		self.__ftick(_handler, _timer);
		return (self.__step == 0);
	}
}

function UNIT_timerBase() {};

#endregion


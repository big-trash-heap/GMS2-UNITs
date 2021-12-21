

/// @function		UNIT_TimerLoop([ftick], [finit], [ffree]);
/// @description	Зацикленный таймер
function UNIT_TimerLoop(_ftick, _finit, _ffree) : UNIT_Timer() constructor {
	
	#region __private
	
	if (_finit != undefined) self.__init = _finit;
	if (_ftick != undefined) self.__tick = _ftick;
	if (_ffree != undefined) self.__free = _ffree;
	
	#endregion
	
}

/// @function		UNIT_TimerLoopExt([ftick], [finit], [ffree]);
/// @description	Зацикленный таймер
function UNIT_TimerLoopExt(_ftick, _finit, _ffree) : UNIT_Timer() constructor {
	
	#region __private
	
	static __ftick = UNIT_timerSync;
	
	static __tick = function(_handler, _timer, _super) {
		
		if (self.__play) return self.__ftick(_handler, _timer, _super);
	}
	
	if (_finit != undefined) self.__init = _finit;
	if (_ffree != undefined) self.__free = _ffree;
	
	if (_ftick != undefined) self.__ftick = _ftick;
	
	self.__play = true;
	
	#endregion
	
	static resume = function() {
		self.__play = true;
		return self;
	}
	
	static pause = function() {
		self.__play = false;
		return self;
	}
	
	static isPause = function() {
		return (!self.__play);
	}
	
	static isPlay = function() {
		return self.__play;
	}
	
	
	static _get_ftick = function() {
		return self.__ftick;
	}
	
}


#region __private

function UNIT_timerLoop() {};

#endregion


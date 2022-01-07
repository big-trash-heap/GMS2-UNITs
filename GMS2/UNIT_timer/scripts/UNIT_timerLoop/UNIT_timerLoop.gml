
/*
	finit = function(handler, timer);
	ftick = function(handler, timer, super);
	ffree = function(handler, timer);
*/


/// @function		UNIT_TimerLoop([ftick], [finit], [ffree]);
/// @description	Зацикленный таймер
function UNIT_TimerLoop(_ftick, _finit, _ffree) : UNIT_Timer() constructor {
	
	#region __private
	
	if (_finit != undefined) self.__init = _finit;
	if (_ftick != undefined) self.__tick = _ftick;
	if (_ffree != undefined) self.__free = _ffree;
	
	#endregion
	
	static _clone = function() {
		if (UNIT_PREPROCESSOR_TIMER_ENABLE_CLONE) {
		
		return new UNIT_TimerLoop(self.__tick, self.__init, self.__free).__copyn_(self);
		
		}
		else {
		
		show_error(____UNIT_TIMER_ERROR_CLONE, true);
		
		}
	}
	
}

/// @function		UNIT_TimerLoopExt([ftick], [finit], [ffree]);
/// @description	Зацикленный таймер
function UNIT_TimerLoopExt(_ftick, _finit, _ffree) : UNIT_Timer() constructor {
	
	#region __private
	
	static __ftick = __UNIT_timerVoid;
	
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
	
	
	static _clone = function() {
		if (UNIT_PREPROCESSOR_TIMER_ENABLE_CLONE) {
		
		var _timer = new UNIT_TimerLoopExt(self.__ftick, self.__init, self.__free);
		_timer.__play = self.__play;
		return _timer.__copyn_(self);
		
		}
		else {
		
		show_error(____UNIT_TIMER_ERROR_CLONE, true);
		
		}
	}
	
}


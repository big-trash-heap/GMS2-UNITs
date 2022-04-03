
/*
	finit = function(handler, timer);
	ftick = function(handler, timer, super);
	ffree = function(handler, timer, inTick);
*/


/// @function		UNIT_TmTimerLoop([ftick], [finit], [ffree]);
/// @description	Зацикленный таймер
function UNIT_TmTimerLoop(_ftick, _finit, _ffree) : UNIT_TmTimer() constructor {
	
	#region __private
	
	self.__set_finit(_finit);
	self.__set_ftick(_ftick);
	self.__set_ffree(_ffree);
	
	#endregion
	
	static _clone = function() {
		if (UNIT_PREPROCESSOR_TM_ENABLE_CLONE) {
		
		return new UNIT_TmTimerLoop(self.__tick, self.__init, self.__free).__copyn_(self);
		
		}
		else {
		
		show_error(__UNIT_TM_ERROR_CLONE, true);
		
		}
	}
	
}

/// @function		UNIT_TmTimerLoopExt([ftick], [finit], [ffree]);
/// @description	Зацикленный таймер
function UNIT_TmTimerLoopExt(_ftick, _finit, _ffree) : UNIT_TmTimer() constructor {
	
	#region __private
	
	static __set_ftick = __UNIT_tmOverride_set_ftick;
	
	static __ftick = __UNIT_tmVoid;
	
	static __tick = function(_handler, _timer, _super) {
		
		if (_timer.__play == true) {
			
			#region PREPROCESSOR
			__UNIT_TM_SKIP_VOID_TICK_LOOP;
			#endregion
			
			return _timer.__ftick(_handler, _timer, _super);
		}
	}
	
	self.__set_finit(_finit);
	self.__set_ftick(_ftick);
	self.__set_ffree(_ffree);
	
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
	
	
	static _get_ftick = __UNIT_tmOverride_get_ftick;
	
	
	static _clone = function() {
		if (UNIT_PREPROCESSOR_TM_ENABLE_CLONE) {
		
		var _timer = new UNIT_TmTimerLoopExt(self.__ftick, self.__init, self.__free);
		_timer.__play = self.__play;
		return _timer.__copyn_(self);
		
		}
		else {
		
		show_error(__UNIT_TM_ERROR_CLONE, true);
		
		}
	}
	
}


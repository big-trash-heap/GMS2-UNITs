
/*
	finit = function(handler, timer);
	ftick = function(handler, timer, super, milisec_step);
	ffree = function(handler, timer, inTick);
*/

/*
	Данное решение не относится к базовым и представленно как дополнение
*/


/// @function		UNIT_TmTimerLoopAsync([ftick], [finit], [ffree]);
/// @description	Зацикленный асинхронный таймер
function UNIT_TmTimerLoopAsync(_ftick, _finit, _ffree) : UNIT_TmTimerLoop(undefined, undefined, _ffree) constructor {
	
	#region __private
	
	static __set_finit = __UNIT_tmOverride_set_finit;
	static __set_ftick = __UNIT_tmOverride_set_ftick;
	
	static __finit = __UNIT_tmVoid;
	static __ftick = __UNIT_tmVoid;
	
	static __init = __UNIT_tmLoopAsyncInit;
	static __tick = function(_handler, _timer, _super) {
		var _ctime = current_time;
		var _diff = _ctime - _timer.__ctime;
		
		_timer.__ctime = _ctime;
		
		#region PREPROCESSOR
		if (UNIT_PREPROCESSOR_TM_ENABLE_SKIP_VOID_TICK) {
		
		if (_timer._get_ftick() == __UNIT_tmVoid) {
			return false;
		}
		
		}
		#endregion
		
		return _timer.__ftick(_handler, _timer, _super, _diff);
	}
	
	self.__set_finit(_finit);
	self.__set_ftick(_ftick);
	
	#endregion
	
	static _get_finit = __UNIT_tmOverride_get_finit;
	static _get_ftick = __UNIT_tmOverride_get_ftick;
	
	
	static _clone = function() {
		if (UNIT_PREPROCESSOR_TM_ENABLE_CLONE) {
		
		return new UNIT_TmTimerLoopAsync(self.__ftick, self.__finit, self.__free).__copyn_(self);
		
		}
		else {
		
		show_error(__UNIT_TM_ERROR_CLONE, true);
		
		}
	}
	
}

/// @function		UNIT_TmTimerLoopAsyncExt([ftick], [finit], [ffree]);
/// @description	Зацикленный асинхронный таймер
function UNIT_TmTimerLoopAsyncExt(_ftick, _finit, _ffree) : UNIT_TmTimerLoopExt(_ftick, undefined, _ffree) constructor {
	
	#region __private
	
	static __set_finit = __UNIT_tmOverride_set_finit;
	
	static __finit = __UNIT_tmVoid;
	
	static __init = __UNIT_tmLoopAsyncInit;
	static __tick = function(_handler, _timer, _super) {
		var _ctime = current_time;
		if (_timer.__play == true) {
			
			var _diff = _ctime - _timer.__ctime;
			
			_timer.__ctime = _ctime;
			
			#region PREPROCESSOR
			__UNIT_TM_SKIP_VOID_TICK_LOOP;
			#endregion
			
			return _timer.__ftick(_handler, _timer, _super, _diff);
		} else {
			_timer.__ctime = _ctime;
		}
	}
	
	self.__set_finit(_finit);
	
	#endregion
	
	static resume = function() {
		if (self.__play == false) {
			self.__play  = true;
			self.__ctime = current_time;
		}
		return self;
	}
	
	
	static _get_finit = __UNIT_tmOverride_get_finit;
	
	static _clone = function() {
		if (UNIT_PREPROCESSOR_TM_ENABLE_CLONE) {
		
		var _timer = new UNIT_TmTimerLoopAsyncExt(self.__ftick, self.__finit, self.__free);
		_timer.__play = self.__play;
		return _timer.__copyn_(self);
		
		}
		else {
		
		show_error(__UNIT_TM_ERROR_CLONE, true);
		
		}
	}
	
}


#region __private

function __UNIT_tmLoopAsyncInit(_handler, _timer) {
	_timer.__ctime = current_time;
	_timer.__finit(_handler, _timer);
}

#endregion


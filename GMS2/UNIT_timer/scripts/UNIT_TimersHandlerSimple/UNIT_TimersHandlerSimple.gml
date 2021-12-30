
/*
	Предоставляет дополнительный интерфейс для работы с обработчиками
*/

function UNIT_TimersHandlerSimple() : UNIT_TimersHandler() constructor {
	
	#region __private
	
	static __timer_Loop      = UNIT_TimerLoop;
	static __timer_LoopAsync = UNIT_TimerLoopAsync;
	static __timer_Sync      = UNIT_TimerSync;
	static __timer_Async     = UNIT_TimerAsync;
	
	#endregion
	
	static newLoop = function(_ftick, _finit, _ffree, _argument) {
		return self.bind(new __timer_Loop(_ftick, _finit, _ffree), _argument);
	}
	
	static newLoopAsync = function(_ftick, _finit, _ffree, _argument) {
		return self.bind(new __timer_LoopAsync(_ftick, _finit, _ffree), _argument);
	}
	
	static newSync = function(_steps, _ftick, _finit, _ffree, _argument) {
		return self.bind(new __timer_Sync(_steps, _ftick, _finit, _ffree), _argument);
	}
	
	static newAsync = function(_milisec, _ftick, _finit, _ffree, _argument) {
		return self.bind(new __timer_Async(_milisec, _ftick, _finit, _ffree), _argument);
	}
	
	static newEndSync = function(_steps, _f) {
		return self.bind(new __timer_Sync(_steps, undefined, undefined, _f), undefined);
	}
	
	static newEndAsync = function(_milisec, _f) {
		return self.bind(new __timer_Async(_milisec, undefined, undefined, _f), undefined);
	}
	
	static tick_end = function(_super) {
		if (self.__count == 0) return true;
		self.tick(_super);
	}
	
}

function UNIT_TimersHandlerSimpleExt() : UNIT_TimersHandlerSimple() constructor {
	
	#region __private
	
	static __timer_Loop      = UNIT_TimerLoopExt;
	static __timer_LoopAsync = UNIT_TimerLoopAsyncExt;
	static __timer_Sync      = UNIT_TimerSyncExt;
	static __timer_Async     = UNIT_TimerAsyncExt;
	
	#endregion
	
}


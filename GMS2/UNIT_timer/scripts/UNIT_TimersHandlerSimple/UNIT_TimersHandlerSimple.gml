
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
	
	static newLoop = function(_ftick, _finit, _ffree) {
		return self.bind(new __timer_Loop(_ftick, _finit, _ffree));
	}
	
	static newLoopAsync = function(_ftick, _finit, _ffree) {
		return self.bind(new __timer_LoopAsync(_ftick, _finit, _ffree));
	}
	
	static newSync = function(_steps, _ftick, _finit, _ffree) {
		return self.bind(new __timer_Sync(_steps, _ftick, _finit, _ffree));
	}
	
	static newAsync = function(_milisec, _ftick, _finit, _ffree) {
		return self.bind(new __timer_Async(_milisec, _ftick, _finit, _ffree));
	}
	
	static newEndSync = function(_steps, _f) {
		return self.bind(new __timer_Sync(_steps, undefined, undefined, _f));
	}
	
	static newEndAsync = function(_milisec, _f) {
		return self.bind(new __timer_Async(_milisec, undefined, undefined, _f));
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



/*
	Предоставляет дополнительный интерфейс для работы с обработчиками
*/

function UNIT_TmHandlerSimple() : UNIT_TmHandler() constructor {
	
	#region __private
	
	static __timer_Loop      = UNIT_TmTimerLoop;
	static __timer_LoopAsync = UNIT_TmTimerLoopAsync;
	static __timer_Sync      = UNIT_TmTimerSync;
	static __timer_Async     = UNIT_TmTimerAsync;
	
	#endregion
	
	static newLoop = function(_ftick, _finit, _ffree) {
		return self.bind(new self.__timer_Loop(_ftick, _finit, _ffree));
	}
	
	static newLoopAsync = function(_ftick, _finit, _ffree) {
		return self.bind(new self.__timer_LoopAsync(_ftick, _finit, _ffree));
	}
	
	static newSync = function(_steps, _ftick, _finit, _ffree) {
		return self.bind(new self.__timer_Sync(_steps, _ftick, _finit, _ffree));
	}
	
	static newAsync = function(_milisec, _ftick, _finit, _ffree) {
		return self.bind(new self.__timer_Async(_milisec, _ftick, _finit, _ffree));
	}
	
	static newEndSync = function(_steps, _f) {
		return self.bind(new self.__timer_Sync(_steps, undefined, undefined, _f));
	}
	
	static newEndAsync = function(_milisec, _f) {
		return self.bind(new self.__timer_Async(_milisec, undefined, undefined, _f));
	}
	
}

function UNIT_TmHandlerSimpleExt() : UNIT_TmHandlerSimple() constructor {
	
	#region __privates
	
	static __timer_Loop      = UNIT_TmTimerLoopExt;
	static __timer_LoopAsync = UNIT_TmTimerLoopAsyncExt;
	static __timer_Sync      = UNIT_TmTimerSyncExt;
	static __timer_Async     = UNIT_TmTimerAsyncExt;
	
	#endregion
	
}


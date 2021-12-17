
function UNIT_Timer() constructor {
	
	#region __private
	
	static __init = UNIT_timer /* handler, timer, arg, */;
	static __tick = UNIT_timer /* handler, timer       */;
	static __kill = UNIT_timer /* handler, timer       */;
	 
	#endregion
	
	static remove = function() {
		
		return UNIT_timerRemove(self);
	}
	
	static isBind = function() {
		
		return UNIT_timerIsBind(self);
	}
	
	static getHandler = function() {
		
		return UNIT_timerGetHandler(self);
	}
	
	static toString = function() {
		return ("UNIT::Timer::" + instanceof(self));
	}
	
}


function UNIT_timerRemove(_timer) {
	static _map = __UNIT_timerHandler();
	var _cell = _map[? _timer];
	if (_cell == undefined) return false;
	
	ds_map_delete(_map, _cell);
	
	var _handler = _cell[UNIT_TIMER_CELL.HANDLER];
	_cell[@ UNIT_TIMER_CELL.HANDLER] = undefined;
	
	with (_handler) {
	
	--self.__count;
	_timer.__kill(self, _timer);
	
	}
	
	return true;
}

function UNIT_timerIsBind(_timer) {
	static _map = __UNIT_timerHandler();
	return ds_map_exists(_map, _timer);
}

function UNIT_timerGetHandler(_timer) {
	static _map = __UNIT_timerHandler();
	var _cell = _map[? _timer];
	if (_cell != undefined) return _cell[UNIT_TIMER_CELL.HANDLER];
}


#region __private

function UNIT_timer() {};

#endregion




function __UNIT_ProduceOrderDynamic(_producer, _state=UNIT_PRODUCER_CODE._PLAY) constructor {
	
	#region __private
	
	self.__state    = _state;
	self.__producer = weak_ref_create(_producer);
	
	#endregion
	
	static state = function() {
		return self.__state;	
	}
	
	static result = function() {
		return self[$ "__result"];
	}
	
	// 0x1e
	static pause = undefined;
	
	// 0x1d
	static play = undefined;
	
	// 0x1c
	static free = undefined;
	
	
}


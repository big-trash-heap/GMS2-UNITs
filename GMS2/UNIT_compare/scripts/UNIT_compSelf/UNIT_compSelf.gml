
function UNIT_compSelf(_self0, _self1) {
	
	static _split = function(_self) {
		
		if (instanceof(_self) == "instance") {
				
			return _self[$ "id"];
		}
		
		return _self;
	}
	
	return (_split(_self0) == _split(_self1));
}


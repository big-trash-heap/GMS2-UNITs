
function UNIT_compSelf(_self0, _self1) {
	
	static _split = function(_self) {
		
		if (instanceof(_self) == "instance") {
				
			return _self[$ "id"];
		}

		if (typeof(_self) != "ref") {
		
			return undefined;
		}
		
		return _self;
	}
	
	var _s1 = _split(_self0);
	var _s2 = _split(_self1);
	
	if (_s1 != _s2 || is_undefined(_s1)) {
		return false;
	}
	
	return true;
}


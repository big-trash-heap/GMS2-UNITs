
enum UNIT_PRODUCER_CODE {
	_PAUSE     = (1 << 0), 
	_PLAY      = (1 << 1),
	_COMPLETED = (1 << 2),
	_ERROR     = (1 << 3),
	_DELETE    = (1 << 4),
}

function UNIT_Producer() constructor {
	
	static newOrder = undefined;
	
	static tick = undefined;
	
}




function __UNIT_tilemapUtility() {};

function __UNIT_tileCallAtPix(_tilemapElementId, _x, _y, _call) {
	
	var _cellX = tilemap_get_cell_x_at_pixel(_tilemapElementId, _x, _y);
	if (_cellX != -1) {
		
		_y = tilemap_get_cell_y_at_pixel(_tilemapElementId, _x, _y);
		_call(_tilemapElementId, _cellX, _y);
	}
}

function __UNIT_tileTable47() {
	static _table = function() {
		
		var _order_bits47 = [
			     256, 257, 260, 261, 384, 385, 388,
			389, 288, 289, 292, 293, 416, 417, 420,
			421, 297, 301, 425, 429, 263, 391, 295,
			423, 404, 436, 405, 437, 480, 481, 484,
			485, 445, 487, 303, 431, 407, 439, 500,
			501, 489, 493, 447, 495, 509, 503, 511,
		];
		
		var _table = ds_map_create();
		var _size = array_length(_order_bits47);
		for (var _i = 0, _bit; _i < _size; ++_i) {
	
			_bit = _order_bits47[_i];
			_table[? _i]   = _bit;
			_table[? _bit] = _i;
		}
		
		return _table;
	}();
	return _table;
}


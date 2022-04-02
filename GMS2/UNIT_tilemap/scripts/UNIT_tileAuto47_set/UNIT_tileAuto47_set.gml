

/*
	Смотри __UNIT_tilemapNote
	Предварительно смотрите UNIT_unit_tileAuto16

	Аналогично UNIT_unit_tileAuto16
	Мы ставим в каждый не пустой тайл на 8 бит 1
	Установка ставит 1, а удаление 0
	
	###############
	## 0 # 1 # 2 ##
	## 3 # 8 # 4 ##
	## 5 # 6 # 7 ##
	###############
*/

/*
	Ограничение и возможности данной реализации
	1. Расположение тайлов нельзя изменить
	2. На тайлмапе должны находится, только тайлы участвующие в автотайлинге
	(иные тайлы не обрабатываются и это может привести к рантайм багам)
	3. Смешивание режимов не гарантируется!
	(смешивание режимов приведёт к рантайм багам)
	4. Предварительные элементы на тайлмапе должны соблюдать логику автотайлинга и выбранного режима
	(иначе это приведёт к рантайм багам)
	5. Свойства кроме индекса игнорируются
	(tile_get_mirror, tile_get_rotate, ...)
	
	В отличие от тайлинга на 16, режим cd для автотайлинга 47, вводит дополнительную логику, 
	которую нужно обязательно соблюдать (иначе это рантайм ошибки)
	Я не могу описать эту логику, так как я жёстко её запрограммировал UNIT_tileAuto47_set_cd
	
	Здесь создаётся таблица для перевода из битов в индексы, и наоборот
*/

/// @function		UNIT_tileAuto47_set(tilemap_element_id, cell_x, cell_y);
function UNIT_tileAuto47_set(_tilemapElementId, _cellX, _cellY) {
	
	//
	if (tilemap_get(_tilemapElementId, _cellX, _cellY) > 0) exit;
	
	//
	var _mathBits;
	var _centerBits = 0;
	
	var _state_l = tilemap_get(_tilemapElementId, _cellX - 1, _cellY) > 1;
	if (_state_l) {
		
		var _leftBits = 16;
		_centerBits |= 8;
	}
	
	var _state_r = tilemap_get(_tilemapElementId, _cellX + 1, _cellY) > 1;
	if (_state_r) {
		
		var _rightBits = 8;
		_centerBits |= 16;
	}
	
	if (tilemap_get(_tilemapElementId, _cellX, _cellY - 1) > 1) {
		
		_centerBits |= 2;
		_mathBits = 64;
		
		if (_state_l and tilemap_get(_tilemapElementId, _cellX - 1, _cellY - 1) > 1) {
			
			_centerBits |= 1;
			_leftBits   |= 4;
			_mathBits   |= 32;
			UNIT_tileModify(_tilemapElementId, _cellX - 1, _cellY - 1, __UNIT_tileAuto47_reset, 303); // left-top
		}
		
		if (_state_r and tilemap_get(_tilemapElementId, _cellX + 1, _cellY - 1) > 1) {
			
			_centerBits |= 4;
			_rightBits  |= 1;
			_mathBits   |= 128;
			UNIT_tileModify(_tilemapElementId, _cellX + 1, _cellY - 1, __UNIT_tileAuto47_reset, 407); // right-top
		}
		
		UNIT_tileModify(_tilemapElementId, _cellX, _cellY - 1, __UNIT_tileAuto47_reset_inv, _mathBits); // top
	}
	
	if (tilemap_get(_tilemapElementId, _cellX, _cellY + 1) > 1) {
		
		_centerBits |= 64;
		_mathBits = 2;
		
		if (_state_l and tilemap_get(_tilemapElementId, _cellX - 1, _cellY + 1) > 1) {
			
			_centerBits |= 32;
			_leftBits   |= 128;
			_mathBits   |= 1;
			UNIT_tileModify(_tilemapElementId, _cellX - 1, _cellY + 1, __UNIT_tileAuto47_reset, 489); // left-down
		}
		
		if (_state_r and tilemap_get(_tilemapElementId, _cellX + 1, _cellY + 1) > 1) {
			
			_centerBits |= 128;
			_rightBits  |= 32;
			_mathBits   |= 4;
			UNIT_tileModify(_tilemapElementId, _cellX + 1, _cellY + 1, __UNIT_tileAuto47_reset, 500); // right-down
		}
		
		UNIT_tileModify(_tilemapElementId, _cellX, _cellY + 1, __UNIT_tileAuto47_reset_inv, _mathBits); // bottom
	}
	
	if (_state_l) {
		
		UNIT_tileModify(_tilemapElementId, _cellX - 1, _cellY, __UNIT_tileAuto47_reset_inv, _leftBits); // left
	}
	
	if (_state_r) {
		
		UNIT_tileModify(_tilemapElementId, _cellX + 1, _cellY, __UNIT_tileAuto47_reset_inv, _rightBits); // right
	}
	
	UNIT_tileModify(_tilemapElementId, _cellX, _cellY, __UNIT_tileAuto47_set, ~_centerBits & 511 | 256); // center
}

/// @function		UNIT_tileAuto47_set_cd(tilemap_element_id, cell_x, cell_y);
function UNIT_tileAuto47_set_cd(_tilemapElementId, _cellX, _cellY) {
	
	/*
		Да этот код получился довольно страшным
		Это не планируется редактировать никогда!
		
		Я действительно не могу объяснить, что тут происходит
	*/
	
	//
	if (tilemap_get(_tilemapElementId, _cellX, _cellY) > 0) exit;
	
	//
	var _mathBits;
	var _centerBits = 0;
	var _state_l, _state_r, _state_t, _state_d;
	
	#region left
	
	_state_l = tilemap_get(_tilemapElementId, _cellX - 1, _cellY);
	if (_state_l > 1) {
		
		var _leftBits = 16;
		_centerBits |= 8;
	}
	else
	if (_state_l == -1) {
		
		_centerBits |= 8;
	}
	
	#endregion
	
	#region right
	
	_state_r = tilemap_get(_tilemapElementId, _cellX + 1, _cellY);
	if (_state_r > 1) {
		
		var _rightBits = 8;
		_centerBits |= 16;
	}
	else
	if (_state_r == -1) {
		
		_centerBits |= 16;
	}
	
	#endregion
	
	#region top
	
	_state_t = tilemap_get(_tilemapElementId, _cellX, _cellY - 1);
	if (_state_t > 1) {
		
		_centerBits |= 2;
		_mathBits = 64;
		
		if (_state_l > 0 and tilemap_get(_tilemapElementId, _cellX - 1, _cellY - 1) > 1) {
			
			_centerBits |= 1;
			_leftBits   |= 4;
			_mathBits   |= 32;
			UNIT_tileModify(_tilemapElementId, _cellX - 1, _cellY - 1, __UNIT_tileAuto47_reset, 303); // left-top
		}
		
		if (_state_r > 0 and tilemap_get(_tilemapElementId, _cellX + 1, _cellY - 1) > 1) {
			
			_centerBits |= 4;
			_rightBits  |= 1;
			_mathBits   |= 128;
			UNIT_tileModify(_tilemapElementId, _cellX + 1, _cellY - 1, __UNIT_tileAuto47_reset, 407); // right-top
		}
		
		UNIT_tileModify(_tilemapElementId, _cellX, _cellY - 1, __UNIT_tileAuto47_reset_inv, _mathBits); // top
	}
	else
	if (_state_t == -1) {
		
		_centerBits |= 2;
		
		if (_state_l != 0) {
			
			_centerBits |= 9;
			if (_state_l > 0) _leftBits |= 4;
		}
		
		if (_state_r != 0) {
			
			_centerBits |= 20;
			if (_state_r > 0) _rightBits |= 1;
		}
	}
	
	#endregion
	
	#region down
	
	_state_d = tilemap_get(_tilemapElementId, _cellX, _cellY + 1);
	if (_state_d > 1) {
		
		_centerBits |= 64;
		_mathBits = 2;
		
		if (_state_l > 0 and tilemap_get(_tilemapElementId, _cellX - 1, _cellY + 1) > 1) {
		
			_centerBits |= 32;
			_leftBits   |= 128;
			_mathBits   |= 1;
			UNIT_tileModify(_tilemapElementId, _cellX - 1, _cellY + 1, __UNIT_tileAuto47_reset, 489); // left-down
		}
		
		if (_state_r > 0 and tilemap_get(_tilemapElementId, _cellX + 1, _cellY + 1) > 1) {
			
			_centerBits |= 128;
			_rightBits  |= 32;
			_mathBits   |= 4;
			UNIT_tileModify(_tilemapElementId, _cellX + 1, _cellY + 1, __UNIT_tileAuto47_reset, 500); // right-down
		}
		
		UNIT_tileModify(_tilemapElementId, _cellX, _cellY + 1, __UNIT_tileAuto47_reset_inv, _mathBits); // bottom
	}
	else
	if (_state_d == -1) {
		
		_centerBits |= 64;
		
		if (_state_l != 0) {
			
			_centerBits |= 40;
			if (_state_l > 0) _leftBits |= 128;
		}
		
		if (_state_r != 0) {
			
			_centerBits |= 144;
			if (_state_r > 0) _rightBits |= 32;
		}
	}
	
	#endregion
	
	#region again left
	
	if (_state_l != 0) {
		
		if (_state_l > 0) {
		
			UNIT_tileModify(_tilemapElementId, _cellX - 1, _cellY, __UNIT_tileAuto47_reset_inv, _leftBits);
		}
		else {
			
			if (_state_t > 1) {
				
				_centerBits |= 1;
				UNIT_tileModify(_tilemapElementId, _cellX, _cellY - 1, __UNIT_tileAuto47_reset, 479);
			}
			
			if (_state_d > 1) {
				
				_centerBits |= 32;
				UNIT_tileModify(_tilemapElementId, _cellX, _cellY + 1, __UNIT_tileAuto47_reset, 510);
			}
		}
	}
	
	#endregion
	
	#region again right
	
	if (_state_r != 0) {
		
		if (_state_r > 0) {
			
			UNIT_tileModify(_tilemapElementId, _cellX + 1, _cellY, __UNIT_tileAuto47_reset_inv, _rightBits);
		}
		else {
			
			if (_state_t > 1) {
				
				_centerBits |= 4;
				UNIT_tileModify(_tilemapElementId, _cellX, _cellY - 1, __UNIT_tileAuto47_reset, 383);
			}
			
			if (_state_d > 1) {
				
				_centerBits |= 128;
				UNIT_tileModify(_tilemapElementId, _cellX, _cellY + 1, __UNIT_tileAuto47_reset, 507);
			}
		}
	}
	
	#endregion
	
	UNIT_tileModify(_tilemapElementId, _cellX, _cellY, __UNIT_tileAuto47_set, ~_centerBits & 511 | 256); // center
}

/// @function		UNIT_tileAuto47_reset(tilemap_element_id, cell_x, cell_y);
function UNIT_tileAuto47_reset(_tilemapElementId, _cellX, _cellY) {
	
	if (tilemap_get(_tilemapElementId, _cellX, _cellY) <= 0) exit;
	tilemap_set(_tilemapElementId, 0, _cellX, _cellY);
	
	var _state_l = tilemap_get(_tilemapElementId, _cellX - 1, _cellY) > 0;
	var _state_r = tilemap_get(_tilemapElementId, _cellX + 1, _cellY) > 0;
	
	if (_state_l) {
		
		UNIT_tileModify(_tilemapElementId, _cellX - 1, _cellY, __UNIT_tileAuto47_set, 148); // left
	}
	
	if (_state_r) {
		
		UNIT_tileModify(_tilemapElementId, _cellX + 1, _cellY, __UNIT_tileAuto47_set, 41); // right
	}
	
	if (tilemap_get(_tilemapElementId, _cellX, _cellY - 1)) {
		
		UNIT_tileModify(_tilemapElementId, _cellX, _cellY - 1, __UNIT_tileAuto47_set, 224); // top
		
		if (_state_l and tilemap_get(_tilemapElementId, _cellX - 1, _cellY - 1)) {
			
			UNIT_tileModify(_tilemapElementId, _cellX - 1, _cellY - 1, __UNIT_tileAuto47_set, 128); // left-top
		}
		
		if (_state_r and tilemap_get(_tilemapElementId, _cellX + 1, _cellY - 1)) {
			
			UNIT_tileModify(_tilemapElementId, _cellX + 1, _cellY - 1, __UNIT_tileAuto47_set, 32); // right-top
		}
	}
	
	if (tilemap_get(_tilemapElementId, _cellX, _cellY + 1)) {
		
		UNIT_tileModify(_tilemapElementId, _cellX, _cellY + 1, __UNIT_tileAuto47_set, 7); // down
		
		if (_state_l and tilemap_get(_tilemapElementId, _cellX - 1, _cellY + 1)) {
			
			UNIT_tileModify(_tilemapElementId, _cellX - 1, _cellY + 1, __UNIT_tileAuto47_set, 4); // left-down
		}
		
		if (_state_r and tilemap_get(_tilemapElementId, _cellX + 1, _cellY + 1)) {
			
			UNIT_tileModify(_tilemapElementId, _cellX + 1, _cellY + 1, __UNIT_tileAuto47_set, 1); // right-down
		}
	}
}

/// @function		UNIT_tileAuto47AtPix_set(tilemap_element_id, x, y);
function UNIT_tileAuto47AtPix_set(_tilemapElementId, _x, _y) {
	__UNIT_tileCallAtPix(_tilemapElementId, _x, _y, UNIT_tileAuto47_set);
}

/// @function		UNIT_tileAuto47AtPix_set_cd(tilemap_element_id, x, y);
function UNIT_tileAuto47AtPix_set_cd(_tilemapElementId, _x, _y) {
	__UNIT_tileCallAtPix(_tilemapElementId, _x, _y, UNIT_tileAuto47_set_cd);
}

/// @function		UNIT_tileAuto47AtPix_reset(tilemap_element_id, x, y);
function UNIT_tileAuto47AtPix_reset(_tilemapElementId, _x, _y) {
	__UNIT_tileCallAtPix(_tilemapElementId, _x, _y, UNIT_tileAuto47_reset);
}


#region __private

function __UNIT_tileAuto47_set(_tile, _value) {
	static _table = __UNIT_tileTable47();
	
	if (_tile > -1) {
		
		if (_tile == 0) {
			return (_table[? _value] + 1);
		}
		
		return (_table[? _value | _table[? _tile - 1]] + 1);
	}
}

function __UNIT_tileAuto47_reset(_tile, _value) {
	static _table = __UNIT_tileTable47();
	
	if (_tile > -1) {
		
		if (_tile == 0) {
			return (_table[? _value] + 1);
		}
		
		return (_table[? _value & _table[? _tile - 1]] + 1);
	}
}

function __UNIT_tileAuto47_reset_inv(_tile, _value) {
	static _table = __UNIT_tileTable47();
	
	if (_tile > -1) {
		
		//if (_tile == 0) return (_table[? ~_value & 511] + 1);
		return (_table[? ~_value & _table[? _tile - 1]] + 1);
	}
}

#endregion


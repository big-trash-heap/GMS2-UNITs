

function UNIT_ProducerAudio() : UNIT_Producer() constructor {
	
	#region __private
	
	self.__map = __UNIT_producerOrderNewMap(self);
	
	#endregion
	
	static newOrder = function() {
		return new __UNIT_ProduceAudio(self);
	}
	
	static tick = function() {
		
		var _size = ds_map_size(self.__map);
		if (_size > 0) {
			
			var _stack = [];
			var _key = ds_map_find_first(self.__map);
			var _order, _delete;
			
			var _array;
			var _arrSize, _i, _j;
			var _pack;
			
			repeat _size {
				
				_delete = 0;
				_order = _key.ref;
				
				_array = _order.__queue;
				_arrSize = array_length(_array);
				if (_arrSize > 0) {
					
					_i = 0;
					do {
						_pack = _array[_i];
						if (_pack.meta == "internal") {
							
							_pack.sound = audio_play_sound(_pack.audio, _pack.priority, _pack.loop);
							array_push(_order.__sound_internal, _pack);
						}
						
						variable_struct_remove(_pack, "meta");
					} until (++_i == _arrSize);
					
					array_resize(_array, 0);
				}
				
				_array = _order.__sound_internal;
				_arrSize = array_length(_array);
				if (_arrSize > 0) {
					
					_i = 0;
					_j = 0;
					do {
						
						_pack = _array[_i];
						if (audio_exists(_pack.sound)) {
							
							if (_pack.loop) {
								
								if (_pack.time != 0) {
									_array[@ _j++] = _pack;
									
									if (_pack.time < 0)
										_pack.time = min(0, _pack.time + 1);
									else
									if (current_time > _pack.time)
										_pack.time = 0;
								}
							}
							else {
								_array[@ _j++] = _pack;
							}
						}
					} until (++_i == _arrSize);
					array_resize(_array, _j);
				}
				else ++_delete;
				
				if (_delete == 1) array_push(_stack, _key);
				_key = ds_map_find_next(self.__map, _key);
			}
			
			_arrSize = array_length(_stack);
			while (_arrSize > 0) {
				
				_key = _stack[--_arrSize];
				_pack = _key.ref;
				
				ds_map_delete(self.__map, _key);
				_pack.__state = UNIT_PRODUCER_CODE._COMPLETED;
			}
			
			return true;
		}
		
		return false;
	}
	
}


#region __private

function __UNIT_ProduceAudio(_producer) : __UNIT_ProduceOrderDynamic(_producer) constructor {
	
	self.__ref = weak_ref_create(self);
	self.__producer.ref.__map[? self.__ref] = undefined;
	
	self.__queue = [];
	self.__sound_internal = [];
	//self.__sound_external = [];
	
	static addAudio = function(_audio, _priority=0, _time=undefined) {
		
		if (self.__state & 0x1c) return;
		
		var _pack = {
			meta: "internal",
			audio: _audio,
			priority: _priority,
		}
		
		if (_time == undefined) {
			
			_pack.loop = false;
		}
		else {
			
			_pack.loop = true;
			_pack.time = (_time < 0 ? _time : current_time + _time);
		}
		
		array_push(self.__queue, _pack);
	}
	
	static pause = function() {
		
		if (self.__state & 0x1e == 0) return;
		
		self.__state = UNIT_PRODUCER_CODE._PAUSE;
		ds_map_delete(self.__producer.ref.__map, self.__ref);
		
		var _size = array_length(self.__sound_internal);
		var _pack;
		while (_size > 0) {
			
			_pack = self.__sound_internal[--_size];
			if (audio_exists(_pack.sound)) {
				
				_pack.position = audio_sound_get_track_position(_pack.sound);
				audio_stop_sound(_pack.sound);
			}
		}
	}
	
	static play = function() {
		
		if (self.__state & 0x1d == 0) return;
		
		self.__state = UNIT_PRODUCER_CODE._PLAY;
		self.__producer.ref.__map[? self.__ref] = undefined;
		
		var _size = array_length(self.__sound_internal);
		var _pack;
		while (_size > 0) {
			
			_pack = self.__sound_internal[--_size];
			_pack.sound = audio_play_sound(_pack.audio, _pack.priority, _pack.loop);
			audio_sound_set_track_position(_pack.sound, _pack.position);
		}
	}
	
	static free = function() {
	
		if (self.__state & 0x1c) return;
	}
	
	//static addSound = function(_sound, _time, _awaitTime=false) {
		
	//	array_push(self.__sound_external, {
	//		playState: -1,
			
	//	});
	//}
	
}

#endregion


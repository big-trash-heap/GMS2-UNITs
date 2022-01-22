/*
var _handler = new UNIT_TimersHandlerSimple();
_handler.newLoop(function() {
	show_debug_message("loop");	
});

_handler._clone().newLoop();

var _timer = new UNIT_TimerAsync(1500, function() {
	show_debug_message("_timer");
})._bindDisable()._bindEnable();

UNIT_timerGl_timer(_timer);
UNIT_timerGl_async(1500, function() {
	show_debug_message("async");
});*/

/*
timer = new UNIT_TimerLoopAsync(
	function(_handler, _timer) {
		show_debug_message(_timer.name);
	},
	function() {
		
	},
	function() {
		
	},
)._set("name", "Kirill");

timer2 = timer._clone()._set("name", "Dasha");

UNIT_timerGl_timer(timer);
UNIT_timerGl_timer(timer2);

handler = UNIT_timerGlobal()._clone();

UNIT_timerGlobal().clearAll(); */



//timer_step = UNIT_timerGl_loopAsync(function(_0, _timer, _1, _step) {
//	show_debug_message(_step);
	
//	if (keyboard_check_pressed(vk_space)) {
		
//		UNIT_timerGl_timer(timer_switch);
//		return true;
//	}
//});

//timer_switch = UNIT_timerGl_loop(function() {
//	show_debug_message("pause");
	
//	if (keyboard_check_pressed(vk_space)) {
		
//		UNIT_timerGl_timer(timer_step);
//		return true;
//	}
//})._unbind();



//timer = new UNIT_TimerAsyncExt(1000, 
//	function(_handler, _timer) {
//		show_debug_message(_timer.name);
//	}, undefined,
//	function(_0, _timer) {
		
//		UNIT_timerGl_timer(_timer).resetTime();
//	}
//)._set("name", "Kirill");

//timer2 = timer._clone()._set("name", "Dasha");

//UNIT_timerGl_timer(timer);
//UNIT_timerGl_timer(timer2);


UNIT_timerGl_loop(
	function(_0, _timer) {
		
		if (_timer.timer != undefined) {
			_timer.timer.unbind();
		}
		
		show_message(1);
		
		
		_timer.timer = UNIT_timerGl_loop(
			function(_0, _timer) {
				show_message(_timer.num);
			}, undefined,
			function(_0, _timer) {
				_timer.timer.unbind();
				UNIT_timerGl_loop(
					function(_0, _timer) {
						var _text = "&" + string(_timer.num);
						show_message(_text);
						if (_text == "&8") {
							
							var _t1 = UNIT_timerGl_loop();
							var _t2 = UNIT_timerGl_loop(undefined, undefined, function() { show_message(222); });
							var _t3 = UNIT_timerGl_loop(undefined, undefined, function() {
								//show_message(UNIT_timerGlobal().__clear);
								UNIT_timerGlobal().clearAll(); });
							var _t4 = UNIT_timerGl_loop(undefined, undefined, function() { show_message(444); });
							
							
							_t2.unbind();
							_t4.unbind();
							
							UNIT_timerGl_timer(_t4);
							UNIT_timerGl_timer(_t2);
							
							var _save = self._fff;
							self._fff = undefined;
							
							UNIT_timerGlobal().clearAll();
							
							show_message("clearAll");
							show_message(_timer.isBind());
							
							UNIT_timerGl_timer(_timer);
							
							self._fff = _save;
							
							return true;
						}
					}, undefined,
					function(_0, _timer) {
						var _text = "&" + string(_timer.num);
						if (_text == "&8") {
							show_message("fff()");
							if (self._fff != undefined) {
								self._fff();
								self._fff = undefined;
							}
						}
					})._set("num", _timer.num);
			})._set("num", ++_timer.num);
		
		var _t = UNIT_timerGl_loop(
			function(_0, _timer) {
				show_message(_timer.num);
			})._set("num", ++_timer.num);
		
		_timer.timer._set("timer", _t);
		
		if (_timer.num > 8) {
			UNIT_timerGlobal().clear();
			return;
		}
		
	}, undefined,
	function() {
		show_message("clear");
	}
)._set("num", 1)._set("timer", undefined);

self._fff = function() {
	return;
	var _t;
	
	show_message("end");
	timer = UNIT_timerGl_async(5000, function(_0, _timer, _1, _count) {
		show_debug_message(["hello", _timer.getLeftCf(), _count]);
	}, undefined, function(_0, _timer) {
		show_debug_message("<< hello");
		_timer.resetTime();
		UNIT_timerGl_timer(_timer);
	});
	timer.pause();
	
	UNIT_timerGl_async(5000).unbind();
	UNIT_timerGl_async(5000).unbind();
	UNIT_timerGl_async(5000).unbind();
	
	UNIT_timerGl_endAsync(2500, function() {
		show_message("hello");
		timer.resume();
	});
	
	show_message(UNIT_timerGlobal()._toArray());
	
	var base = UNIT_timerGl_loop(function() {
		show_debug_message("loop");	
	}).pause();
	
	UNIT_timerGl_endAsync(15000, function(_0, _timer) {
		
		_timer.t.resume();
	})._set("t", base);
}


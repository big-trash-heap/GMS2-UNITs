
UNIT_timerGl_loop(
	function(_0, _timer) {
		
		if (_timer.timer != undefined) {
			_timer.timer.remove();
		}
		
		show_message(1);
		
		_timer.timer = UNIT_timerGl_loop(
			function(_0, _timer) {
				show_message(_timer.num);
			}, undefined,
			function(_0, _timer) {
				_timer.timer.remove();
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
							
							_t2.remove();
							_t4.remove();
							
							UNIT_timerGl_timer(_t4);
							UNIT_timerGl_timer(_t2);
							
							var _save = self._fff;
							self._fff = undefined;
							
							UNIT_timerGlobal().clearAll();
							
							show_message("clearAll");
							show_message(_timer.isBind());
							
							UNIT_timerGl_timer(_timer);
							
							self._fff = _save;
							
							_timer.remove();
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
	show_message("end");
}

// 1, 1, 1, &2, 1, clear, &8, 222, 444, fff(), 444, 222, clearAll, 0, &8, 222, 444, fff()
// 1, 1, 1, &2, 1, clear, &8, 222, 444, fff(), 444, 222, clearAll, 0, fff(), end

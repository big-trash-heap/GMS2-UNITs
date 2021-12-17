
hand = new UNIT_TimersHandler();

hand.append(new UNIT_TimerLoop(
	function() {
		show_debug_message("hello world");
	}
));

hand.append(new UNIT_TimerSync(500,
	function() {
		show_debug_message("tick");
	}
));

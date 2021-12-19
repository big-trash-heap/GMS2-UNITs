
anim = new UNIT_Animator(function() {
	show_debug_message("begin");	
});

anim.add_action(function() {
	show_debug_message("press: space");
	if (keyboard_check_pressed(vk_space)) {
		
		anim.replay();
		return UNIT_ANIMATOR_ACTION._NEXT;
	}
});

anim.add_action(function() {
	show_debug_message("press: enter");
	if (keyboard_check_pressed(vk_enter)) return UNIT_ANIMATOR_ACTION._NEXT;
});

anim.add_after(function() {
	
});

room_speed = 5;


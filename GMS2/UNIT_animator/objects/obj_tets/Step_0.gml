
show_debug_message([">> state::anim >>", anim.tick()]);

if (keyboard_check_pressed(vk_control)) {
	anim.replay();
}

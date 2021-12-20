

anim = new UNIT_Animator(function() {
	show_debug_message("begin");	
});

anim.add_action(function() {
	show_debug_message("press: space");
	if (keyboard_check_pressed(vk_space)) return UNIT_ANIMATOR_ACTION._NEXT;
});

anim.add_action(function() {
	show_debug_message("press: enter");
	if (keyboard_check_pressed(vk_enter)) return UNIT_ANIMATOR_ACTION._NEXT;
});

anim.add_after(function() {
	show_message("тебе удалось нажать кнопки на клавиатуре!");
});

anim.add_frame(function() {
	show_message("а теперь нажми другие кнопки");
});

anim.add_action(function() {
	show_debug_message("press: Q");
	if (keyboard_check_pressed(ord("Q"))) return UNIT_ANIMATOR_ACTION._NEXT;
});

anim.add_action(function() {
	show_debug_message("press: Ctrl + Y");
	if (keyboard_check_pressed(ord("Y")) && keyboard_check(vk_control)) return UNIT_ANIMATOR_ACTION._NEXT;
});

anim.add_after(function() {
	show_message("на этом всё");
});

//var _new_anim = anim._clone();

//anim.add_after(function() {
//	show_message("Привет");
//});

//_new_anim.add_after(function(_0, _data) {
//	anim = _data;
//}, anim);

//anim = _new_anim;
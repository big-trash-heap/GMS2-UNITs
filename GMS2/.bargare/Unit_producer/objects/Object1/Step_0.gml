
var _res = audio.tick();
show_debug_message(_res);

if (keyboard_check(vk_space))
	order.pause();
	
if (keyboard_check(vk_control))
	order.play();
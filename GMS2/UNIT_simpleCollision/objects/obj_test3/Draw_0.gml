draw_self();
draw_sprite(sprite_index, 0, mouse_x, mouse_y);


var _result = UNIT_simcollImitationUnit(function(_instance) {
	_instance.x = mouse_x;
	_instance.y = mouse_y;
	_instance.sprite_index = sprite_index;
	return place_meeting(x, y, _instance);
});

draw_text(0, 0, _result);

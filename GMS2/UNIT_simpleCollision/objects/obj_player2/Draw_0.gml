draw_self();

if (UNIT_simcollStepH(x, y, obj_wall, -256))
	draw_set_color(c_yellow);
else
	draw_set_color(c_lime);

draw_sprite_ext(sprite_index, 0, x, y + global.UNIT_simcollDist, 1, 1, 0, c_red, 1);

draw_text(0, 0, global.UNIT_simcollDist);

draw_text(0, 64, place_meeting(x, y + global.UNIT_simcollDist, obj_wall));

if (UNIT_simcollStepW(x, y, obj_wall, -256))
	draw_set_color(c_yellow);
else
	draw_set_color(c_lime);

draw_sprite_ext(sprite_index, 0, x + global.UNIT_simcollDist, y, 1, 1, 0, c_red, 1);

draw_text(0, 0, global.UNIT_simcollDist);

draw_text(0, 64, place_meeting(x + global.UNIT_simcollDist, y, obj_wall));


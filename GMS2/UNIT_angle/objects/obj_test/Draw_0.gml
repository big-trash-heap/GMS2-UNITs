draw_sprite_ext(sprite_index, 0, x, y, 1, 1, direction, c_white, 1);
draw_sprite_ext(sprite_index, 1, x, y, 1, 1, image_angle, c_white, 1);

UNIT_angleDebug_drawCircleSector(x, y, 180, direction, rot.getLength(), true);


var _mouseDir = point_direction(x, y, mouse_x, mouse_y);
var _rotate = 2 * (keyboard_check(ord("A")) - keyboard_check(ord("D")));

rot.addTwist(_rotate);

rot.rotateAngleNoTwist(_mouseDir, 2);

direction   = rot.getTwist();
image_angle = rot.getAngle();

show_debug_message(["twist", rot.getTwist()]);
show_debug_message(["angle", rot.getAngle()]);


//image_angle += UNIT_angleSpeedArcRotate(image_angle, _mouseDir, 1, direction, 45);
//image_angle = UNIT_angleArcRotateWrap(image_angle, _mouseDir, 1, direction, 45);
//image_angle += UNIT_angleSpeedRotate(image_angle, _mouseDir, 4);



/*
var _mouseDir = point_direction(x, y, mouse_x, mouse_y) + 0.21;

//image_angle = UNIT_angleRotate(image_angle,
//	point_direction(x, y, mouse_x, mouse_y),
//	4,
//);

//image_angle = UNIT_angleArcWrap(_mouseDir, direction, 45);
image_angle = UNIT_angleArcRotate(image_angle - 360, _mouseDir, 4, direction, 45);
angle = UNIT_angleArcNearestLimit(_mouseDir + 720, direction, 45);

//direction += 0.75;
show_debug_message(image_angle);


if (keyboard_check(vk_space)) image_angle = _mouseDir;

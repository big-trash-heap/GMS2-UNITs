
var _mouseDir = point_direction(x, y, mouse_x, mouse_y);
var _rotate = 0.78 * (keyboard_check(ord("A")) - keyboard_check(ord("D")));

direction  += _rotate;
//image_angle = UNIT_angleArcRotate(image_angle, _mouseDir, 0.7, direction, 90);

image_angle += UNIT_angleSpeedArcRotate(image_angle, _mouseDir, 0.7, direction, 120);

if (keyboard_check(vk_space)) {
	
	image_angle = _mouseDir;
}

//s += _rotate;
//show_debug_message(["s", s, UNIT_angleWrap(s)]);

/*
rot.addTwist(_rotate);

//rot.setTwist(rot.getTwist() + _rotate);
//rot.setTwistNoAngle(rot.getTwist() + _rotate);

rot.rotateAngleTwist(_mouseDir, 0.7);
//rot.setAngleTwist(_mouseDir);

direction   = rot.getTwist();
image_angle = rot.getAngleTwist();

show_debug_message(["direction: ", direction]);
show_debug_message(["image_angle: ", image_angle]);

//show_debug_message(["twist", rot.getTwist()]);
//show_debug_message(["angle", rot.getAngleTwist()]);


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

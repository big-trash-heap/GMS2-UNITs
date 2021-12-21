

map = ds_map_create();
map[? "map"] = [
	0,
	{
		map: map
	}
];

map[? "good"] = ["x", "y"];


f = UNIT_getterAccess("?", "map", "@", 1, "$", "map", "?", "good", "m", function(_value) {
	show_debug_message(_value);
	return string(_value);
}, "s", 4, "m", ord, "m", function(_number) {
	return [_number]
}, "@", 0, "m", chr);

show_message(f(map));

f = UNIT_getterCall(function(_argument, _data) {
	return _data[_argument];
}, ["hello", "world"]);

show_message(f(1));

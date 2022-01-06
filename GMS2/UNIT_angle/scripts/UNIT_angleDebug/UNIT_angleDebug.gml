

/// @function		UNIT_angleDebug_drawCircleSector(x, y, r, arcAngle, arcLength, [outline=false], [color], [alpha], [precision=1]);
function UNIT_angleDebug_drawCircleSector(_x, _y, _r, _arcAngle, _arcLength, _outline=false, _color=draw_get_color(), _alpha=draw_get_alpha(), _precision=1) {
	
	if (sign(_arcLength) < 1) return;
	_precision = max(1, _precision);
	
	draw_primitive_begin(_outline ? pr_linestrip : pr_trianglefan);
	draw_vertex_color(_x, _y, _color, _alpha);
	
	var _arcLengthHalf = _arcLength / 2;
	var _arcTurn       = _arcAngle - _arcLengthHalf;
	
	var _iter = round(_arcLength / _precision), _i = 0;
	for (;_i < _iter; ++_i) {
		
		draw_vertex(
			_x + lengthdir_x(_r, _arcTurn),
			_y + lengthdir_y(_r, _arcTurn),
		);
		
		_arcTurn += _precision;
	}
	
	_arcTurn = _arcAngle + _arcLengthHalf;
	draw_vertex(
		_x + lengthdir_x(_r, _arcTurn),
		_y + lengthdir_y(_r, _arcTurn),
	);
	
	draw_vertex(_x, _y);
	draw_primitive_end();
}


#region __private

function UNIT_angleDebug() {};

#endregion



var _mx = (mouse_x - room_width / 2) + 0.0000078;
var _xx = UNIT_mthWrap2(_mx, 10, 360);
draw_text(0, 0, [string_format(_mx, 0, 8), string_format(_xx, 0, 8)]);

var _j = 0;
draw_text(0, (++_j) * 32, UNIT_mthWrap2(10, 10, 360));  // 10  // 
draw_text(0, (++_j) * 32, UNIT_mthWrap2(360, 10, 360)); // 360 // 
draw_text(0, (++_j) * 32, UNIT_mthWrap2(9, 10, 360));   // 369 // no correct?
draw_text(0, (++_j) * 32, UNIT_mthWrap2(361, 10, 360)); // 1   // no correct?
draw_text(0, (++_j) * 32, UNIT_mthWrap2(360.0000078, 10, 360)); // 360.0000078   // no correct?

//var _angle = 360.000025;
//show_message( string_format(_angle + ceil(-_angle / 360) * 360, 0, 8) );

return;
CE_Wrap(10, 10, 360);  // expect 10  // receive 10
CE_Wrap(360, 10, 360); // expect 10  // receive 360
CE_Wrap(9, 10, 360);   // expect 359 // receive 369
CE_Wrap(361, 10, 360); // expect 11  // receive 1
CE_Wrap(360.0000078,
		10, 360);      // expect 10.0000078  // receive 360.0000078


//
if (self.tileDebugDraw and variable_struct_exists(self.tileCurrentObj, "draw")) {
	
	UNIT_tileDebugDraw(self.tileCurrentTile, 0, 0, self.tileCurrentObj.draw);
}

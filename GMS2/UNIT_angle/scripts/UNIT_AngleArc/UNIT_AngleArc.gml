

function UNIT_AngleArc(_arcAngle, _arcLength, _angle) constructor {
	
	#region __private
	
	self.__arcAngle  = 0;
	self.__arcLength = 0;
	self.__angle     = 0;
	
	self.__angLengthHalf = (sign(self.__arcLength) == 0 ? 0 : self.__arcLength / 2);
	
	#endregion
	
}


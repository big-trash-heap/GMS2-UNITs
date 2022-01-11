

function UNIT_AngleArc(_arcAngle, _arcLength, _angle=0) constructor {
	
	#region __private
	
	self.__arcAngle  = UNIT_angleWrap(_arcAngle);
	self.__arcLength = max(0, _arcLength);
	
	self.__angLengthHalf = (sign(self.__arcLength) == 0 ? 0 : self.__arcLength / 2);
	
	self.__angle = UNIT_angleArcWrap(_angle, self.__arcAngle, self.__angLengthHalf);
	
	#endregion
	
	static setLength = function(_arcLength) {
		
		self.__arcLength = max(0, _arcLength);
		self.__angLengthHalf = (sign(self.__arcLength) == 0 ? 0 : self.__arcLength / 2);
		self.__angle = UNIT_angleArcWrap(_angle, self.__arcAngle, self.__angLengthHalf);
		
		return self;
	}
	
	static addLength = function(_arcLength) {
		
		return self.setLength(self.__arcLength + _arcLength);
	}
	
	static getLength = function() {
		return self.__arcLength;
	}
	
	static getLengthHalf = function() {
		return self.__angLengthHalf;
	}
	
	
	static setArcAngle = function(_arcAngle) {
		self.__arcAngle = UNIT_angleWrap(_arcAngle);
		return self;
	}
	
	static addArcAngle = function(_arcAngle) {
		self.__arcAngle = UNIT_angleWrap(self.__arcAngle + _arcAngle);
		return self;
	}
	
	static getArcAngle = function() {
		return self.__arcAngle;
	}
	
	
	static setAngle = function(_angle) {
		self.__angle = UNIT_angleArcWrap(_angle, self.__arcAngle, self.__angLengthHalf);
		return self;
	}
	
	static addAngle = function(_angle) {
		self.__angle = UNIT_angleArcWrap(self.__angle + _angle, self.__arcAngle, self.__angLengthHalf);
		return self;
	}
	
	static getAngle = function() {
		return self.__angle;
	}
	
	static rotateAngle = function(_angleRequired, _speed, _accuracy) {
		self.__angle = UNIT_angleArcRotateWrap(self.__angle, _angleRequired, _speed, 0, self.__angLengthHalf, _accuracy);
		return self;
	}
	
	
	static setAngleTwist = function(_angle) {
		self.__angle = UNIT_angleArcWrap(_angle - self.__arcAngle, self.__arcAngle, self.__angLengthHalf);
		return self;
	}
	
	static getAngleTwist = function() {
		return UNIT_angleArcWrap(self.__angle + self.__arcAngle, self.__arcAngle, self.__angLengthHalf);
	}
	
	static rotateAngleTwist = function(_angleRequired, _speed, _accuracy) {
		self.__angle = UNIT_angleWrap(UNIT_angleArcRotate(self.__angle + self.__arcAngle,
			_angleRequired, _speed, self.__arcAngle, self.__angLengthHalf, _accuracy
		) - self.__arcAngle);
		return self;
	}
	
	
}


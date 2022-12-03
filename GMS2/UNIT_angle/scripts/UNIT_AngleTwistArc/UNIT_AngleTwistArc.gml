

function UNIT_AngleTwistArc(_arcLength=90, _twist=0, _angle=0) constructor {
	
	/// TODO: rework
	
	#region __private
	
	self.__twist  = UNIT_angleWrap(_twist);
	self.__length = max(0, _arcLength);
	
	self.__lengthHalf = (sign(self.__length) == 0 ? 0 : self.__length / 2);
	
	self.__angle = UNIT_angleArcWrap(_angle, self.__twist, self.__lengthHalf);
	
	#endregion
	
	static setLength = function(_arcLength) {
		
		self.__length = max(0, _arcLength);
		self.__lengthHalf = (sign(self.__length) == 0 ? 0 : self.__length / 2);
		self.__angle = UNIT_angleArcWrap(_angle, self.__twist, self.__lengthHalf);
		
		return self;
	}
	
	static addLength = function(_arcLength) {
		
		return self.setLength(self.__length + _arcLength);
	}
	
	static getLength = function() {
		return self.__length;
	}
	
	static getLengthHalf = function() {
		return self.__lengthHalf;
	}
	
	
	static setTwist = function(_twist) {
		self.__twist = UNIT_angleWrap(_twist);
		return self;
	}
	
	static addTwist = function(_twist) {
		self.__twist = UNIT_angleWrap(self.__twist + _twist);
		return self;
	}
	
	static getTwist = function() {
		return self.__twist;
	}
	
	
	static setAngle = function(_angle) {
		self.__angle = UNIT_angleArcWrap(_angle, self.__twist, self.__lengthHalf);
		return self;
	}
	
	static addAngle = function(_angle) {
		self.__angle = UNIT_angleArcWrap(self.__angle + _angle, self.__twist, self.__lengthHalf);
		return self;
	}
	
	static getAngle = function() {
		return self.__angle;
	}
	
	static rotateAngle = function(_angleRequired, _speed, _accuracy) {
		self.__angle = UNIT_angleArcRotateWrap(self.__angle, _angleRequired, _speed, 0, self.__lengthHalf, _accuracy);
		return self;
	}
	
	
	static setAngleTwist = function(_angle) {
		self.__angle = UNIT_angleArcWrap(_angle - self.__twist, self.__twist, self.__lengthHalf);
		return self;
	}
	
	static getAngleTwist = function() {
		return UNIT_angleArcWrap(self.__angle + self.__twist, self.__twist, self.__lengthHalf);
	}
	
	static rotateAngleTwist = function(_angleRequired, _speed, _accuracy) {
		self.__angle = UNIT_angleWrap(UNIT_angleArcRotate(self.__angle + self.__twist,
			_angleRequired, _speed, self.__twist, self.__lengthHalf, _accuracy
		) - self.__twist);
		return self;
	}
	
	
	static toString = function() {
		return ("UNIT::angle::UNIT_AngleArc(angle: " + string(self.__angle) +
			", twist: " + string(self.__twist) + ", angleTwist: " + string(self.getAngleTwist()) + ")"
		);
	}
	
	
}


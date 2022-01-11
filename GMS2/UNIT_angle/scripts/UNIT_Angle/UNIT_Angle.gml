

/// @function		UNIT_Angle([angle=0]);
function UNIT_Angle(_angle=0) constructor {
	
	#region __private
	
	self.__angle = UNIT_angleWrap(_angle);
	
	#endregion
	
	static setAngle = function(_angle) {
		self.__angle = UNIT_angleWrap(_angle);
		return self;
	}
	
	static addAngle = function(_angle) {
		self.__angle = UNIT_angleWrap(self.__angle + _angle);
		return self;
	}
	
	static getAngle = function() {
		return self.__angle;
	}
	
	static rotateAngle = function(_angleRequired, _speed, _accuracy) {
		self.__angle = UNIT_angleWrap(UNIT_angleRotate(self.__angle, 
			_angleRequired, _speed, _accuracy
		));
		return self;
	}
	
	
	static toString = function() {
		return ("UNIT::angle::UNIT_Angle(angle: " + string(self.__angle) + ")");	
	}
	
}

/// @function		UNIT_AngleTwist([twist=0], [angle=0]);
function UNIT_AngleTwist(_twist=0, _angle) : UNIT_Angle(_angle) constructor {
	
	#region __private
	
	self.__twist = UNIT_angleWrap(_twist);
	
	#endregion
	
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
	
	
	static setTwistNoAngle = function(_twist) {
		var _diff    = self.__twist - _twist;
		self.__twist = UNIT_angleWrap(_twist);
		self.__angle = UNIT_angleWrap(self.__angle + _diff);
		return self;
	}
	
	static addTwistNoAngle = function(_twist) {
		self.__twist = UNIT_angleWrap(self.__twist + _twist);
		self.__angle = UNIT_angleWrap(self.__angle - _twist);
		return self;
	}
	
	
	static setAngleTwist = function(_angle) {
		self.__angle = UNIT_angleWrap(_angle - self.__twist);
		return self;
	}
	
	static getAngleTwist = function() {
		return UNIT_angleWrap(self.__angle + self.__twist);
	}
	
	static rotateAngleTwist = function(_angleRequired, _speed, _accuracy) {
		self.__angle = UNIT_angleWrap(UNIT_angleRotate(self.__angle + self.__twist,
			_angleRequired, _speed, _accuracy
		) - self.__twist);
		return self;
	}
	
	
	static toString = function() {
		return ("UNIT::angle::UNIT_AngleTwist(angle: " + string(self.__angle) +
			", twist: " + string(self.__twist) + ", angleTwist: " + string(self.getAngleTwist()) + ")"
		);
	}
	
}


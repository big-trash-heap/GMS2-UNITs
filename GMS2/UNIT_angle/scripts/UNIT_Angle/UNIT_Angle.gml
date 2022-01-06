

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
	
}

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
	
	static getAngle = function() {
		return UNIT_angleWrap(self.__angle + self.__twist);	
	}
	
	static setAngleNoTwist = function(_angle) {
		self.__angle = UNIT_angleWrap(_angle - self.__twist);
		return self;
	}
	
	static getAngleNoTwist = function() {
		return self.__angle;
	}
	
	static rotateAngleNoTwist = function(_angleRequired, _speed, _accuracy) {
		self.__angle = UNIT_angleWrap(UNIT_angleRotate(self.__angle + self.__twist,
			_angleRequired, _speed, _accuracy
		) - self.__twist);
		return self;
	}
	
}


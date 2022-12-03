
enum UNIT_TM_CATEGORY { _TIMER, _HANDLER };

function UNIT_tmCategoryIsTimer(_struct) {
	try {
		return (_struct.getCategory() == UNIT_TM_CATEGORY._TIMER);
	}
	catch (_e) {
		return false;
	}
}

function UNIT_tmCategoryIsHandler(_struct) {
	try {
		return (_struct.getCategory() == UNIT_TM_CATEGORY._HANDLER);
	}
	catch (_e) {
		return false;
	}
}


#region __private

function UNIT_tmMain() {};

#endregion

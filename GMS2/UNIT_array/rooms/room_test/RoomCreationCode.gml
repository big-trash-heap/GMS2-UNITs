

function apiFunctorId(_value) {
	var _ = argument[1];
	return _value;
}

function apiDebugAssert(_assert=undefined, _mess=undefined) {
	if (!_assert) {
		
		clipboard_set_text("\"" + _mess + "\"");
		throw ("\n\t" + _mess);
	}
}

var _f = apiFunctorId;
var array;
		
#region UNIT_arrPlace
		
_array = [1, 2, 3, 4, 5];
		
apiDebugAssert(
	array_equals(_f(_array, UNIT_arrPlace(_array)), [1, 2, 3, 4, 5]),
	"<UNIT_arrPlace empty>"
);
		
apiDebugAssert(
	array_equals(
		_f(_array, UNIT_arrPlace(_array, undefined, 8, 9)), 
		[1, 2, 3, 4, 5, 8, 9]
	),
	"<UNIT_arrPlace push>"
);
		
apiDebugAssert(
	array_equals(
		_f(_array, UNIT_arrPlace(_array, 0, -1, -2)), 
		[-1, -2, 3, 4, 5, 8, 9]
	),
	"<UNIT_arrPlace replace>"
);
		
apiDebugAssert(
	array_equals(
		_f(_array, UNIT_arrPlace(_array, 3, -4, -5)), 
		[-1, -2, 3, -4, -5, 8, 9]
	),
	"<UNIT_arrPlace replace>"
);
		
apiDebugAssert(
	array_equals(
		_f(_array, UNIT_arrPlace(_array, 4, 0, 1, 2, 3, 4)), 
		[-1, -2, 3, -4, 0, 1, 2, 3, 4]
	),
	"<UNIT_arrPlace resize>"
);
		
_array = [1, 2, 3, 4];
apiDebugAssert(
	array_equals(
		_f(_array, UNIT_arrPlace(_array, 8, 0, 8, 16)), 
		[1, 2, 3, 4, 0, 0, 0, 0, 
			0, 8, 16]
	),
	"<UNIT_arrPlace out>"
);
		
show_debug_message("\t UNIT_arrPlace \t\tis work");
		
#endregion
		
#region UNIT_arrInsEm
		
_array = [1, 2, 3, 4, 5];
apiDebugAssert(
	array_equals(
		_f(_array, UNIT_arrInsEm(_array, 0, 2)), 
		[1, 2, 1, 2, 3, 4, 5]
	),
	"<UNIT_arrInsEm begin insert>"
);
		
_array = [1, 2, 3, 4, 5];
apiDebugAssert(
	array_equals(
		_f(_array, UNIT_arrInsEm(_array, 0, 2, -1)), 
		[-1, -1, 1, 2, 3, 4, 5]
	),
	"<UNIT_arrInsEm begin insert and fill>"
);
		
_array = [1, 2, 3, 4, 5];
apiDebugAssert(
	array_equals(
		_f(_array, UNIT_arrInsEm(_array, 3, 4)), 
		[1, 2, 3, 4, 5, 0, 0, 4, 5]
	),
	"<UNIT_arrInsEm begin insert middle>"
);
		
_array = [1, 2, 3, 4, 5];
apiDebugAssert(
	array_equals(
		_f(_array, UNIT_arrInsEm(_array, 3, 4, -1)), 
		[1, 2, 3, -1, -1, -1, -1, 4, 5]
	),
	"<UNIT_arrInsEm begin insert middle and fill>"
);
		
_array = [1, 2, 3, 4, 5];
apiDebugAssert(
	array_equals(
		_f(_array, UNIT_arrInsEm(_array, 8, 4)), 
		[1, 2, 3, 4, 5, 0, 0, 0,
			0, 0, 0, 0]
	),
	"<UNIT_arrInsEm begin insert out array>"
);
		
_array = [1, 2, 3, 4, 5];
apiDebugAssert(
	array_equals(
		_f(_array, UNIT_arrInsEm(_array, 5, 2)), 
		[1, 2, 3, 4, 5,
			0, 0]
	),
	"<UNIT_arrInsEm push>"
);
		
_array = [1, 2, 3, 4, 5];
apiDebugAssert(
	array_equals(
		_f(_array, UNIT_arrInsEm(_array, 5, 2, 9)), 
		[1, 2, 3, 4, 5,
			9, 9]
	),
	"<UNIT_arrInsEm push and fill>"
);
		
_array = [1, 2, 3, 4, 5];
apiDebugAssert(
	array_equals(
		_f(_array, UNIT_arrInsEm(_array, 8, 4, 9)), 
		[1, 2, 3, 4, 5, 
			9, 9, 9,
			9, 9, 9, 9]
	),
	"<UNIT_arrInsEm begin insert out array and fill>"
);
		
show_debug_message("\t UNIT_arrInsEm \t\tis work");
		
#endregion
		
#region UNIT_arrUnshift
		
_array = [1, 2, 3, 4, 5];

apiDebugAssert(
	array_equals(
		_f(_array, UNIT_arrUnshift(_array, 8, 9)), 
		[8, 9, 1, 2, 3, 4, 5]
	),
	"<UNIT_arrUnshift 0>"
);
		
apiDebugAssert(
	array_equals(
		_f(_array, UNIT_arrUnshift(_array, 7, 0, 88)), 
		[7, 0, 88, 8, 9, 1, 2, 3, 4, 5]
	),
	"<UNIT_arrUnshift 1>"
);
		
apiDebugAssert(
	array_equals(
		_f(_array, UNIT_arrUnshift(_array)), 
		[7, 0, 88, 8, 9, 1, 2, 3, 4, 5]
	),
	"<UNIT_arrUnshift 2>"
);
		
show_debug_message("\t UNIT_arrUnshift \t\tis work");
		
#endregion
		
#region UNIT_arrShuffle
		
var _check = function(_array, _ref) {
	var _size = array_length(_array);
	var _rfsz = array_length(_ref);
	for (var _i = 0, _j; _i < _size; ++_i) {
		for (_j = 0;     _j < _rfsz; ++_j) {
			if (_array[_i] == _ref[_j]) {
				_j = -1;
				break;
			}
		}
		if (_j == -1) continue;
		return false;
	}
	return true;
}
var _modif;
		
_array = [[], [], [], [], [], [], []];
apiDebugAssert(
	_check(
		_array, _array
	),
	"<UNIT_arrShuffle check>"
);
		
_modif = UNIT_arrBulDup1d(_array);
apiDebugAssert(
	_check(
		_array, _modif
	) && (_array != _modif),
	"<UNIT_arrShuffle dup1d>"
);
		
apiDebugAssert(
	_check(
		_f(_array, UNIT_arrShuffle(_array)),
		_modif
	),
	"<UNIT_arrShuffle eq ref 0>"
);
		
apiDebugAssert(
	_check(
		_f(_array, UNIT_arrShuffle(_array)),
		_modif
	),
	"<UNIT_arrShuffle eq ref 1>"
);
		
apiDebugAssert(
	_check(
		_f(_array, UNIT_arrShuffle(_array)),
		_modif
	),
	"<UNIT_arrShuffle eq ref 2>"
);
		
var _countShuffle = 0;
_array = [1, 2, 3, 4, 5, 6, 7, 8];
repeat 150 {
	_modif = UNIT_arrBulDup1d(_array);
	UNIT_arrShuffle(_modif);
	_countShuffle += !array_equals(_array, _modif);
}
		
apiDebugAssert(
	_countShuffle > 0,
	"UNIT_arrShuffle random"
);
		
show_debug_message("\t UNIT_arrShuffle \t\tis work");
		
#endregion
		
#region UNIT_arrCop
		
_array = [1, 2, 3, 4, 5];
apiDebugAssert(
	array_equals(
		_f(_array, UNIT_arrCop(_array, 0, [1, 2, 3, 4, 5])), 
		[1, 2, 3, 4, 5]
	),
	"<UNIT_arrCop 0>"
);
		
apiDebugAssert(
	array_equals(
		_f(_array, UNIT_arrCop(_array, 0, [8, 1, 2, 4, 2])), 
		[8, 1, 2, 4, 2]
	),
	"<UNIT_arrCop 1>"
);
		
apiDebugAssert(
	array_equals(
		_f(_array, UNIT_arrCop(_array, 0, [0, 15, 9])), 
		[0, 15, 9, 4, 2]
	),
	"<UNIT_arrCop 2>"
);
		
apiDebugAssert(
	array_equals(
		_f(_array, UNIT_arrCop(_array, 0, [0, 1, 2, 4, 3, 2, 1])), 
		[0, 1, 2, 4, 3, 2, 1]
	),
	"<UNIT_arrCop 3>"
);
		
_array = [1, 2, 3, 4, 5];
apiDebugAssert(
	array_equals(
		_f(_array, UNIT_arrCop(_array, 8, [0, 6, 8, 9])), 
		[1, 2, 3, 4, 5, 0, 0, 0,
			0, 6, 8, 9]
	),
	"<UNIT_arrCop 4>"
);
		
var _check = [1, 2, 3, 4, 5];
array_copy(_check, 8, [0, 6, 8, 9], 0, 4);
apiDebugAssert(
	array_equals(
		_array, 
		[1, 2, 3, 4, 5, 0, 0, 0,
			0, 6, 8, 9]
	),
	"<UNIT_arrCop 4.1>"
);
		
_array = [1, 2, 3, 4, 5];
apiDebugAssert(
	array_equals(
		_f(_array, UNIT_arrCop(_array, 20, [])), 
		[1, 2, 3, 4, 5]
	),
	"<UNIT_arrCop 5>"
);
		
_array = [1, 2, 3, 4, 5];
apiDebugAssert(
	array_equals(
		_f(_array, UNIT_arrCop(_array, 8, [0, 6, 8, 9], 1, 2)), 
		[1, 2, 3, 4, 5, 0, 0, 0,
			6, 8]
	),
	"<UNIT_arrCop 6>"
);
		
_array = [1, 2, 3, 4, 5, 6, 7, 8];
apiDebugAssert(
	array_equals(
		_f(_array, UNIT_arrCop(_array, 2, _array, 0, 4)), 
		[1, 2, 1, 2, 3, 4, 7, 8]
	),
	"<UNIT_arrCop eq |-|>"
);
		
_check = [1, 2, 3, 4, 5, 6, 7, 8];
array_copy(_check, 2, _check, 0, 4);
apiDebugAssert(
	array_equals(
		_check, 
		_array
	),
	"<UNIT_arrCop eq |-| def>"
);
		
_array = [1, 2, 3, 4, 5, 6, 7, 8];
apiDebugAssert(
	array_equals(
		_f(_array, UNIT_arrCop(_array, 0, _array, 2, 4)), 
		[3, 4, 5, 6, 5, 6, 7, 8]
	),
	"<UNIT_arrCop eq |+|>"
);
		
_check = [1, 2, 3, 4, 5, 6, 7, 8];
array_copy(_array, 0, _array, 2, 4);
apiDebugAssert(
	!array_equals(
		_check, 
		_array
	),
	"<UNIT_arrCop eq |+| def>"
);
		
	//dest_index < src_index
//apiDebugPrint("\teq |+| def:", _array);
		
show_debug_message("\t UNIT_arrCop \t\t\tis work");
		
#endregion
		
#region UNIT_arrIns
		
_array = [1, 2, 3, 4];
apiDebugAssert(
	array_equals(
		_f(_array, UNIT_arrIns(_array, 0, [8, 9])), 
		[8, 9, 1, 2, 3, 4]
	),
	"<UNIT_arrIns 0>"
);
		
_array = [1, 2, 3, 4];
apiDebugAssert(
	array_equals(
		_f(_array, UNIT_arrIns(_array, 4, [8, 9])), 
		[1, 2, 3, 4, 8, 9]
	),
	"<UNIT_arrIns 1>"
);
		
_array = [1, 2, 3, 4];
apiDebugAssert(
	array_equals(
		_f(_array, UNIT_arrIns(_array, 8, [8, 9])), 
		[1, 2, 3, 4, 0, 0, 0, 0,
			8, 9]
	),
	"<UNIT_arrIns 2>"
);
		
_array = [1, 2, 3, 4];
apiDebugAssert(
	array_equals(
		_f(_array, UNIT_arrIns(_array, 2, [8, 9])), 
		[1, 2, 8, 9, 3, 4]
	),
	"<UNIT_arrIns 3>"
);
		
_array = [1, 2, 3, 4];
apiDebugAssert(
	array_equals(
		_f(_array, UNIT_arrIns(_array, 2, [])), 
		[1, 2, 3, 4]
	),
	"<UNIT_arrIns 4>"
);
		
_array = [1, 2, 3, 4];
apiDebugAssert(
	array_equals(
		_f(_array, UNIT_arrIns(_array, 10, [])), 
		[1, 2, 3, 4]
	),
	"<UNIT_arrIns 5>"
);
		
_array = [1, 2, 3, 4];
apiDebugAssert(
	array_equals(
		_f(_array, UNIT_arrIns(_array, 0, [])), 
		[1, 2, 3, 4]
	),
	"<UNIT_arrIns 6>"
);
		
_array = [1, 2, 3, 4];
apiDebugAssert(
	array_equals(
		_f(_array, UNIT_arrIns(_array, 0, _array)), 
		[1, 2, 3, 4, 1, 2, 3, 4]
	),
	"<UNIT_arrIns 7>"
);
		
_array = [1, 2, 3, 4];
apiDebugAssert(
	array_equals(
		_f(_array, UNIT_arrIns(_array, 2, _array)), 
		[1, 2, 1, 2, 3, 4, 3, 4]
	),
	"<UNIT_arrIns 8>"
);
		
_array = [1, 2, 3, 4];
apiDebugAssert(
	array_equals(
		_f(_array, UNIT_arrIns(_array, 8, _array)), 
		[1, 2, 3, 4, 0, 0, 0, 0,
			1, 2, 3, 4]
	),
	"<UNIT_arrIns 9>"
);
		
_array = [1, 2, 3, 4];
apiDebugAssert(
	array_equals(
		_f(_array, UNIT_arrIns(_array, 8, _array, 2)), 
		[1, 2, 3, 4, 0, 0, 0, 0,
			3, 4]
	),
	"<UNIT_arrIns 10>"
);
		
_array = [1, 2, 3, 4];
apiDebugAssert(
	array_equals(
		_f(_array, UNIT_arrIns(_array, 8, _array, 0, 2)), 
		[1, 2, 3, 4, 0, 0, 0, 0,
			1, 2]
	),
	"<UNIT_arrIns 11>"
);
		
_array = [1, 2, 3, 4];
apiDebugAssert(
	array_equals(
		_f(_array, UNIT_arrIns(_array, 8, _array, 1, 2)), 
		[1, 2, 3, 4, 0, 0, 0, 0,
			2, 3]
	),
	"<UNIT_arrIns 12>"
);
		
_array = [1, 2, 3, 4];
apiDebugAssert(
	array_equals(
		_f(_array, UNIT_arrIns(_array, 0, [10, 11, 12, 13], 2)), 
		[12, 13, 1, 2, 3, 4]
	),
	"<UNIT_arrIns 13>"
);
		
_array = [1, 2, 3, 4];
apiDebugAssert(
	array_equals(
		_f(_array, UNIT_arrIns(_array, 0, [10, 11, 12, 13], 1, 2)), 
		[11, 12, 1, 2, 3, 4]
	),
	"<UNIT_arrIns 14>"
);
		
_array = [1, 2, 3, 4];
apiDebugAssert(
	array_equals(
		_f(_array, UNIT_arrIns(_array, 8, [10, 11, 12, 13], 1, 2)), 
		[1, 2, 3, 4, 0, 0, 0, 0,
			11, 12]
	),
	"<UNIT_arrIns 15>"
);
		
_array = [1, 2, 3, 4];
apiDebugAssert(
	array_equals(
		_f(_array, UNIT_arrIns(_array, 2, [10, 11, 12, 13], 1, 2)), 
		[1, 2, 11, 12, 3, 4]
	),
	"<UNIT_arrIns 16>"
);
		
show_debug_message("\t UNIT_arrIns  \t\t\tis work");
		
#endregion
		
//#region UNIT_arrBulConcat
		
//_array = UNIT_arrBulConcat(1, 2, [3, 4, 5], 6);
//apiDebugAssert(
//	array_equals(
//		_array, 
//		[1, 2, 3, 4, 5, 6]
//	),
//	"<UNIT_arrBulConcat 0>"
//);
		
//_array = UNIT_arrBulConcat([1, 2, 3], 9, [4, 5], 8);
//apiDebugAssert(
//	array_equals(
//		_array, 
//		[1, 2, 3, 9, 4, 5, 8]
//	),
//	"<UNIT_arrBulConcat 1>"
//);
		
//_array = UNIT_arrBulConcat(1, 2, 3);
//apiDebugAssert(
//	array_equals(
//		_array, 
//		[1, 2, 3]
//	),
//	"<UNIT_arrBulConcat 2>"
//);
		
//_array = UNIT_arrBulConcat([1], [2], [3]);
//apiDebugAssert(
//	array_equals(
//		_array, 
//		[1, 2, 3]
//	),
//	"<UNIT_arrBulConcat 3>"
//);
		
//_array = UNIT_arrBulConcat([], []);
//apiDebugAssert(
//	array_equals(
//		_array, 
//		[]
//	),
//	"<UNIT_arrBulConcat 4>"
//);
		
//_array = UNIT_arrBulConcat();
//apiDebugAssert(
//	array_equals(
//		_array, 
//		[]
//	),
//	"<UNIT_arrBulConcat 5>"
//);
		
//show_debug_message("\t UNIT_arrBulConcat \t\tis work");
		
//#endregion








var _f = function(_value) { return _value > 5; };
var array;
		
var _sample0 = [1, 8, 4, 1, 10, 20, -1, 3, 7, 11, 1];
var _sample1 = [1, "hello", 1, 2, undefined, "world", [], {}, 123, 1];
		
#region UNIT_arrFilter
		
_array = UNIT_arrBulDup1d(_sample0);
UNIT_arrFilter(_array, _f);
		
apiDebugAssert(
	array_equals(_array, [8, 10, 20, 7, 11]),
	"<UNIT_arrFilter 0>"
);
		
_array = UNIT_arrBulDup1d(_sample1);
UNIT_arrFilter(_array, is_string);
		
apiDebugAssert(
	array_equals(_array, ["hello", "world"]),
	"<UNIT_arrFilter 1>"
);
		
show_debug_message("\t UNIT_arrFilter  \t\tis work");
		
#endregion
		
#region UNIT_arrBulFilter
		
apiDebugAssert(
	array_equals(UNIT_arrBulFilter(_sample0, _f), [8, 10, 20, 7, 11]),
	"<UNIT_arrBulFilter 0>"
);
		
apiDebugAssert(
	array_equals(UNIT_arrBulFilter(_sample1, is_string), ["hello", "world"]),
	"<UNIT_arrBulFilter 1>"
);
		
show_debug_message("\t UNIT_arrBulFilter \tis work");
		
#endregion
		





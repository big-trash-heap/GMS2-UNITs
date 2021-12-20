function apiDebugAssert(_assert, _mess) {
	if (!_assert) {
		
		clipboard_set_text("\"" + _mess + "\"");
		throw ("\n\t" + _mess);
	}
}

apiDebugAssert(
	UNIT_compOrdStr("aa", "aa") == UNIT_COMP_EQ,
	"<UNIT_compOrdStr eq 1>"
);
		
apiDebugAssert(
	UNIT_compOrdStr("", "") == UNIT_COMP_EQ,
	"<UNIT_compOrdStr eq 2>"
);
		
apiDebugAssert(
	UNIT_compOrdStr("hello", "hello") == UNIT_COMP_EQ,
	"<UNIT_compOrdStr eq 3>"
);
		
apiDebugAssert(
	UNIT_compOrdStr("aa", "ab") == UNIT_COMP_LT,
	"<UNIT_compOrdStr lt 1>"
);
		
apiDebugAssert(
	(UNIT_compOrdStr("aa", "ab") == UNIT_COMP_LT) == ("aa" < "ab"),
	"<UNIT_compOrdStr lt 1.1>"
);
		
apiDebugAssert(
	UNIT_compOrdStr("a", "ab") == UNIT_COMP_LT,
	"<UNIT_compOrdStr lt 2>"
);
		
apiDebugAssert(
	(UNIT_compOrdStr("a", "ab") == UNIT_COMP_LT) == ("a" < "ab"),
	"<UNIT_compOrdStr lt 2.1>"
);
		
apiDebugAssert(
	UNIT_compOrdStr("aac", "abc") == UNIT_COMP_LT,
	"<UNIT_compOrdStr lt 3>"
);
		
apiDebugAssert(
	(UNIT_compOrdStr("aac", "abc") == UNIT_COMP_LT) == ("aac" < "abc"),
	"<UNIT_compOrdStr lt 3.1>"
);
		
apiDebugAssert(
	UNIT_compOrdStr("ab", "b") == UNIT_COMP_LT,
	"<UNIT_compOrdStr lt 4>"
);
		
apiDebugAssert(
	(UNIT_compOrdStr("ab", "b") == UNIT_COMP_LT) == ("ab" < "b"),
	"<UNIT_compOrdStr lt 4.1>"
);
		
apiDebugAssert(
	UNIT_compOrdStr("ab", "aa") == UNIT_COMP_GT,
	"<UNIT_compOrdStr gt 1>"
);
		
apiDebugAssert(
	(UNIT_compOrdStr("ab", "aa") == UNIT_COMP_GT) == ("ab" > "aa"),
	"<UNIT_compOrdStr gt 1.1>"
);
		
apiDebugAssert(
	UNIT_compOrdStr("ab", "a") == UNIT_COMP_GT,
	"<UNIT_compOrdStr gt 2>"
);
		
apiDebugAssert(
	(UNIT_compOrdStr("ab", "a") == UNIT_COMP_GT) == ("ab" > "a"),
	"<UNIT_compOrdStr gt 2.1>"
);
		
apiDebugAssert(
	UNIT_compOrdStr("abc", "aac") == UNIT_COMP_GT,
	"<UNIT_compOrdStr gt 3>"
);
		
apiDebugAssert(
	(UNIT_compOrdStr("abc", "aac") == UNIT_COMP_GT) == ("abc" > "aac"),
	"<UNIT_compOrdStr gt 3.1>"
);
		
apiDebugAssert(
	UNIT_compOrdStr("b", "ab") == UNIT_COMP_GT,
	"<UNIT_compOrdStr gt 4>"
);
		
apiDebugAssert(
	(UNIT_compOrdStr("b", "ab") == UNIT_COMP_GT) == ("b" > "ab"),
	"<UNIT_compOrdStr gt 4.1>"
);
		
show_debug_message("\t UNIT_compOrdStr \t\tis work");
		
var _array = ["Message", "World", "Map", "Dota", "Haskell is good language"];
array_sort(_array, method(undefined, UNIT_compOrdStr));
		
apiDebugAssert(
	array_equals(
		["Dota", "Haskell is good language", "Map", "Message", "World"], _array
	),
	"<UNIT_compOrdStr array_sort>"
);
		
var _array = [4, "Message", "World", 100, "Map", "Dota", 234, "Haskell is good language", -1];
array_sort(_array, method(undefined, UNIT_compOrdNS));
		
apiDebugAssert(
	array_equals(
		[-1, 4, 100, 234, "Dota", "Haskell is good language", "Map", "Message", "World"], _array
	),
	"<UNIT_compOrdStr array_sort NS>"
);

show_debug_message("all good");
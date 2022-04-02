
function apiDebugAssert(_assert, _mess) {
	if (!_assert) {
		
		clipboard_set_text("\"" + _mess + "\"");
		throw ("\n\t" + _mess);
	}
}

#region UNIT_toStrIntTBase
		
		apiDebugAssert(
			UNIT_toStrIntTBase(236, 8) == "354",
			"<UNIT_toStrIntTBase 0>"
		);
		
		apiDebugAssert(
			UNIT_toStrIntTBase(236, 2) == "11101100",
			"<UNIT_toStrIntTBase 1>"
		);
		
		apiDebugAssert(
			UNIT_toStrIntTBase(236, 16) == "EC",
			"<UNIT_toStrIntTBase 2>"
		);
		
		apiDebugAssert(
			UNIT_toStrIntTBase(236, 30) == "7Q",
			"<UNIT_toStrIntTBase 3>"
		);
		
		apiDebugAssert(
			UNIT_toStrIntTBase(23522342, 30) == "T15S2",
			"<UNIT_toStrIntTBase 4>"
		);
		
		apiDebugAssert(
			UNIT_toStrIntTBase(23522342, 2) == "1011001101110110000100110",
			"<UNIT_toStrIntTBase 5>"
		);
		
		apiDebugAssert(
			UNIT_toStrIntTBase(23522342, 16) == "166EC26",
			"<UNIT_toStrIntTBase 6>"
		);
		
		apiDebugAssert(
			UNIT_toStrIntTBase(-1891241, 16) == "-1CDBA9",
			"<UNIT_toStrIntTBase 7>"
		);
		
		apiDebugAssert(
			UNIT_toStrIntTBase(-1891241, 7) == "-22034552",
			"<UNIT_toStrIntTBase 8>"
		);
		
		apiDebugAssert(
			UNIT_toStrIntTBase(-1891241, 2) == "-111001101101110101001",
			"<UNIT_toStrIntTBase 9>"
		);
		
		apiDebugAssert(
			UNIT_toStrIntTBase(0, 2) == "0",
			"<UNIT_toStrIntTBase 10>"
		);
		
		show_debug_message("\t UNIT_toStrIntTBase \tis work");
		
		#endregion
		
		#region UNIT_toStrBaseTInt
		
		apiDebugAssert(
			UNIT_toStrBaseTInt("1000111000110010000111", 2) == 2329735,
			"<UNIT_toStrBaseTInt 0>"
		);
		
		apiDebugAssert(
			UNIT_toStrBaseTInt("-4340714", 9) == -2329735,
			"<UNIT_toStrBaseTInt 1>"
		);
		
		apiDebugAssert(
			UNIT_toStrBaseTInt("238C87", 16) == 2329735,
			"<UNIT_toStrBaseTInt 2>"
		);
		
		apiDebugAssert(
			UNIT_toStrBaseTInt("40D31DE92", 16) == 17401241234,
			"<UNIT_toStrBaseTInt 3>"
		);
		
		apiDebugAssert(
			UNIT_toStrBaseTInt("-10000001101001100011101111010010010", 2) == -17401241234,
			"<UNIT_toStrBaseTInt 4>"
		);
		
		apiDebugAssert(
			UNIT_toStrBaseTInt("0", 16) == 0,
			"<UNIT_toStrBaseTInt 5>"
		);
		
		show_debug_message("\t UNIT_toStrBaseTInt \tis work");
		
		#endregion
		
		#region UNIT_toStrInt
		
		apiDebugAssert(
			UNIT_toStrInt(UNIT_toStrInt(111, 2, 10), 2) == 111,
			"<UNIT_toStrInt 0>"
		);
		
		apiDebugAssert(
			UNIT_toStrInt(UNIT_toStrInt(-1453, 16, 10), 16) == -1453,
			"<UNIT_toStrInt 1>"
		);
		
		show_debug_message("\t UNIT_toStrInt \t\t\t\tis work");
		
		#endregion
		
function apiDebugAssert(_assert, _mess) {
	if (!_assert) {
		
		clipboard_set_text("\"" + _mess + "\"");
		throw ("\n\t" + _mess);
	}
}

var _textbuf = UNIT_bufTxtCreate(32);
	
apiDebugAssert(
	buffer_exists(_textbuf),
	"<UNIT_bufTxtCreate create>"
);
		
apiDebugAssert(
	buffer_get_size(_textbuf) == 32,
	"<UNIT_bufTxtCreate size>"
);
		
apiDebugAssert(
	UNIT_bufTxtRead(_textbuf) == "",
	"<UNIT_bufTxtRead empty 0>"
);
		
UNIT_bufTxtPush(_textbuf);
apiDebugAssert(
	UNIT_bufTxtRead(_textbuf) == "",
	"<UNIT_bufTxtPush empty push>"
);
		
UNIT_bufTxtAppend(_textbuf, "Hello World!");
apiDebugAssert(
	UNIT_bufTxtRead(_textbuf) == "Hello World!",
	"<UNIT_bufTxtAppend append 1>"
);
		
apiDebugAssert(
	UNIT_bufTxtRead(_textbuf) == "Hello World!",
	"<UNIT_bufTxtRead repeated get 1>"
);
		
UNIT_bufTxtAppend(_textbuf, "GML");
apiDebugAssert(
	UNIT_bufTxtRead(_textbuf) == "Hello World!GML",
	"<UNIT_bufTxtAppend append 2>"
);
		
apiDebugAssert(
	UNIT_bufTxtRead(_textbuf) == "Hello World!GML",
	"<UNIT_bufTxtRead repeated get 2>"
);
		
UNIT_bufTxtPush(_textbuf, "!", " It is work!");
apiDebugAssert(
	UNIT_bufTxtRead(_textbuf) == "Hello World!GML! It is work!",
	"<UNIT_bufTxtPush push 1>"
);
		
UNIT_bufTxtPush(_textbuf, "1", "2", "3");
apiDebugAssert(
	UNIT_bufTxtRead(_textbuf) == "Hello World!GML! It is work!123",
	"<UNIT_bufTxtPush push 2>"
);
		
UNIT_bufTxtClear(_textbuf, 20);
apiDebugAssert(
	buffer_get_size(_textbuf) == 20,
	"<UNIT_bufTxtClear clear size>"
);
apiDebugAssert(
	UNIT_bufTxtRead(_textbuf) == "",
	"<UNIT_bufTxtClear clear read>"
);
		
UNIT_bufTxtAppend(_textbuf, "Text Buffer");
apiDebugAssert(
	UNIT_bufTxtRead(_textbuf) == "Text Buffer",
	"<UNIT_bufTxtAppend append 10>"
);
		
apiDebugAssert(
	UNIT_bufTxtFree(_textbuf) == "Text Buffer",
	"<UNIT_bufTxtFree free read>"
);

apiDebugAssert(
	!buffer_exists(_textbuf),
	"<UNIT_bufTxtFree free data>"
);
		
if (buffer_exists(_textbuf)) buffer_delete(_textbuf);
show_debug_message("all good");
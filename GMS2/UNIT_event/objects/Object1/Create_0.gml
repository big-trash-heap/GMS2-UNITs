
event = new UNIT_Eventor();

event.on("cast", function() {
	show_message("hello");
});

event.on("cast", method({}, function() {
	show_message("world");
}));

event.exec("cast");

event.off("cast", self);

event.exec("cast");



function constr() constructor {
	
	self.name = "kirill";
	
	static met = method({ cont: "hello" }, function() {
		
		show_debug_message(self);
		show_debug_message(other);
	});
}

var nn = new constr();
nn.met();



function A() constructor {
	
	show();
	
	static show = function() {
		
		show_message("first");
	}

}

function B() : A() constructor {
	
	show();
	
	static show_old = show;
	
	static show = function() {
		
		show_message("second");
	}
	
	show_old();
	
}

var a = new B()

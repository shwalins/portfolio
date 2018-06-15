module compare(a,b,equalto, greaterthan, lessthan);
	input a,b;
	output equalto, greaterthan, lessthan;
	assign equalto = (a & b) | (~a & ~b);
	assign greaterthan = (a & ~b);
	assign lessthan = (~a & b);
endmodule

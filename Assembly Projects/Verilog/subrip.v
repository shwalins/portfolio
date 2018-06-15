module subrip(s,cout,a,b,cin);
//this is a 4 bit adder;
	input [3:0]a;
	input [3:0]b;
	input cin;
	output cout;
	output [3:0]s;
	wire c2,c3,c4,cout;
	fulladder fa1(s[0], c2, a[0], b[0], cin);
	fulladder fa2(s[1], c3, a[1], b[1], c2);
	fulladder fa3(s[2], c4, a[2], b[2], c3);
	fulladder fa4(s[3], cout, a[3], b[3], c4);
endmodule

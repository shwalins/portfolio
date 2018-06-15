module ripplecarryadder(s, cout, a,b,cin);
	input [15:0]a;
	input [15:0]b;
	input cin;
	output cout;
	output [15:0]s;
	wire c1, c2, c3, cout;
	subrip sr1(s[3:0], c1, a[3:0], b[3:0], cin);
	subrip sr2(s[7:4], c2, a[7:4], b[7:4], c1);
	subrip sr3(s[11:8], c3, a[11:8], b[11:8], c2);
	subrip sr4(s[15:12], cout, a[15:12], b[15:12], c3);
endmodule

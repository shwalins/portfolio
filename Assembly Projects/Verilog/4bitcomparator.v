module 4bitcomparator(a,b,equalto,greaterthan,lessthan);
	input [3:0] a,b;
	output equalto,greaterthan,lessthan;
	wire w0, w1, w2, w3, a0, a1, a2, a3, b0, b1, b2, b3;
	compare cp0(a[0], b[0], w0, a0, b0);
	compare cp1(a[1], b[1], w1, a1, b1);
	compare cp2(a[2], b[2], w2, a2, b2);
	compare cp3(a[3], b[3], w3, a3, b3);
	assign equalto = (w0 & w1 & w2 & w3);
	assign greaterthan = (a3 | (a2 & w3) | (a1 & w2 & w3) | (a0 & w1 & w2 & w3));
	assign lessthan = (~greaterthan & ~equalto);
endmodule

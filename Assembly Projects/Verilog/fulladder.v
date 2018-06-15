module fulladder(cout, si, ai, bi, cin);
	parameter delay2=1, delay3=2, delay4=3;
	input ai, bi, cin;
	output cout, si;
	and #delay3 (si1, ~ai, ~bi, cin),
		(si2, ~ai, bi, ~cin),
		(si3, ai, ~bi, ~cin),
		(si4, ai, bi, cin);
	or #delay3 (si, si1, si2, si3, si4);

	and #delay2 (ci1, ai, bi),
		(ci2, ai, cin),
		(ci3, bi, cin);
	or #delay3 (cout, ci1, ci2, ci3);
endmodule

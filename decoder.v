// Decoder circuit

module behavioralDecoder

(
    output out0, out1, out2, out3,
    input address0, address1,
    input enable
);
    // Uses concatenation and shift operators
    assign {out3,out2,out1,out0}=enable<<{address1,address0};
endmodule

//P. 2 of code Kimberly Winter			9/23/17
module structuralDecoder
(
    output out0, out1, out2, out3, //given to us
    input address0, address1,
    input enable
);

	//bunch o' gates

	//inverting gates
	not #50 notA0(nA0,address0);
	not #50 notA1(nA1,address1);

	//gates combining in binary
	and #50 notA0andnotA1(nA0andnA1,nA0,nA1);
	and #50 A0andnotA1(A0andnA1,address0,nA1);
	and #50 notA0andA1(nA0andA1, nA0, address1);
	and #50 A0anndA1(A0andA1,address0,address1); //double n to avoid double naming
    
	//enable gates
    and #50 n0En(out0,nA0andnA1,enable);
    and #50 n1En(out1,A0andnA1,enable);
    and #50 n2En(out2,nA0andA1,enable);
    and #50 n3En(out3,A0andA1,enable);


endmodule


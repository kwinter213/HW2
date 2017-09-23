// Multiplexer circuit

module behavioralMultiplexer
(
    output out,
    input address0, address1,
    input in0, in1, in2, in3
);
    // Join single-bit inputs into a bus, use address as index
    wire[3:0] inputs = {in3, in2, in1, in0};
    wire[1:0] address = {address1, address0};
    assign out = inputs[address];
endmodule

//P. 2 of code Kimberly Winter          9/23/17
module structuralMultiplexer
(
    output out,
    input address0, address1,
    input in0, in1, in2, in3
);
    //not S0 and not S1 inverters
    not #50 S0(nS0,address0);
    not #50 S1(nS1,address1);

    //combinations of S (addr)
    and #50 nS0nS1and(nS0andnS1, nS0,nS1);
    and #50 S0nS1and(nS0andS1,nS0,address1);
    and #50 nS0S1and(S0andnS1,address0,nS1);
    and #50 S0S1and(S0andS1,address0,address1);

    //and gates that combine S info with I inputs
    and #50 I0and(Iout0,in0,nS0andnS1);
    and #50 I1and(Iout1,in1,S0andnS1);
    and #50 I2and(Iout2,in2,nS0andS1);
    and #50 I3and(Iout3,in3,S0andS1);

    //ors that go into the final or
    or #50 or1(outa,Iout0,Iout1);
    or #50 or2(outb,Iout2,Iout3);

    //last or (coding from the end to the beginning)
    or #50 finOr(out, outa, outb);

endmodule


// Adder circuit


module behavioralFullAdder
(
    output sum, 
    output carryout,
    input a, 
    input b, 
    input carryin
);
    // Uses concatenation operator and built-in '+'
    assign {carryout, sum}=a+b+carryin;
endmodule


//P. 2 of code Kimberly Winter          9/23/17
module structuralFullAdder
(
    output sum, 
    output carryout,
    input a, 
    input b, 
    input carryin
);

//to get to the sum (i.e. if only one of a, b, or c is high or if all three are high, the output for sum will be 1.)
    xor #50 axorb(aXORb,a, b);
    xor #50 axorbxorc(sum,carryin,aXORb);

//to get to the carryout (hard part)
    and #50 aAndb(aandb,a,b);
    and #50 bAndc(bandc,b,carryin);
    and #50 aAndc(aandc,a,carryin);

//triple or gate??
    or #50 triple_or(carryout,aandb,bandc,aandc);
    
endmodule
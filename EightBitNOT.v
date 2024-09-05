`timescale 1ns / 1ps

module EightBitNOT(b,a);
    input [7:0] a;
    output [7:0]b;
    
    not(b[0],a[0]);
    not(b[1],a[1]);
    not(b[2],a[2]);
    not(b[3],a[3]);
    not(b[4],a[4]);
    not(b[5],a[5]);
    not(b[6],a[6]);
    not(b[7],a[7]);
    

endmodule

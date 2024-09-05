`timescale 1ns / 1ps

module EightBitOR(r,a,b);
    input [7:0]a,b;
    output [7:0]r;
    
    or(r[0],a[0],b[0]);
    or(r[1],a[1],b[1]);
    or(r[2],a[2],b[2]);
    or(r[3],a[3],b[3]);
    or(r[4],a[4],b[4]);
    or(r[5],a[5],b[5]);
    or(r[6],a[6],b[6]);
    or(r[7],a[7],b[7]);

endmodule

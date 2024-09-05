`timescale 1ns / 1ps

module EightBitAND(r,a,b);
    input [7:0]a,b;
    output [7:0]r;
    
    and(r[0],a[0],b[0]);
    and(r[1],a[1],b[1]);
    and(r[2],a[2],b[2]);
    and(r[3],a[3],b[3]);
    and(r[4],a[4],b[4]);
    and(r[5],a[5],b[5]);
    and(r[6],a[6],b[6]);
    and(r[7],a[7],b[7]);

endmodule

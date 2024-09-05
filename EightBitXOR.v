`timescale 1ns / 1ps

module EightBitXOR(r,a,b);
    input [7:0]a,b;
    output [7:0]r;
    
    xor(r[0],a[0],b[0]);
    xor(r[1],a[1],b[1]);
    xor(r[2],a[2],b[2]);
    xor(r[3],a[3],b[3]);
    xor(r[4],a[4],b[4]);
    xor(r[5],a[5],b[5]);
    xor(r[6],a[6],b[6]);
    xor(r[7],a[7],b[7]);

endmodule

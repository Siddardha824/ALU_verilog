`timescale 1ns / 1ps

module signchanger(nega,a);
    input [7:0] a;
    output [7:0] nega;
    wire [7:0] b,c;
    
    not(b[0],a[0]);
    not(b[1],a[1]);
    not(b[2],a[2]);
    not(b[3],a[3]);
    not(b[4],a[4]);
    not(b[5],a[5]);
    not(b[6],a[6]);
    not(b[7],a[7]);
    
    halfadder IA1 (nega[0],c[0],b[0],1'b1),
                IA2 (nega[1],c[1],b[1],c[0]),
                IA3 (nega[2],c[2],b[2],c[1]),
                IA4 (nega[3],c[3],b[3],c[2]),
                IA5 (nega[4],c[4],b[4],c[3]),
                IA6 (nega[5],c[5],b[5],c[4]),
                IA7 (nega[6],c[6],b[6],c[5]),
                IA8 (nega[7],c[7],b[7],c[6]);
    
endmodule

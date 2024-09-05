`timescale 1ns / 1ps

module EightBitAdder(s,x,y,c,ov);
    input [7:0] x,y;
    input c;
    output ov;
    output [8:0] s;
    wire c1,c2,c3,c4,c5,c6;
    
    fulladder   FA1 (s[0],c1,x[0],y[0],c),
                FA2 (s[1],c2,x[1],y[1],c1),
                FA3 (s[2],c3,x[2],y[2],c2),
                FA4 (s[3],c4,x[3],y[3],c3),
                FA5 (s[4],c5,x[4],y[4],c4),
                FA6 (s[5],c6,x[5],y[5],c5),
                FA7 (s[6],ov,x[6],y[6],c6),
                FA8 (s[7],s[8],x[7],y[7],ov);
endmodule

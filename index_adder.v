`timescale 1ns / 1ps

module index_adder(next_index,index);
    input [3:0] index;
    output [3:0] next_index;
    wire c0,c1,c2,c3;

    halfadder IA1 (next_index[0],c0,index[0],1'b1),
                IA2 (next_index[1],c1,index[1],c0),
                IA3 (next_index[2],c2,index[2],c1),
                IA4 (next_index[3],c3,index[3],c2);

endmodule

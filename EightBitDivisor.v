`timescale 1ns / 1ps

module EightBitDivisor(sol,comp,x,y,noty,clk,en,res);
    input [7:0] x,y,noty;
    input clk,en,res;
    output [15:0] sol;
    output reg comp;
    reg signed [15:0] sol;
    reg [3:0] index;
    reg [7:0] add_b;
    wire [8:0] sum;
    wire [3:0] next_index;
    wire cont2,interm,interm2,interm3,end_indi;
    reg clk_con,carry,sign,in_store;
    
    initial begin
        sol = 16'b0;
        index = 4'b0;
        comp = 1'b0;
        clk_con = 1'b0;
        carry = 1'b0;
        sign = 1'b0;
        in_store = 1'b0;
    end

    EightBitAdder div_adder (sum,sol[15:8],add_b,carry);
    index_adder DIA (next_index,index);
    
    and(interm3,index[1],index[0]);
    and(end_indi,index[2],interm3);
    
    or(interm2,index[1],index[0]);
    or(interm,index[2],interm2);
    or(cont2,index[3],interm);

    always @(posedge clk)
    begin
        if(!res)
        begin
            if(en)
            begin
                if(!in_store)
                begin
                    sol[7:0] = x;
                    in_store = 1'b1;
                end
                if(!index[3])
                begin
                    if(!clk_con)
                    begin
                        sol = sol <<< 1;
                        if(!sign)
                        begin
                            add_b = noty;
                            carry = 1'b1;
                        end
                        else
                        begin
                            add_b = y;
                            carry = 1'b0;
                        end
                        clk_con = ~clk_con;
                    end
                    else
                    begin
                        if(!end_indi)
                        begin
                            sol[15:8] = sum[7:0];
                            sol[0] = ~sol[15];
                        end
                        else
                            sol[0] <= ~sum[7];
                        sign = sol[15];
                        index = next_index;
                        clk_con = ~clk_con;
                        
                    end
                end
                else
                    comp = 1'b1;
            end
        end
        else
        begin
            sol = 16'b0;
            index = 4'b0;
            comp = 1'b0;
            clk_con = 1'b0;
            carry = 1'b0;
            sign = 1'b0;
            in_store = 1'b0;
        end
    end

endmodule

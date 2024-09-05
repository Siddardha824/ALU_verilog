`timescale 1ns / 1ps

module EightBitMultiplier(mu_res,comp,x,y,not_y,clk,en,res);
    input [7:0] x,y,not_y;
    input clk,en,res;
    output [15:0] mu_res;
    output reg comp;
    reg signed [16:0] pro;
    reg [3:0] index;
    reg [7:0] add_b;
    wire [8:0] sum;
    wire [3:0] next_index;
    wire cont2,interm,interm2;
    reg clk_con,carry,isaneg;
    assign mu_res = pro[16:1];
    
    initial begin
        pro = 17'b0;
        index = 4'b0;
        comp = 1'b0;
        clk_con = 1'b0;
        carry = 1'b0;
        isaneg = 1'b0;
    end

    EightBitAdder mult_adder (sum,pro[16:9],add_b,carry);
    index_adder MIA (next_index,index);
    
    or(interm2,index[1],index[0]);
    or(interm,index[2],interm2);
    or(cont2,index[3],interm);

    always @(posedge clk)
    begin
        if(!res)
        begin
            if(en)
            begin
                if(!cont2)
                begin
                    pro[8:1] = x;
                    isaneg = x[7];
                end
                if(!index[3])
                begin
                    if(!clk_con)
                    begin
                        if(isaneg)
                        begin
                            if(pro[0])
                            begin
                                if(pro[1])
                                begin
                                    add_b = 8'b0;
                                    carry = 1'b0;
                                end
                                else
                                begin
                                    add_b = y;
                                    carry = 1'b0;
                                end
                            end
                            else
                            begin
                                if(pro[1])
                                begin
                                    add_b = not_y;
                                    carry = 1'b1;
                                end
                                else
                                begin
                                    add_b = 8'b0;
                                    carry = 1'b0;
                                end
                            end
                        end
                        else
                        begin
                            if(pro[1])
                            begin
                                add_b = y;
                                carry = 1'b0;
                            end
                            else
                            begin
                                add_b = 8'b0;
                                carry = 1'b0;
                            end
                        end
                        clk_con <= ~clk_con;
                    end
                    else
                    begin
                        pro[16:9] = sum[7:0];
                        pro = pro >>> 1;
                        if(!isaneg)
                            pro[16] = sum[8];
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
            pro = 17'b0;
            index = 4'b0;
            comp = 1'b0;
            clk_con = 1'b0;
        end
    end

endmodule

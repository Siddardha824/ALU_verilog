`timescale 1ns / 1ps

module top_module(ans,sign,overflow,car,a,b,con,clk);
    input [7:0] a;
    input [7:0] b;
    input [2:0] con;
    input clk;
    output reg sign,car;
    output overflow;
    output [15:0] ans;
    wire [15:0] mult_res,div_res;
    wire [8:0] sum;
    wire [7:0] notb,not_negb,and_ans,or_ans,xor_ans,nega,negb,negqo,div_a,div_b,div_notb;
    wire mult_com,div_com,ov;
    reg mult_enab,mult_reset,div_enab,div_reset;
    reg carry,computing,div_sol;
    reg [7:0] x,y;
    reg [15:0] sol;
    initial div_sol = 1'b0;
    assign ans = sol;
    initial
    begin
        sol = 16'b0;
        mult_enab = 1'b0;
        mult_reset = 1'b1;
        computing = 1'b0;
        sign = 1'b0;
        car = 1'b0;
    end
    parameter ADD = 3'b000;
    parameter SUB = 3'b001;
    parameter MUL = 3'b010;
    parameter DIV = 3'b011;
    parameter AND = 3'b100;
    parameter OR = 3'b101;
    parameter NOT = 3'b110;
    parameter XOR = 3'b111;
    
    EightBitAdder adder (sum,x,y,carry,ov);
    EightBitMultiplier mult (mult_res,mult_com,a,b,notb,clk,mult_enab,mult_reset);
    EightBitDivisor div (div_res,div_com,div_a,div_b,div_notb,clk,div_enab,div_reset);
    EightBitAND and_gate (and_ans,a,b);
    EightBitOR or_gate (or_ans,a,b);
    EightBitNOT not_gate (notb,b);
    EightBitXOR xor_gate (xor_ans,a,b);
    signchanger s1 (nega,a);
    signchanger s2 (negb,b);
    signchanger s3 (negqo,sol[7:0]);
    EightBitNOT not_gate2 (not_negb,negb);
    xor(overflow,car,ov);
    assign div_a = a[7]?nega:a;
    assign div_b = b[7]?negb:b;
    assign div_notb = b[7]?not_negb:notb;
    
    always @(posedge clk)
    begin
        if(div_sol)
        begin
            if(a[7] ^ b[7])
                sol[7:0] = negqo;
            div_sol = 1'b0;
            sign = sol[7];
            car = 1'b0;
        end
        if(!computing)
        begin
            case(con)
                ADD :
                begin
                    x = a;
                    y = b;
                    carry = 1'b0;
                    computing = 1'b1;
                end
                SUB :
                begin
                    x = a;
                    y = notb;
                    carry = 1'b1;
                    computing = 1'b1;
                end
                MUL :
                begin
                    if(!mult_com)
                    begin
                        mult_reset = 1'b0;
                        mult_enab = 1'b1;
                    end
                    else
                    begin
                        computing = 1'b1;
                        mult_reset = 1'b1;
                        mult_enab = 1'b0;
                    end
                end
                DIV :
                begin
                    if(!div_com)
                    begin
                        div_reset = 1'b0;
                        div_enab = 1'b1;
                    end
                    else
                    begin
                        computing = 1'b1;
                        div_reset = 1'b1;
                        div_enab = 1'b0;
                    end
                end
                AND :
                begin
                    computing = 1'b1;
                end
                OR :
                begin
                    computing = 1'b1;
                end
                NOT :
                begin
                    computing = 1'b1;
                end
                XOR :
                begin
                    computing = 1'b1;
                end
                default :
                    sol = 16'b0;
            endcase
        end
        else
        begin
            case(con)
                ADD :
                begin
                    sol [7:0] = sum[7:0];
                    car = sum[8];
                    sign = sum[7];
                    sol[15:8] = 8'b00000000;
                    computing = 1'b0;
                end
                SUB :
                begin
                    sol [7:0] = sum[7:0];
                    car = sum[8];
                    sign = sum[7];
                    sol[15:8] = 8'b00000000;
                    computing = 1'b0;
                end
                MUL :
                begin
                    sol = mult_res;
                    sign = mult_res[15];
                    car = 1'b0;
                    computing = 1'b0;
                end
                DIV :
                begin
                    sol = div_res;
                    div_sol = 1'b1;
                    computing = 1'b0;
                end
                AND :
                begin
                    sol [7:0] = and_ans;
                    sol [15:8] = 8'b00000000;
                    computing = 1'b0;
                end
                OR :
                begin
                    sol [7:0] = or_ans;
                    sol [15:8] = 8'b00000000;
                    computing = 1'b0;
                end
                NOT :
                begin
                    sol [7:0] = notb;
                    sol [15:8] = 8'b00000000;
                    computing = 1'b0;
                end
                XOR :
                begin
                    sol [7:0] = xor_ans;
                    sol [15:8] = 8'b00000000;
                    computing = 1'b0;
                end
                default :
                    sol = 16'b0;
            endcase
        end
    end
endmodule

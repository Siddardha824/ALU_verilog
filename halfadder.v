module halfadder(S,C,x,y);
    input x,y;
    output S,C;
    
    xor(S,x,y);
    and(C,x,y);
    
endmodule
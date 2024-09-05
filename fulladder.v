module fulladder(S,C,x,y,z);
   input x,y,z;
   output S,C;
   wire S1,D1,D2;
   
   halfadder HA1(S1,D1,x,y),
            HA2(S,D2,S1,z);
   or(C,D1,D2);
   
endmodule
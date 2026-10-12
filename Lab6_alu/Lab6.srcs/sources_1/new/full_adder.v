`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/01/2026 12:12:06 PM
// Design Name: 
// Module Name: full_adder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module full_adder(

    input a ,
    input b ,
    input cin ,
    output sum ,
    output cout
    
    );
    
    wire s1, c1, c2 ;
    
    half_adder HA1 ( .a(a) , .b(b) , .sum(s1) , .carry(c1) ) ;
    
    half_adder HA2 ( .a(s1) , .b(cin) , .sum(sum) , .carry(c2) ) ;

    or_gate I1 ( .a(c1) , .b(c2) , .out(cout) ) ;
        
endmodule

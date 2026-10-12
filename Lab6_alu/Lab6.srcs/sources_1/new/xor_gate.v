`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/01/2026 11:30:18 AM
// Design Name: 
// Module Name: xor_gate
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


module xor_gate(
    
    input a ,
    input b ,
    output out
    
    );
    
    wire not_a , not_b ;
    wire term1 , term2 ;
    
    not_gate I1 (.in(a) , .out(not_a)) ;
    not_gate I2 (.in(b) , .out(not_b)) ;
    
    and_gate I3 (.a(a) , .b(not_b) , .out(term1)) ;
    and_gate I4 (.a(not_a), .b(b) , .out(term2)) ;
    
    or_gate I5 (.a(term1), .b(term2), .out(out)) ;
    
endmodule

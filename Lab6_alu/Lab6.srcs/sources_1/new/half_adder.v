`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/01/2026 12:08:24 PM
// Design Name: 
// Module Name: half_adder
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


module half_adder(
    
    input a ,
    input b ,
    output sum ,
    output carry

    );

    xor_gate ha_xor (.a(a) , .b(b) , .out(sum)) ;
    
    and_gate ha_and (.a(a) , .b(b) , .out(carry) ) ;
    
endmodule

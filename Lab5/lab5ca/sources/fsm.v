`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/17/2026 10:26:38 AM
// Design Name: 
// Module Name: fsm
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


module fsm(
    input wire clk,
    input wire reset,
    input wire [15:0] sw,
    output reg [15:0] led
) ;
    reg state ;
    reg [15:0] count_val ;
    
    parameter IDLE = 1'b0 ;
    parameter COUNT = 1'b1 ;
    
    always @(posedge clk or posedge reset) 
        begin
        if (reset) 
            begin
            state <= IDLE ;
            count_val <= 16'd0 ;
            end 
        else 
            begin
                case (state)
                    IDLE: 
                        begin
                        if (sw != 16'd0)
                            begin
                            count_val <= sw ;
                            state <= COUNT ;
                            end
                        end
                    COUNT: 
                        begin
                        if (count_val > 4'd0) 
                            begin
                            count_val <= count_val - 1 ;
                            end 
                        else 
                            begin
                            state <= IDLE ;
                            end
                        end
                endcase
            end
        end
        
    always @(*)
        begin
            if (state == IDLE)
                led = 4'd0 ;        
            else
                led = count_val ;
        end

endmodule

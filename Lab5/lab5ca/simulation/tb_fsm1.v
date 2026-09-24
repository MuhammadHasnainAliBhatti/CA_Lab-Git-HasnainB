`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/24/2026 09:44:02 AM
// Design Name: 
// Module Name: tb_fsm1
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


module tb_fsm1;

    // 1. Declare inputs to the FSM as registers (reg)
    reg clk;
    reg reset;
    reg [3:0] sw;

    // 2. Declare outputs from the FSM as wires
    wire [3:0] led;

    // 3. Instantiate your actual FSM module (Connects testbench to your code)
    
    top_fsm_system simulation (
        .clk(clk),
        .pbin(reset),
        .physical_sw(sw),
        .physical_leds(led)


);


    // 4. Generate a Clock (toggles every 5ns -> 10ns clock period)
    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end

    // 5. Apply Test Scenarios (The simulation sequence)
    initial begin
        // Initialize signals
        reset = 1;
        sw = 4'd0;
        
        // Wait 20ns, then release reset
        #20;
        reset = 0;

        // Test Case 1: Keep switch at 0 (Should stay in IDLE, LEDs = 0)
        #20;
        
        // Test Case 2: Set switch to 3 (Should capture 3 and start counting down)
        sw = 4'd3;
        #10;
        sw = 4'd0; // Turn off switch to test that counting continues independently

        // Wait long enough for countdown (3 -> 2 -> 1 -> 0 -> IDLE)
        #60;

        // Test Case 3: Set switch to 5 (Test another value)
        sw = 4'd5;
        #10;
        sw = 4'd0;

        // Wait for countdown to finish
        #80;

        // End the simulation
        $stop;
    end


endmodule

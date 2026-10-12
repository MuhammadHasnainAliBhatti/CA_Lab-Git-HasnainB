`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////
// Testbench for FSM + ALU working together (the "FSM test bench" part).
// Uses a FAST clock (10 ns) instead of the 1 Hz board clock so the
// simulation is short - the FSM does not care how fast its clock is.
//////////////////////////////////////////////////////////////////////////////
module fsm_alu_tb;

    reg         clk, reset, manual;
    reg  [3:0]  sw_ctl;
    wire [3:0]  ALUControl;
    wire [31:0] ALUResult;
    wire        Zero;

    wire [31:0] A = 32'h10101010;
    wire [31:0] B = 32'h01010101;

    reg [31:0] exp_res  [0:6];   // expected result for each state
    reg        exp_zero [0:6];
    reg [3:0]  exp_ctl  [0:6];
    integer i, errors;

    alu_fsm dut_fsm (.clk(clk), .reset(reset), .manual(manual), .sw_ctl(sw_ctl), .ALUControl(ALUControl));
    ALU     dut_alu (.A(A), .B(B), .ALUControl(ALUControl), .ALUResult(ALUResult), .Zero(Zero));

    // clock: flips every 5 ns -> period 10 ns
    initial clk = 0;
    always #5 clk = ~clk;

    task check_state;
        input integer s;
        begin
            if (ALUControl === exp_ctl[s] && ALUResult === exp_res[s] && Zero === exp_zero[s])
                $display("PASS state %0d | ctl=%b result=%h Zero=%b", s, ALUControl, ALUResult, Zero);
            else begin
                $display("FAIL state %0d | ctl=%b result=%h Zero=%b (expected %b %h %b)",
                         s, ALUControl, ALUResult, Zero, exp_ctl[s], exp_res[s], exp_zero[s]);
                errors = errors + 1;
            end
        end
    endtask

    initial begin
        errors = 0;
        // order of states: AND, OR, ADD, SUB, XOR, SLL, SRL
        exp_ctl[0]=4'b0000; exp_res[0]=32'h00000000; exp_zero[0]=1;
        exp_ctl[1]=4'b0001; exp_res[1]=32'h11111111; exp_zero[1]=0;
        exp_ctl[2]=4'b0010; exp_res[2]=32'h11111111; exp_zero[2]=0;
        exp_ctl[3]=4'b0110; exp_res[3]=32'h0F0F0F0F; exp_zero[3]=0;
        exp_ctl[4]=4'b0011; exp_res[4]=32'h11111111; exp_zero[4]=0;
        exp_ctl[5]=4'b1000; exp_res[5]=32'h20202020; exp_zero[5]=0;
        exp_ctl[6]=4'b1001; exp_res[6]=32'h08080808; exp_zero[6]=0;

        // ---- 1. reset, then check state 0 ----
        manual = 0;  sw_ctl = 4'b0000;
        reset = 1;  #12;  reset = 0;          // hold reset over a clock edge, then release
        #1;  check_state(0);

        // ---- 2. watch two full laps (14 clock ticks): state 0..6, then wraps to 0 ----
        for (i = 1; i <= 14; i = i + 1) begin
            @(posedge clk); #1;               // wait for the edge, then a hair more for outputs to settle
            check_state(i % 7);
        end

        // ---- 3. reset in the middle: must jump straight back to state 0 ----
        @(posedge clk); #1;                   // now in state 1
        @(posedge clk); #1;                   // now in state 2
        reset = 1; #2;                        // asynchronous reset: no clock edge needed
        check_state(0);
        reset = 0;

        // ---- 4. MANUAL mode: switches choose the operation, FSM is ignored ----
        manual = 1;  sw_ctl = 4'b0110;  #1;   // SUB
        check_state(3);
        sw_ctl = 4'b1001;  #1;                // SRL
        check_state(6);
        manual = 0;  #1;                      // back to AUTO (FSM is still in state 0)
        check_state(0);

        if (errors == 0) $display("=== FSM + ALU: ALL TESTS PASSED ===");
        else             $display("=== FSM + ALU: %0d FAILED ===", errors);
        $finish;
    end
endmodule

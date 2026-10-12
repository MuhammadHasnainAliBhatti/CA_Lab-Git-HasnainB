`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////
// FSM that cycles through the ALU operations (a MOORE machine: in AUTO mode
// the output depends only on the current state).
//
//   state 0 -> AND -> state 1 -> OR -> state 2 -> ADD -> state 3 -> SUB
//   -> state 4 -> XOR -> state 5 -> SLL -> state 6 -> SRL -> back to state 0
//
// Each clock tick (we feed it the slow 1 Hz clock) moves to the next state.
//
//   manual = 0 (AUTO)   : ALUControl comes from the FSM state
//   manual = 1 (MANUAL) : ALUControl comes straight from the switches (sw_ctl)
//                         so you can hold and test any operation you like.
//////////////////////////////////////////////////////////////////////////////
module alu_fsm(
    input            clk,         // slow clock (1 Hz on the board)
    input            reset,       // clean reset button, 1 = reset
    input            manual,      // 1 = switches choose the operation
    input      [3:0] sw_ctl,      // operation typed on the switches
    output reg [3:0] ALUControl   // goes to the ALU
);
    // Name the states so the code is readable (3 bits are enough for 7 states)
    localparam S_AND = 3'd0,
               S_OR  = 3'd1,
               S_ADD = 3'd2,
               S_SUB = 3'd3,
               S_XOR = 3'd4,
               S_SLL = 3'd5,
               S_SRL = 3'd6;

    reg [2:0] state;        // memory: remembers which state we are in
    reg [3:0] auto_ctl;     // the operation code belonging to that state

    // ---- State register + next-state logic (sequential block) ----
    // Runs on every rising clock edge, or immediately when reset goes high.
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= S_AND;              // reset: start again from AND
        else if (state == S_SRL)
            state <= S_AND;              // after the last state, loop around
        else
            state <= state + 3'd1;       // otherwise go to the next state
    end

    // ---- Output logic (combinational block): state -> operation code ----
    always @(*) begin
        case (state)
            S_AND:   auto_ctl = 4'b0000;
            S_OR:    auto_ctl = 4'b0001;
            S_ADD:   auto_ctl = 4'b0010;
            S_SUB:   auto_ctl = 4'b0110;
            S_XOR:   auto_ctl = 4'b0011;
            S_SLL:   auto_ctl = 4'b1000;
            S_SRL:   auto_ctl = 4'b1001;
            default: auto_ctl = 4'b0000;  // unused state 7: be safe
        endcase
    end

    // ---- Pick FSM output or switches ----
    always @(*) begin
        if (manual) ALUControl = sw_ctl;
        else        ALUControl = auto_ctl;
    end
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////
// 1-BIT ALU  (no shifts - shifting is done once for all 32 bits in ALU.v)
//
// Idea: one tiny slice that can do AND, OR, XOR or ADD/SUB on ONE bit.
//       We will copy this slice 32 times to get a 32-bit ALU.
//
//   op[1:0]   what comes out on "result"
//   -------   --------------------------
//     00      a AND b
//     01      a OR  b
//     10      a + b + cin    (the full adder's sum)
//     11      a XOR b
//
//   binvert = 1  -> b is flipped (~b) BEFORE it enters the gates/adder.
//   Subtraction trick:  A - B = A + (~B) + 1
//                       so SUB = binvert 1  AND  carry-in of bit 0 = 1.
//////////////////////////////////////////////////////////////////////////////
module alu_1bit(
    input        a,          // bit i of operand A
    input        b,          // bit i of operand B
    input        cin,        // carry coming IN from the slice below (bit i-1)
    input        binvert,    // 1 = use ~b (needed for subtract)
    input  [1:0] op,         // picks which result leaves the slice
    output       result,     // the answer for this bit
    output       cout        // carry going OUT to the slice above (bit i+1)
);
    // ---- internal wires ----
    wire b_x;                              // b after the optional flip
    wire and_out, or_out, xor_out, sum_out;

    // ---- Step 1: optionally flip b ------------------------------------
    // XOR with 0 leaves b unchanged (b^0 = b); XOR with 1 flips it (b^1 = ~b).
    // So an XOR gate acts as a "controlled inverter". (A mux + NOT gate
    // would do the same job - this just reuses the xor_gate you already built.)
    xor_gate FLIP_B (.a(b), .b(binvert), .out(b_x));

    // ---- Step 2: compute EVERY operation in parallel -------------------
    and_gate   G_AND (.a(a), .b(b_x), .out(and_out));
    or_gate    G_OR  (.a(a), .b(b_x), .out(or_out));
    xor_gate   G_XOR (.a(a), .b(b_x), .out(xor_out));
    full_adder G_ADD (.a(a), .b(b_x), .cin(cin), .sum(sum_out), .cout(cout));

    // ---- Step 3: 4-to-1 multiplexer: op chooses ONE of the four -------
    // Read it as nested if/else:  if op==00 -> and_out, else if op==01 -> or_out ...
    assign result = (op == 2'b00) ? and_out :
                    (op == 2'b01) ? or_out  :
                    (op == 2'b10) ? sum_out :
                                    xor_out;   // op == 2'b11
endmodule

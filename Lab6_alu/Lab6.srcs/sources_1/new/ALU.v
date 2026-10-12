`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////
// 32-BIT ALU   (module name "ALU" as the lab manual asks)
//
// Inputs : A, B (32-bit operands), ALUControl[3:0] (which operation)
// Outputs: ALUResult (32-bit answer), Zero (1 when ALUResult is all zeros)
//
// ALUControl encoding (we chose it so the decoding needs NO extra logic):
//
//   bit3   bit2      bit1:0
//   shift? binvert   op            operation
//   ----------------------------------------------------
//    0      0        00    0000    AND
//    0      0        01    0001    OR
//    0      0        10    0010    ADD
//    0      1        10    0110    SUB   (also used for BEQ, see Zero)
//    0      0        11    0011    XOR
//    1      0        00    1000    SLL   (shift left  logical)
//    1      0        01    1001    SRL   (shift right logical)
//
// BEQ (branch if equal) = do SUB, then look at Zero. If A - B == 0 then A == B.
//////////////////////////////////////////////////////////////////////////////
module ALU(
    input  [31:0] A,
    input  [31:0] B,
    input  [3:0]  ALUControl,
    output [31:0] ALUResult,
    output        Zero
);
    // ---- split the control word into its pieces ----
    wire       is_shift = ALUControl[3];     // 1 -> answer comes from the shifter
    wire       binvert  = ALUControl[2];     // 1 -> subtract
    wire [1:0] op       = ALUControl[1:0];   // AND / OR / ADD-SUB / XOR

    // ---- Part 1: 32 one-bit ALUs chained by their carries ----
    wire [31:0] chain_result;   // result bit from each slice
    wire [32:0] carry;          // carry[i] goes INTO slice i, carry[i+1] comes OUT of it
                                // (33 wires: 32 slices need 32 carry-ins + 1 final carry-out)

    // Bit 0 has no slice below it, so we feed its carry-in ourselves:
    //   ADD: 0     SUB: 1  (the "+1" of two's complement)  -> that is exactly binvert.
    assign carry[0] = binvert;

    genvar i;                                    // loop counter that exists only at build time
    generate
        for (i = 0; i < 32; i = i + 1) begin : bit_slice   // creates 32 copies, named bit_slice[0..31]
            alu_1bit slice (
                .a      (A[i]),
                .b      (B[i]),
                .cin    (carry[i]),          // carry from the slice below
                .binvert(binvert),           // same control for every slice
                .op     (op),                // same control for every slice
                .result (chain_result[i]),
                .cout   (carry[i+1])         // passes up to the next slice
            );
        end
    endgenerate

    // ---- Part 2: shifter (works on all 32 bits at once) ----
    // RISC-V uses only the lower 5 bits of B as the shift amount (0..31).
    // ALUControl[0] picks the direction: 0 = left (SLL), 1 = right (SRL).
    wire [31:0] shift_result = ALUControl[0] ? (A >> B[4:0])    // SRL: zeros enter from the left
                                             : (A << B[4:0]);   // SLL: zeros enter from the right

    // ---- Part 3: final 2-to-1 mux: shifter answer or chain answer ----
    assign ALUResult = is_shift ? shift_result : chain_result;

    // ---- Zero flag: reduction-NOR. "|ALUResult" ORs all 32 bits together,
    //      "~" flips it -> 1 only if every bit is 0.
    assign Zero = ~|ALUResult;
endmodule

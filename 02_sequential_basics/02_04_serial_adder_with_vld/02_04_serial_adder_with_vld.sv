//----------------------------------------------------------------------------
// Task
//----------------------------------------------------------------------------

module serial_adder_with_vld
(
  input  clk,
  input  rst,
  input  vld,
  input  a,
  input  b,
  input  last,
  output sum
);

  // Task:
  // Implement a module that performs serial addition of two numbers
  // (one pair of bits is summed per clock cycle).
  //
  // It should have input signals a and b, and output signal sum.
  // Additionally, the module have two control signals, vld and last.
  //
  // The vld signal indicates when the input values are valid.
  // The last signal indicates when the last digits of the input numbers has been received.
  //
  // When vld is high, the module should add the values of a and b and produce the sum.
  // When last is high, the module should output the sum and reset its internal state, but
  // only if vld is also high, otherwise last should be ignored.
  //
  // When rst is high, the module should reset its internal state.

  logic sum_q;
  logic carry_in;

  assign sum_d = (carry_in ^ a ^ b);
  assign carry_out_d = (a & b) | (carry_in & (a ^ b));

  always_ff @(posedge clk) begin
    if (rst) begin
      carry_in <= 0;
      sum_q <= 0;
    end else begin
      if (vld) begin
        sum_q <= sum_d;
        if (last) begin
          carry_in <= 0;
        end else begin
          carry_in <= carry_out_d;
        end
      end
    end
  end

  assign sum = sum_q;

endmodule

//----------------------------------------------------------------------------
// Example
//----------------------------------------------------------------------------

module serial_comparator_least_significant_first
(
  input  clk,
  input  rst,
  input  a,
  input  b,
  output a_less_b,
  output a_eq_b,
  output a_greater_b
);

  logic prev_a_eq_b, prev_a_less_b;

  assign a_eq_b      = prev_a_eq_b & (a == b);
  assign a_less_b    = (~ a & b) | (a == b & prev_a_less_b);
  assign a_greater_b = (~ a_eq_b) & (~ a_less_b);

  always_ff @ (posedge clk)
    if (rst)
    begin
      prev_a_eq_b   <= '1;
      prev_a_less_b <= '0;
    end
    else
    begin
      prev_a_eq_b   <= a_eq_b;
      prev_a_less_b <= a_less_b;
    end

endmodule

//----------------------------------------------------------------------------
// Task
//----------------------------------------------------------------------------

module serial_comparator_most_significant_first
(
  input  clk,
  input  rst,
  input  a,
  input  b,
  output a_less_b,
  output a_eq_b,
  output a_greater_b
);

  // Task:
  // Implement a module that compares two numbers in a serial manner.
  // The module inputs a and b are 1-bit digits of the numbers
  // and most significant bits are first.
  // The module outputs a_less_b, a_eq_b, and a_greater_b
  // should indicate whether a is less than, equal to, or greater than b, respectively.
  // The module should also use the clk and rst inputs.
  //
  // See the testbench for the output format ($display task).
  logic prev_a_eq_b, prev_a_greater_b;

  // all previous MSbits were equal and the current bit is equal, so still equal
  assign a_eq_b      = prev_a_eq_b & (a == b);
  // previously already a greater than b, or, previous MSbits were equal and
  // just found MSbit on a which is 1 and on b is 0, thus a is greater b.
  assign a_greater_b = prev_a_greater_b | (prev_a_eq_b & (a & ~ b));
  // not yet found that a greater than b, or, previous MSbits were equal and
  // just found MSbit on a which is 0 and on b is 1, thus a is less than b.
  assign a_less_b    = (~ a_greater_b) & (~ a_eq_b);
  always_ff @ (posedge clk) begin
    if (rst) begin
      prev_a_eq_b   <= '1;
      prev_a_greater_b <= '0;
    end else begin
      prev_a_eq_b   <= a_eq_b;
      prev_a_greater_b <= a_greater_b;
    end
  end

endmodule

//----------------------------------------------------------------------------
// Example
//----------------------------------------------------------------------------

module add
(
  input  [3:0] a, b,
  output [3:0] sum
);

  assign sum = a + b;

endmodule

//----------------------------------------------------------------------------
// Task
//----------------------------------------------------------------------------

module signed_add_with_saturation
(
  input  [3:0] a, b,
  output [3:0] sum
);

  // Task:
  //
  // Implement a module that adds two signed numbers with saturation.
  //
  // "Adding with saturation" means:
  //
  // When the result does not fit into 4 bits,
  // and the arguments are positive,
  // the sum should be set to the maximum positive number.
  //
  // When the result does not fit into 4 bits,
  // and the arguments are negative,
  // the sum should be set to the minimum negative number.
  localparam MAX=4'b0111; // +7
  localparam MIN=4'b1000; // -8
  logic [3:0] sum_interm;
  logic overflow_pos, overflow_neg;

  assign sum_interm = a + b;
  assign overflow_pos = (sum_interm[3] & (~a[3] & ~b[3]));
  assign overflow_neg = (~sum_interm[3] & (a[3] & b[3]));

  assign sum = (overflow_pos) ? MAX : (overflow_neg) ? MIN : sum_interm;

endmodule

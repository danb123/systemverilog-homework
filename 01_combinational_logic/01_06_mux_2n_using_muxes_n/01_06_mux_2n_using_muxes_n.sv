//----------------------------------------------------------------------------
// Example
//----------------------------------------------------------------------------

module mux_2_1
(
  input  [3:0] d0, d1,
  input        sel,
  output [3:0] y
);

  assign y = sel ? d1 : d0;

endmodule

//----------------------------------------------------------------------------
// Task
//----------------------------------------------------------------------------

module mux_4_1
(
  input  [3:0] d0, d1, d2, d3,
  input  [1:0] sel,
  output [3:0] y
);

  wire [3:0] m1, m2;

//  assign m1 = sel[0] ? d1 : d0;
//  assign m2 = sel[0] ? d3 : d2;
//  assign y = sel[1] ? m2 : m1;
  mux_2_1 mm1 (d0, d1, sel[0], m1);
  mux_2_1 mm2 (d2, d3, sel[0], m2);
  mux_2_1 mm3 (m1, m2, sel[1], y);
  // Task:
  // Implement mux_4_1 using three instances of mux_2_1


endmodule

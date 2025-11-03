//----------------------------------------------------------------------------
// Example
//----------------------------------------------------------------------------

module mux
(
  input  d0, d1,
  input  sel,
  output y
);

  assign y = sel ? d1 : d0;

endmodule

//----------------------------------------------------------------------------
// Task
//----------------------------------------------------------------------------

module not_gate_using_mux
(
    input  i,
    output o
);

  mux m1 (1, 0, i, o);

  // Task:
  // Implement not gate using instance(s) of mux,
  // constants 0 and 1, and wire connections


endmodule

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

module xor_gate_using_mux
(
    input  a,
    input  b,
    output o
);

  wire a_inv;
  wire b_inv;
  wire albh;
  wire ahbl;

  //mux mux_a_inv (1, 0, a, a_inv);
  //mux mux_b_inv (1, 0, b, b_inv);
  //mux mux_and_albh (0, a_inv, b, albh);
  //mux mux_and_ahbl (0, a, b_inv, ahbl);
  //mux mux_or (albh, 1, ahbl, o);

  // more optimal
  mux mux_ahbl (a, 0, b, ahbl);
  mux mux_albh (b, 0, a, albh);
  mux mux_or (albh, 1, ahbl, o);

  // Task:
  // Implement xor gate using instance(s) of mux,
  // constants 0 and 1, and wire connections


endmodule

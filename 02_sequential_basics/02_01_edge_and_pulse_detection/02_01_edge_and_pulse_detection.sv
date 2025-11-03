//----------------------------------------------------------------------------
// Example
//----------------------------------------------------------------------------

module posedge_detector (input clk, rst, a, output detected);

  logic a_r;

  // Note:
  // The a_r flip-flop input value d propogates to the output q
  // only on the next clock cycle.

  always_ff @ (posedge clk)
    if (rst)
      a_r <= '0;
    else
      a_r <= a;

  assign detected = ~ a_r & a;

endmodule

//----------------------------------------------------------------------------
// Task
//----------------------------------------------------------------------------

module one_cycle_pulse_detector (input clk, rst, a, output detected);

  logic det_posedge;
  logic det_posedge_r;
  posedge_detector pd (clk, rst, a, det_posedge);
  always_ff @(posedge clk) begin
    if (rst) begin
      det_posedge_r <= 0;
    end else begin
      det_posedge_r <= det_posedge;
    end
  end

  // if we detected a postive edge on the previous cycle and the current input
  // is low, then we have detected 010
  assign detected = ~a & det_posedge_r;
  // Task:
  // Create an one cycle pulse (010) detector.
  //
  // Note:
  // See the testbench for the output format ($display task).


endmodule

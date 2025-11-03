//----------------------------------------------------------------------------
// Example
//----------------------------------------------------------------------------

module fibonacci
(
  input               clk,
  input               rst,
  output logic [15:0] num
);

  logic [15:0] num2;

  always_ff @ (posedge clk)
    if (rst)
      { num, num2 } <= { 16'd1, 16'd1 };
    else
      { num, num2 } <= { num2, num + num2 };

endmodule

//----------------------------------------------------------------------------
// Task
//----------------------------------------------------------------------------

module fibonacci_2
(
  input               clk,
  input               rst,
  output logic [15:0] num,
  output logic [15:0] num2
);

  // Task:
  // Implement a module that generates two fibonacci numbers per cycle
  logic [15:0] num_next;
  fibonacci my_fib1 (clk, rst, num_next);
  always_ff @(posedge clk) begin
    if (rst) begin
      num <= 0;
      num2 <= 1;
    end else begin
      num <= num2;
      num2 <= num_next;
    end
  end

endmodule

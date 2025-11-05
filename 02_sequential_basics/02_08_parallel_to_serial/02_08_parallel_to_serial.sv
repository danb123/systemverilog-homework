//----------------------------------------------------------------------------
// Task
//----------------------------------------------------------------------------

module parallel_to_serial
# (
    parameter width = 8
)
(
    input                      clk,
    input                      rst,

    input                      parallel_valid,
    input        [width - 1:0] parallel_data,

    output                     busy,
    output logic               serial_valid,
    output logic               serial_data
);
    // Task:
    // Implement a module that converts multi-bit parallel value to the single-bit serial data.
    //
    // The module should accept 'width' bit input parallel data when 'parallel_valid' input is asserted.
    // At the same clock cycle as 'parallel_valid' is asserted, the module should output
    // the least significant bit of the input data. In the following clock cycles the module
    // should output all the remaining bits of the parallel_data.
    // Together with providing correct 'serial_data' value, module should also assert the 'serial_valid' output.
    //
    // Note:
    // Check the waveform diagram in the README for better understanding.

    logic [$clog2(width) - 1: 0] bit_count;
    logic [width - 1:0] shift_data;

    // implement a bit counter
    // started by parallel_valid and ends with bit_count = width - 1
    always_ff @(posedge clk) begin
      if (rst) begin
        bit_count <= '0;
      end else if (parallel_valid) begin
        bit_count <= 1;
      end else if (busy) begin
        bit_count <= bit_count + 1;
      end else if (bit_count == (width - 1)) begin
        bit_count <= '0;
      end
    end

    //
    // implement a bit counter and shift data register
    always_ff @(posedge clk) begin
      if (rst) begin
        shift_data <= '0;
      end else if (parallel_valid) begin
        shift_data <= parallel_data >> 1;
      end else if (busy) begin
        shift_data <= shift_data >> 1;
      end else begin
        shift_data <= 0;
      end
    end

    assign busy = (bit_count != 0);
    assign serial_data = (parallel_valid) ? parallel_data[0] : shift_data[0];
    assign serial_valid = (parallel_valid | busy);

endmodule

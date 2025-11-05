//----------------------------------------------------------------------------
// Task
//----------------------------------------------------------------------------

module serial_to_parallel
# (
    parameter width = 8
)
(
    input                      clk,
    input                      rst,

    input                      serial_valid,
    input                      serial_data,

    output logic               parallel_valid,
    output logic [width - 1:0] parallel_data
);
    // Task:
    // Implement a module that converts single-bit serial data to the multi-bit parallel value.
    //
    // The module should accept one-bit values with valid interface in a serial manner.
    // After accumulating 'width' bits and receiving last 'serial_valid' input,
    // the module should assert the 'parallel_valid' at the same clock cycle
    // and output 'parallel_data' value.
    //
    // Note:
    // Check the waveform diagram in the README for better understanding.

    logic [$clog2(width) - 1: 0] bit_count;

    // implement a bit counter and last indicator
    always_ff @(posedge clk) begin
      parallel_valid <= 0;
      if (rst) begin
        bit_count <= '0;
        parallel_data <= '0;
      end else if (serial_valid) begin
        if (bit_count == (width - 1)) begin
          parallel_valid <= 1;
          bit_count <= '0;
        end else begin
          bit_count <= bit_count + 1;
        end
        parallel_data <= parallel_data >> 1;
        parallel_data[7] <= serial_data;
      end
    end

endmodule

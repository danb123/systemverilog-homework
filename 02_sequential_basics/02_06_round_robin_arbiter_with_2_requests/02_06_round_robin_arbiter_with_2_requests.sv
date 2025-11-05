//----------------------------------------------------------------------------
// Task
//----------------------------------------------------------------------------

module round_robin_arbiter_with_2_requests
(
    input        clk,
    input        rst,
    input  [1:0] requests,
    output [1:0] grants
);
    // Task:
    // Implement a "arbiter" module that accepts up to two requests
    // and grants one of them to operate in a round-robin manner.
    //
    // The module should maintain an internal register
    // to keep track of which requester is next in line for a grant.
    //
    // Note:
    // Check the waveform diagram in the README for better understanding.
    //
    // Example:
    // requests -> 01 00 10 11 11 00 11 00 11 11
    // grants   -> 01 00 10 01 10 00 01 00 10 01
    //
    // questions:
    //  1. are grants expected to be immediate (combinatorial), or, clocks and
    //  thus one cycle after requests? this is not clear.
    //
    logic granted_zero; // indicates if the previous grant was for request[0]
    logic [1:0] grants_d;

    // it is assumed that requests is already synchronized and is stable
    // during the entire clock cycle, otherwise grants could be corrupted

    // granted_zero is a flag that indicates if that last grant was request[0]
    always_ff @(posedge clk) begin
      if (rst) begin
        granted_zero <= 0;
      end else begin
        if (grants == 2'b01) begin
          granted_zero <= 1;
        end else if (grants == 2'b10) begin
          granted_zero <= 0;
        end
      end
    end

    // combinatorial version 1
    always_comb begin
      if (requests == 2'b11) begin
        if (granted_zero) begin
          grants_d = 2'b10;
        end else begin
          grants_d = 2'b01;
        end
      end else begin
        grants_d = requests;
      end
    end
    assign grants = grants_d;


    // combinatorial version 2
    // always_comb begin
    //   if (requests == 2'b11) begin
    //     if (granted_zero) begin
    //       grants = 2'b10;
    //     end else begin
    //       grants = 2'b01;
    //     end
    //   end else begin
    //     grants = requests;
    //   end
    // end

endmodule

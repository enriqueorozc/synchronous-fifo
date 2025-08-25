module testbench();

  // System Inputs:
  logic clk;
  logic reset;

  // FIFO Module Parameters:
  parameter DATA_DEPTH = 8;
  parameter DATA_WIDTH = 32;

  // FIFO Module Inputs:
  logic [DATA_WIDTH-1:0] test_din;
  logic test_readEnable;
  logic test_writeEnable;

  // FIFO Module Outputs:
  logic [DATA_WIDTH-1:0] test_dout;
  logic test_empty;
  logic test_full;

  always #(5ns) clk = ~clk;

  sync_fifo #( .DATA_DEPTH(DATA_DEPTH), .DATA_WIDTH(DATA_WIDTH) ) dut (
    .clock(clk),
    .reset(reset),
    .din(test_din),
    .write_en(test_writeEnable),
    .read_en(test_readEnable),
    .dout(test_dout),
    .empty(test_empty),
    .full(test_full)
  );

endmodule
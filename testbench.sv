module testbench();

  // System Inputs:
  logic clk;
  logic reset;

  // FIFO Module Parameters:
  parameter DATA_DEPTH = 8;
  parameter DATA_WIDTH = 32;
  logic [DATA_WIDTH-1:0] rand_pkt [DATA_DEPTH];

  // FIFO Module Inputs:
  logic [DATA_WIDTH-1:0] din;
  logic read_en;
  logic write_en;

  // FIFO Module Outputs:
  logic [DATA_WIDTH-1:0] dout;
  logic empty;
  logic full;

  always #(5ns) clk = ~clk;

  sync_fifo #( .DATA_DEPTH(DATA_DEPTH), .DATA_WIDTH(DATA_WIDTH) ) dut (
    .clk(clk),
    .reset(reset),
    .din(din),
    .write_en(write_en),
    .read_en(read_en),
    .dout(dout),
    .empty(empty),
    .full(full)
  );

  initial begin

    // Initializing Inputs:
    clk = 0;
    write_en = 0;
    read_en = 0;

    // Randomizing Data Packet:
    for (int i = 0; i < DATA_DEPTH; i++) begin
      rand_pkt[i] = $random;
      $display("Packet Entry #%d = %h", i, rand_pkt[i]);
    end

    // Reset FIFO:
    reset = 1;
    @(posedge clk);
    reset = 0;

  end

endmodule
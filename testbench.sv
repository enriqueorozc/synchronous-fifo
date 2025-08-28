module testbench();

  // System Inputs:
  logic clk;
  logic reset;

  // FIFO Module Parameters:
  parameter DATA_DEPTH = 8;
  parameter DATA_WIDTH = 32;

  // FIFO Module Inputs:
  logic [DATA_WIDTH-1:0] din;
  logic read_en;
  logic write_en;

  // FIFO Module Outputs:
  logic [DATA_WIDTH-1:0] dout;
  logic empty;
  logic full;

  // Random Data Packet:
  logic [DATA_WIDTH-1:0] rand_pkt [DATA_DEPTH];

  always #(10ns) clk = ~clk;

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

    // ---------- Test 1: Empty FIFO State ---------- //

    // Reset FIFO:
    reset = 1;
    @(posedge clk);
    reset = 0;

    assert(empty && !full);

    // // Randomizing Data Packet:
    // for (int i = 0; i < DATA_DEPTH; i++) begin
    //   rand_pkt[i] = $random;
    // end

    // // ---------- Test 2 ---------- //
    // $display("Test 2: Filling FIFO");

    // @(posedge clk);
    // write_en = 1;

    // for (int i = 0; i < DATA_DEPTH; i++) begin
    //   din = rand_pkt[i];
    //   @(poedge clk);
    // end

    // write_en = 0;

    $finish;
  end
endmodule
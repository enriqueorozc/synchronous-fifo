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

  // Debug Outputs:
  logic [$clog2(DATA_DEPTH)-1:0] readPtr;
  logic [$clog2(DATA_DEPTH)-1:0] writePtr;

  always #(5ns) clk = ~clk;

  sync_fifo #( .DATA_DEPTH(DATA_DEPTH), .DATA_WIDTH(DATA_WIDTH) ) dut (
    .clk(clk),
    .reset(reset),
    .din(din),
    .write_en(write_en),
    .read_en(read_en),
    .dout(dout),
    .empty(empty),
    .full(full),
    .write_ptr(writePtr),
    .read_ptr(readPtr)
  );

  initial begin

    // Initializing Inputs:
    clk = 0;
    write_en = 0;
    read_en = 0;
    reset = 1;
    
    $monitor("din: %h, rd_en: %b, wr_en: %b, dout: %h, empty: %b, full: %b, readPtr: %d, writePtr: %d",
      din, read_en, write_en, dout, empty, full, readPtr, writePtr);
    
    // ---------- Test 1 ---------- //
    $display("Test 1: Empty FIFO State");

    // Reset FIFO:
    @(negedge clk);
    reset = 0;

    assert(empty && !full);

    // Randomizing Data Packet:
    for (int i = 0; i < DATA_DEPTH; i++) begin
      rand_pkt[i] = $random;
    end

    // ---------- Test 2 ---------- //
    $display("Test 2: Filling FIFO");

    @(negedge clk);
    write_en = 1;

    for (int i = 0; i < DATA_DEPTH; i++) begin
      din = rand_pkt[i];
      @(posedge clk);
    end

    write_en = 0;
    assert (full);
    
    // ---------- Test 3 ---------- //
    $display("Test 3: Correct Placement");
  	
    @(negedge clk);
    @(negedge clk);
    read_en = 1;
  
    for (int i = 0; i < DATA_DEPTH; i++) begin
      @(posedge clk);
    end

    $finish;
  end
endmodule
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
  
  always #5 clk = ~clk;

  initial begin

    // Initializing Inputs:
    clk = 0;
    write_en = 0;
    read_en = 0;
    reset = 1;
    
    $monitor("din = %h, wr_en = %b, rd_en = %b, reset = %b, dout = %h, full = %b, empty = %b",
      din, write_en, read_en, reset, dout, full, empty);

    // ---------- Test 1: Empty FIFO State ---------- //
    $display("Test 1: Empty FIFO State");

    // Turn off Reset:
    @(negedge clk);
    reset = 0;
    @(posedge clk);

    assert(empty && !full);

    // ---------- Test 2: Filling and Unloading the FIFO ---------- //
    $display("Test 2: Filling and Unloading the FIFO");
    
    // Randomizing Data Packet:
    for (int i = 0; i < DATA_DEPTH; i++) begin
    	rand_pkt[i] = $random;
    end
    
    // Prepare to Write:
    @(posedge clk);
    write_en = 1;
    
    for (int i = 0; i < DATA_DEPTH; i++) begin
      din = rand_pkt[i];
      @(posedge clk);
    end
    
    // Turn off Write Enable:
    write_en = 0;
    @(posedge clk);
    
    // Prepare to Read:
    read_en = 1;
    @(posedge clk);
    
    for (int i = 0; i < DATA_DEPTH; i++) begin
      assert(dout == rand_pkt[i]);
      @(posedge clk);
	end
    
    $finish;
  end
endmodule
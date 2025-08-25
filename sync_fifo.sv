module sync_fifo #(parameter 
  DATA_DEPTH = 8,
  DATA_WIDTH = 32
) (

  // System Inputs:
  input logic clk,
  input logic reset,

  // FIFO Inputs:
  input logic [DATA_WIDTH-1:0] din,
  input logic write_en,
  input logic read_en,

  // FIFO Outputs:
  output logic [DATA_WIDTH-1:0] dout,
  output logic empty,
  output logic full

);

  // Circular Buffer:
  logic [DATA_DEPTH-1:0] [DATA_WIDTH-1:0] buffer;

  // Internal Pointers:
  logic [$clog2(DATA_DEPTH)-1:0] writePtr;
  logic [$clog2(DATA_DEPTH)-1:0] readPtr;

  // Writing Handling:
  always_ff @(posedge clk) begin
    if (reset) begin
      writePtr <= 0;
    end else begin

      if (write_en && !full) begin
        buffer[writePtr] <= din;
        writePtr <= writePtr + 1;
      end

    end
  end

  // Reading Handling:
  always_ff @(posedge clk) begin
    if (reset) begin
      readPtr <= 0;
    end else begin

      if (read_en && !empty) begin
        dout <= din[readPtr];
        readPtr <= readPtr + 1;
      end

    end
  end 

  assign full = (writePtr + 1 == readPtr);
  assign empty = (writePtr == readPtr);

endmodule
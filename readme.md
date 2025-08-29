# Synchronous FIFO (First-In-First-Out) Data Buffer

## Overview:
A synchronous FIFO is a queue-based data buffer that stores and retrieves data in the order it was written into the
queue. In this design, the FIFO's read and write operations are synchronized to the same clock and occur on the posedge.

This FIFO is parameterized by:
 - **DATA_DEPTH**: The maximum number of entries the buffer can store
 - **DATA_WIDTH**: The bit-width of each entry

There are additional controls inputs, such as the 'write_en' (write enable) and the 'read_en' (read enable). These control
inputs allow users to manage the data flow of the FIFO. 

## Output Behavior:
This FIFO implementation has three outputs, defined as:
- **dout**: The data at the front of the queue
- **full**: A flag that indicates if the queue has reached it's maximum number of entries
- **empty**: A flag that indicates if the queue has no entries

The intended behavior of this FIFO is to allow the user fill it with data until it reaches it's maximum number of entries, and
when the FIFO is full, it won't store any more data until a read or reset has occured. By reading from the FIFO you're removing
that data from the queue.

## Testing Methodology:
The approach I took to test this synchronous FIFO was a directed verification approach with assertion-based vertification to target
general and specific edge-cases that would be encountered under normal operation. The key scenario I targeted were:

- **Empty / Full State**: Ensure that the FIFO's full and empty flags work properly and that these two flags can never both be high
- **Filling & Unfilling the FIFO**: Ensure that the FIFO's, first-in and first-out property was properly implemented by inputting 
randomized and getting that data in the order it was pushed

# Synchronous FIFO (First-In-First-Out) Data Buffer

## Overview:
A synchronous FIFO is a queue-based data buffer that stores and retrieves data in the order it was written into the
queue. In this design, the FIFO's read and write operations are synchronized to the same clock and occur on the posedge.

This FIFO is parameterized by:
 - **DATA_DEPTH**: The maximum number of entries the buffer can store
 - **DATA_WIDTH**: The bit-width of each entry

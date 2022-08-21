`timescale 1ns / 1ps

module fifo(clk, rst, buf_in, buf_out, wr_en, rd_en, buf_empty, buf_full, fifo_counter);

input rst, clk, wr_en, rd_en;
input [7:0] buf_in;	// 8 bit data in
output [7:0] buf_out;	// 8 bit data out
output buf_empty, buf_full;
output [6:0] fifo_counter;	// to count 0 - 64

reg [7:0] buf_out;
reg buf_empty, buf_full;
reg [6:0] fifo_counter;
reg [5:0] rd_ptr, wr_ptr;	// to represent 64 locations
reg [7:0] buf_mem[63:0];	// 8 bit 64 location memory (64 byte memory);

// to monitor buf_empty, buf_full flags
always @(fifo_counter)
begin
	buf_empty <= (fifo_counter == 0);
	buf_full <= (fifo_counter == 64);
end

// to monitor fifo_counter
always @(posedge clk or posedge rst)
begin
	if(rst)
		fifo_counter <= 0;
		
	else if((!buf_full && wr_en) && (!buf_empty && rd_en))
		fifo_counter <= fifo_counter;
		
	else if(!buf_full && wr_en)
		fifo_counter <= fifo_counter + 1;
	
	else if(!buf_empty && rd_en)
		fifo_counter <= fifo_counter - 1;
	
	else
		fifo_counter <= fifo_counter;

end

// to fetch data from fifo (buf_out)
always @(posedge clk or posedge rst)
begin
	if(rst)
		buf_out <= 0;
		
	else
	begin
		if(rd_en && !buf_empty)
			buf_out <= buf_mem[rd_ptr];
		else
			buf_out <= buf_out;
	end
end

// wriring data into the fifo
always @(posedge clk)
begin
	if(wr_en && !buf_full)
		buf_mem[wr_ptr] <= buf_in;
	else
		buf_mem[wr_ptr] <= buf_mem[wr_ptr];
end

// to control read pointer and write pointer
always @(posedge clk or posedge rst)
begin
	if(rst)
	begin
		wr_ptr <= 0;
		rd_ptr <= 0;
	end
	
	else
	begin
		if(!buf_full && wr_en)
			wr_ptr <= wr_ptr + 1;
		else
			wr_ptr <= wr_ptr;
			
		if(!buf_empty && rd_en)
			rd_ptr <= rd_ptr + 1;
		else
			rd_ptr <= rd_ptr;
	end
end

endmodule
		
	

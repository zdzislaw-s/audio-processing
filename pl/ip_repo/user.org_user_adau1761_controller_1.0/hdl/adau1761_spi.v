`timescale 1ns/1ns
    module adau1761_spi #
(
    parameter clk_period = 100,
    parameter max_bytes = 8
)
(
     input clk,
     input reset,
     input start,
     output reg busy,
     input read,
     input [$clog2(max_bytes)-1:0] nbytes,
     input [15:0] address,
     input [max_bytes*8-1:0] write_data,
     output [max_bytes*8-1:0] read_data,
     output reg spi_clk,
     output reg spi_frame,
     output reg spi_mosi,
     input spi_miso
);

    localparam clk_half_period = clk_period/2;

    reg [1:0] start_shift = 0;
    always @(posedge clk)
        start_shift <= {start_shift,start};

    wire start_rise = start_shift == 2'b01;

    reg [$clog2(clk_period)-1:0] clk_count;
    always @(posedge clk)
    if (reset)
        clk_count <= 0;
    else if (!busy && start_rise)
        clk_count <= 0;
        else if (busy)
            if (clk_count == clk_period-1)
                clk_count <= 0;
            else
                clk_count <= clk_count+1;

    wire clk_rise = clk_count == clk_half_period;
    wire clk_fall = clk_count == 0;
    always @(posedge clk)
        if (clk_fall) spi_clk <= 0;
        else if (clk_rise) spi_clk <= 1;

    integer shift_count;
    reg [8*max_bytes+24:0] shift_reg;
    always @(posedge clk)
        if (reset)
            busy <= 0;
        else if (!busy) begin
            if (start_rise) begin
                busy <= 1;
                shift_count <= 0;
                shift_reg <= {8'b0,read,address,write_data};
            end
        end
        else if (clk_rise)
            shift_count <= shift_count+1;
        else if (clk_fall) begin
            shift_reg <= {shift_reg,spi_miso};
            if (shift_count == 32+nbytes*8)
                busy <= 0;
        end

    assign read_data = shift_reg[max_bytes*8-1:0];

    always @(*) spi_frame = ~busy;
    always @(*) spi_mosi = shift_reg[8*max_bytes+24];

endmodule

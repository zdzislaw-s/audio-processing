`timescale 1ns/1ns

/*******************************************************************************

                      axi4_stream_delay
                        # DATA_WIDTH = 32
                        # SAMPLE_WIDTH = 16
                        # MAX_DELAY = 8192
                      +-------------+
             ACLK --> |             |
          ARESETN --> |             |
                      |             |
    S_AXIS_TREADY <-- |             | <-- M_AXIS_TREADY
    S_AXIS_TVALID --> |             | --> M_AXIS_TVALID
     S_AXIS_TLAST --> |             | --> M_AXIS_TLAST
     S_AXIS_TDATA --> |             | --> M_AXIS_TDATA
                      +-------------+

*******************************************************************************/
module axi4_stream_delay #(
    parameter DATA_WIDTH = 32,
    parameter SAMPLE_WIDTH = 16,
    parameter MAX_DELAY = 8192
) (
    input ACLK,
    input ARESETN,
    input M_AXIS_TREADY,
    output reg M_AXIS_TVALID,
    output reg M_AXIS_TLAST,
    output reg [DATA_WIDTH - 1:0] M_AXIS_TDATA,
    output reg S_AXIS_TREADY,
    input S_AXIS_TVALID,
    input S_AXIS_TLAST,
    input [DATA_WIDTH - 1:0] S_AXIS_TDATA,
    output reg [SAMPLE_WIDTH - 1:0] sample
);
    localparam SAMPLE_2xWIDTH = 2 * SAMPLE_WIDTH;

    reg [$clog2(MAX_DELAY):0] delay = MAX_DELAY;
    reg [$clog2(SAMPLE_WIDTH):0] scale = 0;

    reg [SAMPLE_2xWIDTH - 1:0] delay_mem[0:MAX_DELAY - 1];

    /***************************************************************************
     * S_AXIS_* section.
     */
    reg [$clog2(MAX_DELAY):0] cidx_receive; // current idx into delay_mem for receive
    reg idx_ctrl = 0;
    always @(posedge ACLK)
        if (!ARESETN) begin
            cidx_receive <= 0;
            idx_ctrl <= 0;
        end else if (S_AXIS_TVALID && S_AXIS_TREADY) begin
            idx_ctrl <= ~idx_ctrl;
            if (idx_ctrl)
                if (cidx_receive == MAX_DELAY - 1)
                    cidx_receive <= 0;
                else
                    cidx_receive <= cidx_receive + 1;
        end

     always @(posedge ACLK)
        // receive sample for left channel (drop the least significant bits)
        if (S_AXIS_TVALID && !S_AXIS_TLAST && S_AXIS_TREADY) begin
            delay_mem[cidx_receive][SAMPLE_WIDTH - 1 -: SAMPLE_WIDTH] <=
                S_AXIS_TDATA[DATA_WIDTH - 1 -: SAMPLE_WIDTH];
            sample <= S_AXIS_TDATA[DATA_WIDTH - 1 -: SAMPLE_WIDTH];
        end
        // receive sample for right channel (drop the least significant bits)
        else if (S_AXIS_TVALID && S_AXIS_TLAST && S_AXIS_TREADY) begin
            delay_mem[cidx_receive][SAMPLE_2xWIDTH - 1 -: SAMPLE_WIDTH] <=
                S_AXIS_TDATA[DATA_WIDTH - 1 -: SAMPLE_WIDTH];
            sample <= S_AXIS_TDATA[DATA_WIDTH - 1 -: SAMPLE_WIDTH];
        end

    always @(posedge ACLK)
        if (!ARESETN)
            S_AXIS_TREADY <= 0;
        else
            S_AXIS_TREADY <= ~S_AXIS_TREADY;
    /******************************************************* End Of Section ***/

    /***************************************************************************
     * M_AXIS_* section.
     */
    reg [$clog2(MAX_DELAY):0] cidx_send; // current idx into delay_mem for send
    always @(posedge ACLK)
        if (!ARESETN)
            cidx_send <= delay == 0 ? 0 : MAX_DELAY - delay;
        else if (S_AXIS_TVALID && S_AXIS_TREADY)
            if (!idx_ctrl)
                if (cidx_send == MAX_DELAY - 1)
                    cidx_send <= 0;
                else
                    cidx_send <= cidx_send + 1;

    always @(posedge ACLK)
        if (!ARESETN) begin
            M_AXIS_TLAST <= 1;
            M_AXIS_TDATA = 0;
        end else
            if (!M_AXIS_TVALID)
                // setup the left channel
                if (M_AXIS_TLAST) begin
                    M_AXIS_TDATA[DATA_WIDTH - 1 -: SAMPLE_WIDTH] <=
                        delay_mem[cidx_send][SAMPLE_WIDTH - 1 -: SAMPLE_WIDTH] <<
                            scale;
                    M_AXIS_TLAST <= 0;
                // setup the right channel
                end else begin
                    M_AXIS_TDATA[DATA_WIDTH - 1 -: SAMPLE_WIDTH] <=
                        delay_mem[cidx_send][SAMPLE_2xWIDTH - 1 -: SAMPLE_WIDTH] <<
                            scale;
                    M_AXIS_TLAST <= 1;
                end

    always @(posedge ACLK)
        if (!ARESETN)
            M_AXIS_TVALID <= 0;
        else if (!M_AXIS_TREADY && !M_AXIS_TVALID)
            M_AXIS_TVALID <= 1;
        else if (M_AXIS_TREADY)
            M_AXIS_TVALID <= ~M_AXIS_TVALID;
    /******************************************************* End Of Section ***/

endmodule

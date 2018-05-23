`timescale 1ns/1ns
module i2s_transmitter # (
    parameter DATA_WIDTH = 32
) (
    input S_AXIS_ACLK,
    input S_AXIS_ARESETN,
    input S_AXIS_TVALID,
    input [DATA_WIDTH - 1:0] S_AXIS_TDATA,
    input S_AXIS_TLAST,
    output reg S_AXIS_TREADY,
    input sck,
    input ws,
    output sd
);
    reg [1:0] sck_ctrl = 0;
    always @(posedge S_AXIS_ACLK) begin
        sck_ctrl <= {sck_ctrl, sck};
    end
    wire sck_rise = sck_ctrl == 2'b01;
    wire sck_fall = sck_ctrl == 2'b10;

    // 2-bit register to control wsd and wsp signals.
    reg [1:0] data_ctrl = 0;
    always @(posedge sck) begin
        data_ctrl <= {data_ctrl, ws};
    end
    wire wsd = data_ctrl[0]; // word strobe direction: 0 - left, 1 - right
    wire wsp = ^data_ctrl; // word strobe pulse

    reg [DATA_WIDTH - 1:0] data_left = 0;
    reg [DATA_WIDTH - 1:0] data_right = 0;
    reg [0:DATA_WIDTH - 1] data = 0;
    always @(posedge S_AXIS_ACLK) begin
        if (sck_fall)
            if (wsp)
                data <= wsd ? data_right : data_left;
            else
                data <= { data[1:DATA_WIDTH - 1], 1'b0 };
    end

    assign sd = data[0];

    always @(posedge S_AXIS_ACLK)
        if (!S_AXIS_ARESETN)
            S_AXIS_TREADY <= 0;
        else if (S_AXIS_TREADY && S_AXIS_TVALID)
            S_AXIS_TREADY <= 0;
        else if (wsp && S_AXIS_TLAST == wsd)
            S_AXIS_TREADY <= 1;

    always @(posedge S_AXIS_ACLK)
        if (S_AXIS_TREADY && S_AXIS_TVALID && !S_AXIS_TLAST)
            data_left <= S_AXIS_TDATA;

    always @(posedge S_AXIS_ACLK)
        if (S_AXIS_TREADY && S_AXIS_TVALID && S_AXIS_TLAST)
            data_right <= S_AXIS_TDATA;

endmodule

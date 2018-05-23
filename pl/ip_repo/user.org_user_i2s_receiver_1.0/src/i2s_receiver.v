`timescale 1ns/1ns
module i2s_receiver # (
    parameter DATA_WIDTH = 32
) (
    input M_AXIS_ACLK,
    input M_AXIS_ARESETN,
    output reg M_AXIS_TVALID,
    output reg [DATA_WIDTH - 1:0] M_AXIS_TDATA,
    output reg M_AXIS_TLAST,
    input M_AXIS_TREADY,
    input sck,
    input ws,
    input sd
);
    reg [1:0] sck_ctrl = 0;
    always @(posedge M_AXIS_ACLK) begin
        sck_ctrl <= {sck_ctrl, sck};
    end
    wire sck_rise = sck_ctrl == 2'b01;
    wire sck_fall = sck_ctrl == 2'b10;

    // 2-bit register to control wsd and wsp signals.
    reg [1:0] data_ctrl = 0;
    always @(posedge M_AXIS_ACLK) begin
        if (sck_rise)
            data_ctrl <= {data_ctrl, ws};
    end
    wire wsd = data_ctrl[0];
    wire wsp = data_ctrl[1] ^ wsd;

    reg [$clog2(DATA_WIDTH + 1) - 1:0] counter = 0;
    always @(posedge M_AXIS_ACLK) begin
        if (sck_fall)
            if (wsp)
                counter <= 0;
            else
                if (counter < DATA_WIDTH)
                    counter <= counter + 1;
    end

    // 32-bit register for data.
    reg [0:DATA_WIDTH - 1] data;
    always @(posedge M_AXIS_ACLK) begin
        if (sck_rise) begin
            if (wsp)
                data <= 0;
            if (counter < DATA_WIDTH)
                data[counter] <= sd;
        end
    end

    always @(posedge M_AXIS_ACLK) begin
        if (sck_rise && wsp)
            M_AXIS_TDATA <= data;
    end

    always @(posedge M_AXIS_ACLK) begin
        if (!M_AXIS_ARESETN)
            M_AXIS_TVALID <= 0;
        else if (sck_rise && wsp)
            M_AXIS_TVALID <= 1;
        else if (M_AXIS_TREADY)
            M_AXIS_TVALID <= 0;
    end

    always @(posedge M_AXIS_ACLK) begin
        if (sck_rise && wsp)
            M_AXIS_TLAST <= !wsd;
    end

endmodule

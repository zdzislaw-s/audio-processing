`timescale 1 ps / 1 ps

module sample_scaler # (
    parameter SAMPLE_I_WIDTH = 16,
    parameter SAMPLE_O_WIDTH = 8
) (
    input [SAMPLE_I_WIDTH - 1:0] sample_i,
    output [SAMPLE_O_WIDTH - 1:0] sample_o
);
    wire [SAMPLE_O_WIDTH - 1:0] sample_tmp;
    
    assign sample_o =
        (
            (sample_i[SAMPLE_I_WIDTH - 1] == 1 ? ~sample_i[SAMPLE_I_WIDTH - 2:0] : sample_i[SAMPLE_I_WIDTH - 2:0])
            *
            ((1<<SAMPLE_O_WIDTH) - 1)
        )
        /
        (
            (1<<(SAMPLE_I_WIDTH - 1) - 1)
        );

endmodule

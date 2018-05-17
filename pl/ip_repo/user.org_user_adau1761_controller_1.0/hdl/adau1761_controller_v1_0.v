
`timescale 1 ns / 1 ps

	module adau1761_controller_v1_0 #
	(
		// Users to add parameters here
        parameter SPI_CLOCK_PERIOD = 100,
		// User parameters ends
		// Do not modify the parameters beyond this line


		// Parameters of Axi Slave Bus Interface S00_AXI
		parameter integer C_S00_AXI_DATA_WIDTH	= 32,
		parameter integer C_S00_AXI_ADDR_WIDTH	= 5
	)
	(
		// Users to add ports here
        (* mark_debug = "true" *) output adau1761_cclk,
        (* mark_debug = "true" *) output adau1761_clatchn,
        (* mark_debug = "true" *) output adau1761_cdata,
        (* mark_debug = "true" *) input adau1761_cout,
		// User ports ends
		// Do not modify the ports beyond this line


		// Ports of Axi Slave Bus Interface S00_AXI
		input wire  s00_axi_aclk,
		input wire  s00_axi_aresetn,
		input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_awaddr,
		input wire [2 : 0] s00_axi_awprot,
		input wire  s00_axi_awvalid,
		output wire  s00_axi_awready,
		input wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_wdata,
		input wire [(C_S00_AXI_DATA_WIDTH/8)-1 : 0] s00_axi_wstrb,
		input wire  s00_axi_wvalid,
		output wire  s00_axi_wready,
		output wire [1 : 0] s00_axi_bresp,
		output wire  s00_axi_bvalid,
		input wire  s00_axi_bready,
		input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_araddr,
		input wire [2 : 0] s00_axi_arprot,
		input wire  s00_axi_arvalid,
		output wire  s00_axi_arready,
		output wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_rdata,
		output wire [1 : 0] s00_axi_rresp,
		output wire  s00_axi_rvalid,
		input wire  s00_axi_rready
	);
    (* mark_debug = "true" *) wire reset;
    (* mark_debug = "true" *) wire start;
    (* mark_debug = "true" *) wire read;
    (* mark_debug = "true" *) wire [15:0] address;
    (* mark_debug = "true" *) wire [2:0] nbytes;
    (* mark_debug = "true" *) wire [63:0] write_data;
    (* mark_debug = "true" *) wire busy;
    (* mark_debug = "true" *) wire [63:0] read_data;

    // Instantiation of Axi Bus Interface S00_AXI
	adau1761_controller_v1_0_S00_AXI # (
		.C_S_AXI_DATA_WIDTH(C_S00_AXI_DATA_WIDTH),
		.C_S_AXI_ADDR_WIDTH(C_S00_AXI_ADDR_WIDTH)
	) adau1761_controller_v1_0_S00_AXI_inst (
        .reset(reset),
        .start(start),
        .read(read),
        .nbytes(nbytes),
        .address(address),
        .write_data(write_data),
        .busy(busy),
        .read_data(read_data),
        .S_AXI_ACLK(s00_axi_aclk),
		.S_AXI_ARESETN(s00_axi_aresetn),
		.S_AXI_AWADDR(s00_axi_awaddr),
		.S_AXI_AWPROT(s00_axi_awprot),
		.S_AXI_AWVALID(s00_axi_awvalid),
		.S_AXI_AWREADY(s00_axi_awready),
		.S_AXI_WDATA(s00_axi_wdata),
		.S_AXI_WSTRB(s00_axi_wstrb),
		.S_AXI_WVALID(s00_axi_wvalid),
		.S_AXI_WREADY(s00_axi_wready),
		.S_AXI_BRESP(s00_axi_bresp),
		.S_AXI_BVALID(s00_axi_bvalid),
		.S_AXI_BREADY(s00_axi_bready),
		.S_AXI_ARADDR(s00_axi_araddr),
		.S_AXI_ARPROT(s00_axi_arprot),
		.S_AXI_ARVALID(s00_axi_arvalid),
		.S_AXI_ARREADY(s00_axi_arready),
		.S_AXI_RDATA(s00_axi_rdata),
		.S_AXI_RRESP(s00_axi_rresp),
		.S_AXI_RVALID(s00_axi_rvalid),
		.S_AXI_RREADY(s00_axi_rready)
	);

    // Add user logic here
    adau1761_spi #
    (
        .clk_period(SPI_CLOCK_PERIOD),
        .max_bytes(8)
    )
    adau1761_spi
    (
        .clk(s00_axi_aclk),
        .reset(reset),
        .start(start),
        .busy(busy),
        .read(read),
        .address(address),
        .nbytes(nbytes),
        .write_data(write_data),
        .read_data(read_data),
        .spi_clk(adau1761_cclk),
        .spi_frame(adau1761_clatchn),
        .spi_mosi(adau1761_cdata),
        .spi_miso(adau1761_cout)
    );
// User logic ends

	endmodule

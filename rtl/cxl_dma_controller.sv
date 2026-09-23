// SystemVerilog IEEE 1800-2017
// Module: cxl30_type3_dma_controller
// Description: Zero-copy DMA Controller for CXL 3.0 Type-3 Memory Pools.

module cxl30_type3_dma_controller #(
    parameter int CXL_ADDR_WIDTH = 64,
    parameter int PAGE_SIZE_KB   = 4
)(
    input  logic                        clk,
    input  logic                        rst_n,

    // Interface from Parser
    input  logic                        i_cxl_tag_valid,
    input  logic [31:0]                 i_cxl_memory_handle,
    input  logic [15:0]                 i_cxl_transit_node_id,

    // Interface to Spatial Control Plane
    input  logic [CXL_ADDR_WIDTH-1:0]   i_cfg_cxl_base_addr,
    input  logic                        i_cfg_fastpath_enable,

    // CXL.mem Protocol Output Interface
    output logic                        o_cxl_dma_req,
    output logic [CXL_ADDR_WIDTH-1:0]   o_cxl_mem_addr,
    output logic [2:0]                  o_cxl_traffic_class,
    input  logic                        i_cxl_dma_ack
);

    logic [CXL_ADDR_WIDTH-1:0] computed_offset;
    assign computed_offset = i_cxl_memory_handle * (PAGE_SIZE_KB * 1024);

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            o_cxl_dma_req       <= 1'b0;
            o_cxl_mem_addr      <= '0;
            o_cxl_traffic_class <= 3'b000;
        end else begin
            if (i_cxl_tag_valid && i_cfg_fastpath_enable) begin
                o_cxl_dma_req       <= 1'b1;
                o_cxl_mem_addr      <= i_cfg_cxl_base_addr + computed_offset;
                o_cxl_traffic_class <= 3'b111; // URLLC Priority
            end else if (i_cxl_dma_ack) begin
                o_cxl_dma_req       <= 1'b0;
            end
        end
    end

endmodule

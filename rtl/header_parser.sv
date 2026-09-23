// SystemVerilog IEEE 1800-2017
// Module: p4_cxl_tag_parser
// Description: High-throughput packet header parser for fast-path CXL tags.

module p4_cxl_tag_parser #(
    parameter int DATA_WIDTH = 512,
    parameter bit [15:0] CXL_ETHERTYPE = 16'h88F7
)(
    input  logic                    clk,
    input  logic                    rst_n,

    // Ingress AXI-Stream Interface
    input  logic [DATA_WIDTH-1:0]   i_axis_tdata,
    input  logic                    i_axis_tvalid,
    input  logic                    i_axis_tlast,
    output logic                    o_axis_tready,

    // Extracted CXL Metadata Signals
    output logic                    o_cxl_tag_valid,
    output logic [31:0]             o_cxl_memory_handle,
    output logic [15:0]             o_cxl_transit_node_id,
    output logic [47:0]             o_eth_dst_mac,
    output logic [47:0]             o_eth_src_mac
);

    typedef enum logic [1:0] {
        ST_IDLE,
        ST_PARSE_HEADER,
        ST_BYPASS_PAYLOAD
    } state_t;

    state_t state_q, state_d;
    logic [15:0] ether_type;

    assign o_axis_tready = 1'b1;

    // Header extraction mapping
    assign o_eth_dst_mac          = i_axis_tdata[511:464];
    assign o_eth_src_mac          = i_axis_tdata[463:416];
    assign ether_type             = i_axis_tdata[415:400];
    assign o_cxl_memory_handle    = i_axis_tdata[399:368];
    assign o_cxl_transit_node_id = i_axis_tdata[367:352];

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state_q         <= ST_IDLE;
            o_cxl_tag_valid <= 1'b0;
        end else begin
            state_q <= state_d;
            if (state_q == ST_IDLE && i_axis_tvalid && (ether_type == CXL_ETHERTYPE)) begin
                o_cxl_tag_valid <= 1'b1;
            end else if (state_q != ST_IDLE) begin
                o_cxl_tag_valid <= 1'b0;
            end
        end
    end

    always_comb begin
        state_d = state_q;
        case (state_q)
            ST_IDLE: begin
                if (i_axis_tvalid) begin
                    if (i_axis_tlast)
                        state_d = ST_IDLE;
                    else
                        state_d = ST_BYPASS_PAYLOAD;
                end
            end
            ST_BYPASS_PAYLOAD: begin
                if (i_axis_tvalid && i_axis_tlast) begin
                    state_d = ST_IDLE;
                end
            end
            default: state_d = ST_IDLE;
        endcase
    end

endmodule

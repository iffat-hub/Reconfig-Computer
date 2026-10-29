module v_decoder (
    input logic clk,rst,
    input logic [31:0] s_axis_tdata,
    input logic s_axis_tvalid,s_axis_tlast,
    output logic s_axis_tready,

    input logic m_axis_tready,
    output logic m_axis_tlast,m_axis_tvalid,
    output logic [31:0] m_axis_tdata
);

logic [30:0] total;
logic color;
logic total_flag;
typedef enum logic {FETCH,DECODE} state_t;
state_t s,ns;

always_ff @(posedge clk) begin
    if (rst) begin
        s<=FETCH;
    end
    else begin
        s<=ns;
        case (s)
            FETCH:begin
                total_flag<=0;
                if (s_axis_tvalid) begin
                    color<=s_axis_tdata[31];
                    total<=s_axis_tdata[30:0];
                end
            end 
            DECODE:begin
                if (total==0) begin
                    total_flag<=1;
                end
                else if (m_axis_tready) begin
                    total<=total-1;
                    m_axis_tdata<={31'b0,color};
                end
            end
        endcase
    end
end

always_comb begin
    ns=s;
    s_axis_tready=0;
    m_axis_tvalid=0;
    m_axis_tlast=0;
    case (s)
        FETCH:begin
            s_axis_tready=1;
            if (s_axis_tvalid) begin
                ns=DECODE;
            end
        end 
        DECODE:begin
            m_axis_tvalid=1;
            if(total==0) begin
                ns=FETCH;
                m_axis_tlast=1;
            end
        end
        default: 
    endcase
end

endmodule
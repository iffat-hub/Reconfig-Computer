module adecoder #(
    
) (
    input logic clk,rst,
    input logic [31:0] s_axis_tdata,
    input logic s_axis_tvalid,s_axis_tlast,
    output logic s_axis_tready,

    input logic m_axis_tready,m_axis_tlast,m_axis_tvalid,
    output logic [31:0] m_axis_tdata
    );

    logic [15:0] step_table [0:88]=[7, 8, 9, 10, 11, 12, 13, 14, 16, 17, 19, 21, 23, 25, 28, 31, 34, 37, 41, 45, 
 50, 55, 60, 66, 73, 80, 88, 97, 107, 118, 130, 143, 157, 173, 190, 209, 230, 
 253, 279, 307, 337, 371, 408, 449, 494, 544, 598, 658, 724, 796, 876, 963, 
 1060, 1166, 1282, 1411, 1552, 1707, 1878, 2066, 2272, 2499, 2749, 3024, 3327, 
 3660, 4026, 4428, 4871, 5358, 5894, 6484, 7132, 7845, 8630, 9493, 10442, 11487, 
 12635, 13898, 15288, 16816, 18497, 20347, 22382, 24620, 27082, 29790, 32767];

 logic int index_table [0:7]=[-1, -1, -1, -1, 2, 4, 6, 8];

logic [15:0] prev_sample;


/*

 logic [15:0] prev_sample;
 logic [6:0] prev_index;
 logic [15:0] step;
 logic [15:0] step_index;
 logic [15:0] diff_q;
 logic sign;
 logic [2:0] mag;


always_ff @( posedge clk ) begin
    if (rst) begin
        prev_sample <= 0;
        prev_index <= 0;
        sign <= 0;
        mag <= 0;
        step <= 0;
        step_index <= 0;
    end
    else if (s_axis_tvalid && s_axis_tready) begin
        sign <= s_axis_tdata[7];
        mag <= s_axis_tdata[6:4];
        step_index <= prev_index + index_table[s_axis_tdata[3:0]]; //have to change
        if (step_index < 0) step_index <= 0;
        else if (step_index > 88) step_index <= 88;
        step <= step_table[step_index];
        prev_index <= step_index;
        
    end
    if (sign)
        pcm_temp <= predicted_sample - diff_q;
    else
        pcm_temp <= predicted_sample + diff_q;

    
end

always_comb begin
    diff_q = step >> 3;
    if (mag[0]) diff_q = diff_q + (step >> 2);
    if (mag[1]) diff_q = diff_q + (step >> 1);
    if (mag[2]) diff_q = diff_q + step;

    if (pcm_temp > 32767)
        predicted_sample_next = 32767;
    else if (pcm_temp < -32768)
        predicted_sample_next = -32768;
    else
        predicted_sample_next = pcm_temp[15:0];
    end
 */   
endmodule
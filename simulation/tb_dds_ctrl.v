`timescale 1ns/1ns
module tb_dds_ctrl();

reg         sys_clk;
reg         sys_rst_n;

reg [1:0]   waveform_counter;
reg [4:0]   freq_counter;
reg [4:0]   freq_counter2;


wire [7:0]  dac_data;


initial
    begin
        sys_clk     <= 1'b1;
        sys_rst_n   <= 1'b0;
        waveform_counter <= 2'b00;
        freq_counter    <= 5'b00000;
        freq_counter2  <=  5'b00000;
        #200
        sys_rst_n   <= 1'b1;
        #5000
        freq_counter    <= 5'b00010;
        #5000       // make sure the time here is longer than the period
        freq_counter    <= 5'b00100;
        #5000
        freq_counter    <= 5'b01110;
        #5000
        freq_counter    <= 5'b11010;
        #5000
        freq_counter    <= 5'b00000;
    
    end
    
    
always #10 sys_clk <= ~sys_clk;
    
    
    
    
    
dds_ctrl    dds_ctrl_inst
(
    .sys_clk  (sys_clk  ),
    .sys_rst_n(sys_rst_n),
    .waveform_counter (waveform_counter ),
    .freq_counter (freq_counter),
    .freq_counter2 (freq_counter2),
      
    .dac_data (dac_data )

);
endmodule
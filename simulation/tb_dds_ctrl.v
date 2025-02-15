`timescale 1ns/1ns
module tb_dds_ctrl();

reg         sys_clk;
reg         sys_rst_n;
reg [3:0]   wave_sel;


wire [7:0]  dac_data;

initial
    begin
        sys_clk     <= 1'b1;
        sys_rst_n   <= 1'b0;
        wave_sel    <= 4'b0000;
        #200
        sys_rst_n   <= 1'b1;
        #10000
        wave_sel    <= 4'b0001;
        #8000000       // make sure the time here is longer than the period
        wave_sel    <= 4'b0010;
        #8000000
        wave_sel    <= 4'b0100;
        #8000000
        wave_sel    <= 4'b1000;
        #8000000
        wave_sel    <= 4'b0000;
    
    end
    
    
always #10 sys_clk <= ~sys_clk;
    
    
    
    
    
dds_ctrl    dds_ctrl_inst
(
    .sys_clk     (sys_clk  ),
    .sys_rst_n   (sys_rst_n),
    .wave_sel    (wave_sel ),
                  
    .dac_data    (dac_data )

);
endmodule
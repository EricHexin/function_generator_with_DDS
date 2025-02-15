`timescale 1ns/1ns
module tb_dds_top();

reg         sys_clk;
reg         sys_rst_n;
reg [3:0]   key     ;


wire [7:0]  dac_data;
wire        dac_clk;

initial
    begin
        sys_clk     <= 1'b1;
        sys_rst_n   <= 1'b0;
        key    <= 4'b1111;
        #200
        sys_rst_n   <= 1'b1;
        #10000
        key    <= 4'b1110;
        #8000000       // make sure the time here is longer than the period
        key    <= 4'b1101;
        #8000000
        key    <= 4'b1011;
        #8000000
        key    <= 4'b0111;
        #8000000
        key    <= 4'b1110;
    
    end
    
    
always #10 sys_clk <= ~sys_clk;
    
    
dds dds_top_inst
(
    .sys_clk    (sys_clk  ),
    .sys_rst_n  (sys_rst_n),
    .key        (key      ),
                 
    .dac_clk    (dac_clk  ),
    .dac_data   (dac_data )

);  
    
    

endmodule
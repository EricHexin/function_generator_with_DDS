module dds
(
    input   wire            sys_clk ,
    input   wire            sys_rst_n,
    input   wire    [3:0]   key     ,
    
    output  wire            dac_clk ,
    output  wire    [7:0]   dac_data

);


wire    [3:0]   wave_sel;
assign dac_clk = ~sys_clk;


key_ctrl    key_ctrl_inst
(
    .sys_clk     (sys_clk  ),
    .sys_rst_n   (sys_rst_n),
    .key         (key      ),
                    
    .wave_sel    (wave_sel )

 );


dds_ctrl    dds_ctrl_inst
(
    .sys_clk  (sys_clk  ),
    .sys_rst_n(sys_rst_n),
    .wave_sel (wave_sel ),
      
    .dac_data (dac_data )

);


endmodule
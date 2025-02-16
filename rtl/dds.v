module dds
(
    input   wire            sys_clk ,
    input   wire            sys_rst_n,
    input   wire    [3:0]   key     ,
    
    output  wire            dac_clk ,
    output  wire    [7:0]   dac_data

);


wire [1:0]   waveform_counter;      //00,01,10 and 11 for the four wave forms.
wire [4:0]   freq_counter;               //register to tune the frequency from 500 Hz to 1.5 MHz
wire [4:0]   freq_counter2;
assign dac_clk = ~sys_clk;


key_ctrl    key_ctrl_inst
(
    .sys_clk     (sys_clk  ),
    .sys_rst_n   (sys_rst_n),
    .key         (key      ),
                    
    .waveform_counter    (waveform_counter ),
    .freq_counter       (freq_counter),
    .freq_counter2       (freq_counter2)

 );


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